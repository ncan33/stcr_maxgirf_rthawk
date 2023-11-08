function [g_dcs, coord] = calculate_maxgirf_vars(kx, ky, kspace_info, header)
    %% Calculate coordinate transformation matrices
    coord = calculate_coordinate_transformations(kspace_info, header);

    %% Get nominal k-space trajectories in the RCS [rad/m] [R,C,S]
    %--------------------------------------------------------------------------
    % traj: 1 x Nk * Ni * 3 x M in [-0.5,0.5]
    % [kr(1), kc(1), dcf(1), kr(2), kc(2), dcf(2), ...]
    %--------------------------------------------------------------------------
    k_rcs = zeros(3, header.nr_samples, header.nr_interleaves, 'double');
    k_rcs(1,:,:) = kx * (2 * header.krmax); % [rad/m]
    k_rcs(2,:,:) = ky * (2 * header.krmax); % [rad/m]

    %% Calculate nominal gradient waveforms in the RCS [mT/m] [R,C,S]
    gamma = 4257.59 * (1e4 * 2 * pi); % gyromagnetic ratio for 1H [rad/sec/T]
    % [rad/m] / [rad/sec/T] / [sec] * [1e3mT/T] => *1e3 [mT/m]
    g_rcs = diff(cat(2, zeros(3, 1, header.nr_interleaves), ...
        k_rcs), 1, 2) / (gamma * header.grad_raster_time) * 1e3; % [mT/m]

    %% Calculate GIRF-predicted gradient waveforms in the DCS [mT/m] [x,y,z]
    g_dcs = zeros(3, header.nr_samples, header.nr_interleaves, 'double');
    for i = 1:header.nr_interleaves
        g_dcs(:, :, i) = coord.R_rcs2dcs * g_rcs(:, :, i); % 3 x Nk
    end
end