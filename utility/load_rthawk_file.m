function [paths, header] = load_rthawk_file(paths)
    %% Read a RTHawk .mat file
    file_name = fullfile(paths.path, paths.name);
    load(file_name);

    %% Parse parameters
    header.base_resolution = seq.getDefinition('BaseResolution');
    header.discard_pre     = seq.getDefinition('DiscardPre');
    header.real_dwell_time = seq.getDefinition('RealDwellTime'); % [sec]
    header.nr_averages     = seq.getDefinition('Averages');
    header.nr_interleaves  = seq.getDefinition('Interleaves');
    header.grad_samples    = seq.getDefinition('GradSamples');
    header.arm_samples     = seq.getDefinition('ArmSamples');
    header.fov             = seq.getDefinition('FOV');
    header.slice_thickness = seq.getDefinition('SliceThickness');

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