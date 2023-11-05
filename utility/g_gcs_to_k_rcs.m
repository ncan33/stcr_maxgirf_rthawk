function [k_rcs] = g_gcs_to_k_rcs(g_gcs, header, coord)
    %% Define the gyromagnetic ratio for 1H
    gamma = 4257.59 * (1e4 * 2 * pi); % gyromagnetic ratio for 1H [rad/sec/T]

    %% Numerically integrate gradients to get the trajectory
    % [rad/sec/T] * [mT/m] * [T/1e3 mT] * [sec] => * 1e-3 [rad/m]
    k_gcs = cumsum(gamma * g_gcs * 1e-3 * header.real_dwell_time, 2); % 3x Nk x Ni x Ne [rad/m]
    
    %% Calculate GIRF-predicted k-space trajectories in the RCS [rad/m] [R,C,S]
    k_rcs = zeros(3, header.nr_samples, header.nr_interleaves, 'double');
    for i = 1:header.nr_interleaves
        k_rcs(:,:,i) = coord.R_rcs2gcs.' * k_gcs(:,:,i); % 3 x Nk
    end
end