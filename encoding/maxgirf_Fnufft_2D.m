 function ob = maxgirf_Fnufft_2D(kx, ky, u, v, para, nc, matrix_size, useGPU, w, FOV_oversamp, kernel_size)
%function ob = Fnufft2D([mask,] args)
%|
%| Do fourier encoding (F) for dynamic 2D operators.
%| 
%| Inputs:
%|     kx: size(nread x ns x nframe)
%|     ky: size(nread x ns x nframe)
%|     u: size(nread x L x nframe)
%|     v: size((nx * ny) x L x nframe)
%|     para: struct
%|     nc: number of coils
%|     matrix_size: size(2 x 1), nx x ny
%|     optional arguments:
%|     w: density compensation across frame (nread x 1)
%|     FOV_oversamp: oversampling 
%|     kernel_size: size(2,1)
%|     
%| Inspired and modified from Jeff Fessler's Gnufft object in the
%| Michigan Image Reconstruction Toolbox (MIRT).
%{
arguments
    kx (:,:,:) double
    ky (:,:,:) double
    u
    v
    para struct
    nc double
    matrix_size (:,:) double
    useGPU double = 0
    w (:,1) double = ones(size(kx,1), 1)
    FOV_oversamp double = 1
    kernel_size (2,1) = [4,4]
end
%}

%% Get size of kx
[nread, ns, nframe] = size(kx);

%% Check for errors in low-rank approximation
if para.Lmax ~= size(u, 2)
    error('Rank of u does not match the rank prescribed while generating u.')
end

%% Construct the N operators for forward model calculation
matrix_size = matrix_size * FOV_oversamp;
N = NUFFT.init(kx*matrix_size(1), ky*matrix_size(2), 1, kernel_size, matrix_size(1), matrix_size(2));
N.W = sqrt(w);

if useGPU
    N.S = gpuArray(N.S);
    N.W = gpuArray(N.W);
    N.Apodizer = gpuArray(N.Apodizer);
end

idim = [matrix_size, nframe, nc];
odim = [nread, ns, nframe, nc];

%u = randn(nread, 20, nframe);
%v = randn(matrix_size(1)*matrix_size(2), 20, nframe);

forw = @(arg, x) maxgirf_Fnufft_forw(arg, x, u, v);
back = @(arg, y) maxgirf_Fnufft_adj(arg, matrix_size, y, u, v);

ob = fatrix2('idim', idim, 'odim', odim, ...
    'does_many', 1, ...
    'forw', forw, 'back', back, 'arg', N);
end

function y = maxgirf_Fnufft_forw(arg, x, u, v)
    [nx, ny, nframe, ncoil] = size(x);
    
    y = zeros([arg.size_data ncoil]);
    
    L = size(u, 2);
    for ell = 1:L

        x_reshaped = reshape(x, [nx*ny, nframe, ncoil]);
        x_reshaped = permute(x_reshaped, [1, 4, 2, 3]);

        vx = conj(v(:,ell,:)) .* x_reshaped;

        FDvHSm = NUFFT.NUFFT(reshape(vx, [nx ny nframe ncoil]), arg) / sqrt(nx * ny);

        y = y + u(:,ell,:) .* FDvHSm;
    end

    y = y .* arg.W;  % multiply by sqrt(dcf).
end


function x = maxgirf_Fnufft_adj(arg, matrix_size, y, u, v)
    %x = NUFFT.NUFFT_adj(y, arg) * sqrt(matrix_size(1) * matrix_size(2));
    nframe = size(y, 3);
    ncoil = size(y, 4);
    
    x = zeros(matrix_size(1), matrix_size(2), nframe, ncoil);
    size_x = size(x);
    
    L = size(u, 2);
    for ell = 1:L
        FHDuHd = NUFFT.NUFFT_adj(conj(u(:, ell, :)) .* y, arg) * sqrt(matrix_size(1) * matrix_size(2));
        
        x = x + reshape(squeeze(v(:,ell,:)) .* reshape(FHDuHd, [prod(matrix_size), nframe, ncoil]), size_x);
    end
end
