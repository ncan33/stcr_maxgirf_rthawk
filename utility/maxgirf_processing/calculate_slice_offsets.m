function [r_dcs] = calculate_slice_offsets(header, coord)
    %% Get matrix sizes
    Nx = header.matrix_size(1);
    Ny = header.matrix_size(2);
    Nz = 1;
    
    %% Calculate spatial coordinates in the RCS [m]
    encoded_resolution = [header.res(1), header.res(2), header.slice_thickness];
    scaling_matrix = diag(encoded_resolution);
    [I1,I2,I3] = ndgrid((1:Nx).', (1:Ny).', (1).');
    r_rcs = scaling_matrix * cat(1, I1(:).' - (floor(Nx/2) + 1), I2(:).' ...
        - (floor(Ny/2) + 1), I3(:).' - (floor(Nz/2) + 1)); % 3 x N

    %% Calculate spatial coordinates in the DCS [m]
    N = Nx * Ny * Nz;
    r_dcs = repmat(coord.dcs_offsets, [1 N]) + coord.R_rcs2dcs * r_rcs; % 3 x N

end

