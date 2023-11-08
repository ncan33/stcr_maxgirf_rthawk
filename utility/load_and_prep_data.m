function [kspace, kx, ky, header, maxgirf_vars, DCF] = load_and_prep_data( ...
    nr_arms_per_frame, TR_to_trim, paths)
    
    % This function loads Pulseq data, reshapes, and scales the data.

    %% Import thirdparty libraries
    addpath(genpath('./thirdparty/lowfield_maxgirf'))

    %% Load data
    [paths, header] = load_rthawk_file(paths);
    [kspace, k_rcs, header, maxgirf_vars] = load_ismrmrd_file(paths, header);
    
    %% Reshape kspace and trajectory
    kspace = permute(squeeze(kspace), [1, 2, 4, 3]);
    kx = squeeze(k_rcs(1,:,:)) / (2 * header.krmax); % range of kx is [-0.5, 0.5]
    ky = squeeze(k_rcs(2,:,:)) / (2 * header.krmax); % range of ky is [-0.5, 0.5]

    % trim TR for steady state.
    kspace = kspace(:, TR_to_trim+1:end, :, :);
    view_order = header.view_order;
    view_order = view_order(TR_to_trim+1:end);
    header.trimmed_view_order = view_order;

    GA_steps = size(kx, 2);
    Narms_total = size(kspace, 2); header.Narms_total = Narms_total;
    Nframes = floor(Narms_total / nr_arms_per_frame);
    Narms_total = Nframes * nr_arms_per_frame;
    Nsample = size(kspace, 1);

    kx = repmat(kx, [1, ceil(Narms_total / GA_steps)]);
    ky = repmat(ky, [1, ceil(Narms_total / GA_steps)]);

    kspace(:, Narms_total + 1 : end, :, :) = [];
    view_order(Narms_total + 1 : end) = [];

    kx = kx(:, view_order);
    ky = ky(:, view_order);

    % reshape kspace
    kspace = reshape(kspace, [Nsample, nr_arms_per_frame, Nframes, header.nr_coils]);

    Nsample_k = size(kx, 1);

    % reshape trajectory
    kx = reshape(kx, [Nsample_k, nr_arms_per_frame, Nframes]);
    ky = reshape(ky, [Nsample_k, nr_arms_per_frame, Nframes]);

    % DCF
    DCF = squeeze(calculate_dcf(k_rcs, header));

    %pre-weight kspace by sqrt(DCF) and then encode into image.
    kspace = kspace .* sqrt(DCF(:,1));

end