function [paths, header] = load_rthawk_file(paths)
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

    %% Parse parameters
    header.base_resolution = kspace_info.user_FieldofViewX;
    header.real_dwell_time = 2e-6; % [sec]
    %header.nr_averages     = seq.getDefinition('Averages');
    header.nr_interleaves  = kspace_info.user_interleaves;
    header.grad_samples    = size(kspace_info.kx, 1);
    %header.arm_samples     = seq.getDefinition('ArmSamples');
    header.fov             = [kspace_info.user_FieldOfViewX;
                              kspace_info.user_FieldOfViewY
                              kspace_info.user_SliceThickness] / 1000;
    header.slice_thickness = kspace_info.user_SliceThickness / 1000;

    %% Get resolution and matrix size
    res_x = (header.base_resolution / (header.fov(1) * 1000)) / 1000; % units: mm
    res_y = (header.base_resolution / (header.fov(2) * 1000)) / 1000; % units: mm
    header.res = [res_x, res_y]; % units: m

    header.matrix_size = ceil([header.fov(1), header.fov(2)] ./ header.res);

    %% Adjustments for dynamic recon
    header.nr_fully_sampled_frames = header.nr_averages;  

    view_order_type = 'linear';
    switch view_order_type
        case 'linear'
            fully_sampled_view = 1:header.nr_interleaves;
            header.view_order = repmat(fully_sampled_view, 1, header.nr_fully_sampled_frames);
    end
end