function [kx, ky, Ncoil, matrix_size, DCF] = load_and_prep_data(paths)
    
    % This function loads Pulseq data, reshapes, and scales the data.

    %% Load data
    [paths, header] = load_pulseq_file(paths);
    
    %% Res
    res_x = [header.base_resolution / (header.fov(1) * 1000)];
    res_x = [header.base_resolution / (header.fov(1) * 1000)];
    res = [res_x, res_y];

res = [kspace_info.user_ResolutionX, kspace_info.user_ResolutionY];         % [mm]
matrix_size = ceil([kspace_info.user_FieldOfViewX, kspace_info.user_FieldOfViewX] ./ res);  
viewOrder = kspace_info.viewOrder;

    %% View order

    % Note: this assumes a linear view-order. This will depend on the
    % m-file generating the .seq file.

    fully_sampled_view = 1:header.nr_interleaves;
    view_order = repmat(fully_sampled_view, 1, header.nr_fully_sampled_frames);

    %% Start Data prep.

    res = [kspace_info.user_ResolutionX, kspace_info.user_ResolutionY];         % [mm]
    matrix_size = ceil([kspace_info.user_FieldOfViewX, kspace_info.user_FieldOfViewX] ./ res);  
    viewOrder = kspace_info.viewOrder;

    % kspace and trajectory
    kspace = permute(kspace, [1, 2, 4, 3]);
    kx = kspace_info.kx_GIRF;
    ky = kspace_info.ky_GIRF;

    % trim TR for steady state.
    kspace = kspace(:, TRtoTrim+1:end, :, :);
    viewOrder = viewOrder(TRtoTrim+1:end);

    GA_steps = size(kx, 2);
    Narms_total = size(kspace, 2);
    Nframes = floor(Narms_total / Narms_per_frame);
    Narms_total = Nframes * Narms_per_frame;
    Ncoil = size(kspace, 4);
    Nsample = size(kspace, 1);

    kx = repmat(kx, [1, ceil(Narms_total / GA_steps)]);
    ky = repmat(ky, [1, ceil(Narms_total / GA_steps)]);

    kspace(:, Narms_total + 1 : end, :, :) = [];
    viewOrder(Narms_total + 1 : end) = [];

    kx = kx(:, viewOrder);
    ky = ky(:, viewOrder);

    % reshape kspace
    kspace = reshape(kspace, [Nsample, Narms_per_frame, Nframes, Ncoil]);

    Nsample_k = size(kx, 1);

    % reshape trajectory
    kx = reshape(kx, [Nsample_k, Narms_per_frame, Nframes]);
    ky = reshape(ky, [Nsample_k, Narms_per_frame, Nframes]);

    % DCF 
    DCF = kspace_info.DCF;

    %pre-weight kspace by sqrt(DCF) and then encode into image.
    kspace = kspace .* sqrt(DCF(:,1));
end