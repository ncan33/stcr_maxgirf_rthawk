function [paths, header] = load_pulseq_file(paths)
    %% Add Pulseq filepaths to paths struct
    paths.siemens_twix_file = fullfile(paths.folder, [paths.name, '.dat']); 
    paths.ismrmrd_data_file = fullfile(paths.folder, [paths.name, '.h5']); 
    paths.ismrmrd_noise_file = fullfile(paths.folder, ['noise_', paths.name, '.h5']);
    paths.ismrmrd_traj_file = fullfile(paths.folder, paths.traj);
    paths.seq_file = fullfile(paths.folder, paths.seq);
    
    %{
    siemens_twix_file = ls(fullfile(paths.folder, [paths.name, '.dat'])); 
    ismrmrd_data_file = ls(fullfile(paths.folder, [paths.name, '.h5'])); 
    ismrmrd_noise_file = ls(fullfile(paths.folder, ['noise_', paths.name, '.h5']));
    ismrmrd_traj_file = ls(fullfile(paths.folder, paths.traj));
    seq_file = ls(fullfile(paths.folder, paths.seq));

    paths.siemens_twix_file = siemens_twix_file(1:end-1);
    paths.ismrmrd_data_file = ismrmrd_data_file(1:end-1);
    paths.ismrmrd_noise_file = ismrmrd_noise_file(1:end-1);
    paths.ismrmrd_traj_file = ismrmrd_traj_file(1:end-1);
    paths.seq_file = seq_file(1:end-1);
    %}
    %% Read a .seq file
    addpath('./thirdparty/pulseq/matlab');
    seq = mr.Sequence;
    seq.read(paths.seq_file);

    %% Parse parameters
    header.base_resolution = seq.getDefinition('BaseResolution');
    header.discard_post    = seq.getDefinition('DiscardPost');
    header.discard_pre     = seq.getDefinition('DiscardPre');
    header.real_dwell_time = seq.getDefinition('RealDwellTime'); % [sec]
    header.nr_averages     = seq.getDefinition('Averages');
    header.nr_interleaves  = seq.getDefinition('Interleaves');
    header.arm_samples     = seq.getDefinition('ArmSamples');
    header.grad_samples    = seq.getDefinition('GradSamples');
    header.fov             = seq.getDefinition('FOV');
    header.slice_thickness = seq.getDefinition('SliceThickness');
    
    %% Adjustments for dynamic recon
    header.nr_fully_sampled_frames = header.nr_averages;

end