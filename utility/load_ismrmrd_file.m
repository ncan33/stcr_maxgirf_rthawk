function [kspace, k_rcs, header, maxgirf_vars] = load_ismrmrd_file(paths, header)
    %% Load trajectory and kspace
    %--------------------------------------------------------------------------
    % k-space trajectory
    %--------------------------------------------------------------------------
    if exist(paths.ismrmrd_traj_file, 'file')
        mrd.traj_dset = ismrmrd.Dataset(paths.ismrmrd_traj_file, 'dataset');
    else
        error('File %s does not exist.  Please generate it.' , paths.ismrmrd_traj_file);
    end

    %--------------------------------------------------------------------------
    % k-space data
    %--------------------------------------------------------------------------
    if exist(paths.ismrmrd_data_file, 'file')
        mrd.data_dset = ismrmrd.Dataset(paths.ismrmrd_data_file, 'dataset');
    else
        error('File %s does not exist.  Please generate it.' , paths.ismrmrd_data_file);
    end
    
    mrd.raw_traj = mrd.traj_dset.readAcquisition();
    mrd.raw_data = mrd.data_dset.readAcquisition();
    
    %% Get header information from ISMRMRD files
    % durations
    header.grad_raster_time = double(max(mrd.raw_traj.head.sample_time_us ...
        )) * 1e-6; % [usec] * [sec/1e-6 usec] => [sec]
    header.readout_duration = double(header.grad_samples * header.grad_raster_time); % readout duration [sec]
    
    % scanner info
    header.nr_coils = double(max(mrd.raw_data.head.active_channels));
    header.B0 = double(ismrmrd.xml.deserialize(mrd.data_dset.readxml ...
        ).acquisitionSystemInformation.systemFieldStrength_T); % [Tesla]

    % acquisition
    header.nr_arms_total = double(max(mrd.raw_data.head.idx.kspace_encode_step_1)) ...
        + 1; % total number of interleaves
    header.patient_position = ismrmrd.xml.deserialize(mrd.data_dset.readxml ...
        ).measurementInformation.patientPosition;
    
    % number of samples
    header.center_sample = double(max(mrd.raw_data.head.center_sample));
    header.nr_samples = double(floor(header.arm_samples * ...
        header.grad_raster_time / header.real_dwell_time));

    %% Maximum k-space value [rad/m]
    header.krmax = 2 * pi / (header.fov(1) / header.matrix_size(1)) / 2; % [rad/m]

    %% Calculate the receiver noise matrix for pre-whitening of kspace (Nc x Nc)
    [~, inv_L] = calculate_receiver_noise_matrix(paths.ismrmrd_noise_file);

    %% Get kspace
    samples_index_range = ((header.discard_pre + 1):(header.nr_samples ...
        + header.discard_pre)).'; % samples to keep

    kspace = zeros(1, header.nr_samples, header.nr_arms_total, header.nr_coils);
    for i = 1:header.nr_arms_total
        readout = mrd.raw_data.data{i}; % load readout (Nk x Nc)
        readout = (inv_L * readout.').'; % pre-whiten raw data
        kspace(:,:,i,:) = reshape(readout(samples_index_range,:), ...
            [1 header.nr_samples 1 header.nr_coils]); % kspace will be (1 x Nk x Narm_tot x Nc)
    end

    %% Get nominal trajectory in GCS
    k_gcs_nominal = zeros(3, header.grad_samples, header.nr_interleaves, ...
        'single'); % kspace trajectory in GCS (gradient coordinate system)

    for i = 1:header.nr_interleaves
    	k_gcs_nominal(:,:,i) = mrd.raw_traj.traj{i};
    end

    %% Calculate coordinate transformation matrices
    [coord] = load_coord_info_from_twix(paths);
    [coord] = calculate_coordinate_transformations(header, coord);

    %% Convert nominal trajectory in GCS to GIRF-corrected gradient waveform in DCS
    [g_dcs, g_gcs] = k_gcs_nominal_to_g_dcs(k_gcs_nominal, header, coord);
    
    %% Convert nominal trajectory in GCS to GIRF-corrected gradient waveform in DCS
    [k_rcs] = g_gcs_to_k_rcs(g_gcs, header, coord);

    %% Store variables needed by MaxGIRF into a struct called maxgirf_vars
    maxgirf_vars.g_dcs = g_dcs;
    maxgirf_vars.mrd = mrd;
    maxgirf_vars.coord = coord;

end