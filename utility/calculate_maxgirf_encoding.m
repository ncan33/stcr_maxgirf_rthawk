function [u, v, para] = calculate_maxgirf_encoding(nr_arms_per_frame, ...
    TR_to_trim, k_rcs, DCF, paths, header, maxgirf_vars)
    % [u, v] = calculate_maxgirf_encoding(paths, header, maxgirf_vars)
    % Calculate MaxGIRF encoding for Pulseq
    
    %% Extract variables from the maxgirf_vars struct
    g_dcs = maxgirf_vars.g_dcs; % (3 x Nk x Ni)
    mrd = maxgirf_vars.mrd;
    coord = maxgirf_vars.coord;
    
    %% Reshape g_dcs: (3 x Nk x Ni) --> (3 x Nk x Narm_frame x Nf)
    view_order = header.view_order;
    view_order = view_order(TR_to_trim+1:end);
    
    nr_interleaves = size(g_dcs, 3);
    nr_arms_total = length(view_order);
    nr_frames = floor(nr_arms_total / nr_arms_per_frame);
    nr_arms_total = nr_frames * nr_arms_per_frame;
    nr_samples = header.nr_samples;
    
    view_order(nr_arms_total + 1 : end) = [];
    header.view_order_trimmed = view_order;
    
    g_dcs = reshape_g_dcs(g_dcs, nr_samples, nr_arms_per_frame, ...
        nr_frames, view_order);
    k_rcs = reshape_g_dcs(k_rcs, nr_samples, nr_arms_per_frame, ...
        nr_frames, view_order); % reshape k_rcs in the same way as g_dcs
    
    %% Define parameters for spiral recon
    para = [];
    [para] = define_spiral_recon_parameters(para);
    
    %% Set up BART commands
    [paths] = bart_setup(paths);
    
    %% Calculate the time courses of phase coefficients (Nk x Nl x Narm_frame x Nf) [rad/m], [rad/m^2], [rad/m^3]
    gamma = 4257.59 * (1e4 * 2 * pi); % gyromagnetic ratio for 1H [rad/sec/T]
    
    k = zeros(nr_samples, para.Nl, nr_arms_per_frame, nr_frames);
    for frame = 1:nr_frames
        gx = reshape(g_dcs(1, :, :, frame), [nr_samples nr_interleaves]);
        gy = reshape(g_dcs(2, :, :, frame), [nr_samples nr_interleaves]);
        gz = reshape(g_dcs(3, :, :, frame), [nr_samples nr_interleaves]);

        k(:, :, :, frame) = calculate_concomitant_field_coefficients( ...
            gx, gy, gz, para.Nl, header.B0, gamma, header.real_dwell_time);
    end
    
    %% Calculate the average of k (Nk x Nl x Nf)
    k_bar = zeros(nr_samples, para.Nl, nr_frames);
    
    for frame = 1:nr_frames
        k_bar(:, :, frame) = mean(squeeze(k(:, :, :, frame)), 3); % Nk x Nl
    end

    %% Calculate a time vector [sec]
    t = (0:nr_samples - 1).' * header.real_dwell_time; % Nk x 1 [sec]
    
    %% Calculate k-space trajectories for BART
    traj = zeros(3, nr_samples, nr_interleaves, nr_frames, 'single');
    
    for frame = 1:nr_frames
        traj(1, :, :, frame) = -k_rcs(1,:,:) / (2 * header.krmax); %* header.matrix_size(1);
        traj(2, :, :, frame) = -k_rcs(2,:,:) / (2 * header.krmax); %* header.matrix_size(2);
        traj(3, :, :, frame) = -k_rcs(3,:,:) / (2 * header.krmax); %* 1;
    end
    
    %{
    
    %}
end
