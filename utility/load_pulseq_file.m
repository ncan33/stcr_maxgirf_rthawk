function [paths, header] = load_pulseq_file(paths)
    %% Add Pulseq filepaths to paths struct
    paths.siemens_twix_file = fullfile(paths.folder, [paths.name, '.dat']); 
    paths.ismrmrd_data_file = fullfile(paths.folder, [paths.name, '.h5']); 
    paths.ismrmrd_noise_file = fullfile(paths.folder, ['noise_', paths.name, '.h5']);
    paths.ismrmrd_traj_file = fullfile(paths.folder, paths.traj);
    paths.seq_file = fullfile(paths.folder, paths.seq);
    
    %% Read a .seq file
    seq = mr.Sequence;
    seq.read(paths.seq_file);

    %% Parse parameters
    header.base_resolution = seq.getDefinition('BaseResolution');
    header.discard_post    = seq.getDefinition('DiscardPost');
    header.discard_pre     = seq.getDefinition('DiscardPre');
    header.real_dwell_time = seq.getDefinition('RealDwellTime'); % [sec]
    header.nr_averages     = seq.getDefinition('Averages');
    header.nr_interleaves  = seq.getDefinition('Interleaves');
    header.grad_samples    = seq.getDefinition('GradSamples');
    header.fov             = seq.getDefinition('FOV');
    header.slice_thickness = seq.getDefinition('SliceThickness');

    %% Get resolution and matrix size
    res_x = header.base_resolution / (header.fov(1) * 1000); % units: mm
    res_y = header.base_resolution / (header.fov(1) * 1000); % units: mm
    header.res_mm = [res_x, res_y]; % units: mm

    header.matrix_size = ceil([header.fov(1), header.fov(2)] ./ res);

    %% Adjustments for dynamic recon
    header.nr_fully_sampled_frames = header.nr_averages;  

    view_order_type = 'linear';
    switch view_order_type
        case 'linear'
            fully_sampled_view = 1:header.nr_interleaves;
            header.view_order = repmat(fully_sampled_view, 1, header.nr_fully_sampled_frames);
    end
end