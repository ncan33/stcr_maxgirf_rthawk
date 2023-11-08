function [kspace, kx, ky, kspace_info, header] = load_rthawk_file(paths)
    %% Read a .json file
    fid = fopen('rthawk_recon.json'); 
    json_txt = fread(fid, [1 inf], 'char=>char'); 
    fclose(fid);
    json = jsondecode(json_txt);

    %--------------------------------------------------------------------------
    % Define the full path of a filename
    %--------------------------------------------------------------------------
    %dat_path    = json.dat_path;
    %output_path = json.output_path;

    %% Read a RTHawk .mat file
    file_name = fullfile(paths.path, paths.name);
    S = load(file_name);

    kspace = S.kspace;
    kspace_info = S.kspace_info;
    kx = kspace_info.kx_GIRF;
    ky = kspace_info.ky_GIRF;

    %% Parse parameters 
    %header.nr_averages     = seq.getDefinition('Averages');
    %header.arm_samples     = seq.getDefinition('ArmSamples');

    % scanner info
    header.nr_coils = kspace_info.extent(2);
    header.B0 = json.B0; % [Tesla]

    % acquisition
    header.slice_thickness = kspace_info.user_SliceThickness / 1000;
    header.fov             = [kspace_info.user_FieldOfViewX;
                              kspace_info.user_FieldOfViewY
                              kspace_info.user_SliceThickness] / 1000;
    header.nr_interleaves  = size(kspace_info.kx, 2); %kspace_info.user_interleaves;
    header.nr_arms_total = length(kspace_info.viewOrder); % total number of interleaves
    header.patient_position = json.patient_position;
    header.base_resolution = kspace_info.user_FieldOfViewX;
    
    % number of samples
    header.grad_samples = size(kspace_info.kx, 1);
    %header.center_sample = double(max(mrd.raw_data.head.center_sample));
    header.nr_samples = kspace_info.user_samples;

    % durations
    header.grad_raster_time = 2e-6;
    header.readout_duration = double(header.grad_samples * header.grad_raster_time); % readout duration [sec]
    header.real_dwell_time = 2e-6; % [sec]
    
    disp(['Please double check that the patient position is ', header.patient_position])
    
    %% Get resolution and matrix size
    res_x = (header.base_resolution / (header.fov(1) * 1000)) / 1000; % units: mm
    res_y = (header.base_resolution / (header.fov(2) * 1000)) / 1000; % units: mm
    header.res = [res_x, res_y]; % units: m

    header.matrix_size = ceil([header.fov(1), header.fov(2)] ./ header.res);

    %% Adjustments for dynamic recon
    header.nr_fully_sampled_frames = floor(length(kspace_info.viewOrder)/header.nr_interleaves);
    header.view_order = kspace_info.viewOrder;
    
    %% Maximum k-space value [rad/m]
    header.krmax = 2 * pi / (header.fov(1) / header.matrix_size(1)) / 2; % [rad/m]

end