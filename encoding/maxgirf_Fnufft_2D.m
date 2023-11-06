 function ob = maxgirf_Fnufft_2D(kx, ky, u, v, nc, matrix_size, useGPU, w, FOV_oversamp, kernel_size)
%function ob = Fnufft2D([mask,] args)
%|
%| Do fourier encoding (F) for dynamic 2D operators.
%| 
%| Inputs:
%|     kx: size(nread x ns x nframe)
%|     ky: size(nread x ns x nframe)
%|     u: size(nread x L x nframe)
%|     v: size((nx * ny) x L x nframe)
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
    nc double
    matrix_size (:,:) double
    useGPU double = 0
    w (:,1) double = ones(size(kx,1), 1)
    FOV_oversamp double = 1
    kernel_size (2,1) = [4,4]
end
%}

[nread, ns, nframe] = size(kx);

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
    [nx, ny, ~, ~] = size(x);
    y = NUFFT.NUFFT(x, arg) / sqrt(nx * ny);
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
        x = x + reshape(v(:,ell) .* reshape(FHDuHd, [prod(matrix_size), nframe, ncoil]), size_x);
    end
end
