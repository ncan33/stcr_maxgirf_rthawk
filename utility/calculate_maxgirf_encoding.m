function [u, v, para] = calculate_maxgirf_encoding(nr_arms_per_frame, ...
    TR_to_trim, header, maxgirf_vars)
    % [u, v] = calculate_maxgirf_encoding(paths, header, maxgirf_vars)
    % Calculate MaxGIRF encoding for Pulseq
    
    %% Add MaxGIRF path
    addpath(genpath('./thirdparty/lowfield_maxgirf'))
    
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
    
    Nx = header.matrix_size(1);
    Ny = header.matrix_size(2);
    
    view_order(nr_arms_total + 1 : end) = [];
    header.view_order_trimmed = view_order;
    
    %g_dcs = reshape_g_dcs(g_dcs, nr_samples, nr_arms_per_frame, ...
    %    nr_frames, nr_arms_total, nr_interleaves, view_order);

    g_dcs = repmat(g_dcs, [1, 1, 1, nr_frames]);

    %% Define parameters for spiral recon
    para = [];
    [para] = define_spiral_recon_parameters(para);
    
    %% Calculate the time courses of phase coefficients (Nk x Nl x Narm_frame x Nf) [rad/m], [rad/m^2], [rad/m^3]
    gamma = 4257.59 * (1e4 * 2 * pi); % gyromagnetic ratio for 1H [rad/sec/T]
    
    k = zeros(nr_samples, para.Nl, nr_arms_per_frame, nr_frames);
    for frame = 1:nr_frames
        gx = reshape(g_dcs(1, :, :, frame), [nr_samples nr_arms_per_frame]);
        gy = reshape(g_dcs(2, :, :, frame), [nr_samples nr_arms_per_frame]);
        gz = reshape(g_dcs(3, :, :, frame), [nr_samples nr_arms_per_frame]);

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
    
    %% Calculate slice offsets f
    r_dcs = calculate_slice_offsets(header, coord);
    
    %% Calculate concomitant field basis functions (N x Nl) [m], [m^2], [m^3]
    fprintf('%s:(%2d/%2d) Calculating concomitant field basis functions... ', datetime, frame, nr_arms_per_frame);
    p = calculate_concomitant_field_basis(r_dcs(1,:), r_dcs(2,:), r_dcs(3,:), para.Nl);
    disp([newline, 'done!']);
    
    %% Prepare a static off-resonance map [Hz]
    B0map = zeros(Nx, Ny, nr_frames, 'double');

    %% Calculate u and v for each frame
    u_all = zeros(nr_samples, para.Lmax, nr_frames);
    v_all = zeros(Nx*Ny, para.Lmax, nr_frames);
    for frame = 1:nr_frames
        [u, v] = calculate_encoding_matrix(squeeze(k_bar(:, :, frame)), ...
            p, B0map, t, frame, nr_frames, para);
        
        u_all(:, :, frame) = u;
        v_all(:, :, frame) = v;
    end
    
    u = u_all;
    v = v_all;
end
