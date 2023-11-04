function [kspace, kx, ky, header, DCF] = load_and_prep_data( ...
    nr_arms_per_frame, TR_to_trim, paths)
    
    % This function loads Pulseq data, reshapes, and scales the data.

    %% Import thirdparty libraries
    addpath('./thirdparty/pulseq/matlab')
    addpath('./thirdparty/mapVBVD')
    addpath('./thirdparty/lowfield_maxgirf/geometry')
    addpath('./thirdparty/sdc3')
    addpath('./thirdparty/ismrmrd/matlab')
 
    %% Load data
    [paths, header] = load_pulseq_file(paths);
    [kspace, k_rcs, g_dcs, header, mrd, coord] = load_ismrmrd_file(paths, header);

    clear g_dcs
    clear mrd
    clear coord

    %% reshape kspace and trajectory
    kspace = permute(kspace, [1, 2, 4, 3]);
    kx = k_rcs(1);
    ky = k_rcs(2);

    % trim TR for steady state.
    kspace = kspace(:, TR_to_trim+1:end, :, :);
    view_order = header.view_order(TR_to_trim+1:end);

    GA_steps = size(kx, 2);
    Narms_total = size(kspace, 2);
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
    kspace = reshape(kspace, [Nsample, Narms_per_frame, Nframes, header.nr_coils]);

    Nsample_k = size(kx, 1);

    % reshape trajectory
    kx = reshape(kx, [Nsample_k, Narms_per_frame, Nframes]);
    ky = reshape(ky, [Nsample_k, Narms_per_frame, Nframes]);

    % DCF 
    DCF = squeeze(calculate_dcf(k_rcs, header));

    %pre-weight kspace by sqrt(DCF) and then encode into image.
    kspace = kspace .* sqrt(DCF(:,1));

end