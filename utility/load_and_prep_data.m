function [kspace, kx, ky, header, g_dcs, coord, DCF] = load_and_prep_data( ...
    nr_arms_per_frame, TR_to_trim, paths)
    
    % This function loads Pulseq data, reshapes, and scales the data.

    %% Import thirdparty libraries
    addpath(genpath('./thirdparty/lowfield_maxgirf'))

    %% Load data
    [kspace, kx, ky, kspace_info, header] = load_rthawk_file(paths);

    %% Calculate MaxGIRF variables
    [g_dcs, coord] = calculate_maxgirf_vars(kx, ky, kspace_info, header);

    %% Reshape kspace and trajectory
    kspace = kspace(:, TR_to_trim+1:end, :, :); % trim TR
    view_order = header.view_order;
    view_order = view_order(TR_to_trim+1:end);
    header.trimmed_view_order = view_order;

    GA_steps = size(kx, 2);
    Narms_total = size(kspace, 2);
    Nframes = floor(Narms_total / nr_arms_per_frame);
    Narms_total = Nframes * nr_arms_per_frame;
    Nsample = size(kspace, 1);
    
    % quick sanity check
    if header.nr_arms_total ~= Narms_total || header.nr_frames ~= Nframes
        error('There is a bug.')
    end

    kx = repmat(kx, [1, ceil(Narms_total / GA_steps)]);
    ky = repmat(ky, [1, ceil(Narms_total / GA_steps)]);

    kspace(:, Narms_total + 1 : end, :, :) = [];
    view_order(Narms_total + 1 : end) = [];
    header.view_order_trimmed = view_order;
    
    kx = kx(:, view_order);
    ky = ky(:, view_order);
    
    % reshape kspace
    kspace = reshape(kspace, [Nsample, nr_arms_per_frame, Nframes, header.nr_coils]);

    Nsample_k = size(kx, 1);

    % reshape trajectory
    kx = reshape(kx, [Nsample_k, nr_arms_per_frame, Nframes]);
    ky = reshape(ky, [Nsample_k, nr_arms_per_frame, Nframes]);

    % DCF
    DCF = kspace_info.DCF;

    %pre-weight kspace by sqrt(DCF) and then encode into image.
    kspace = kspace .* sqrt(DCF(:,1));

end