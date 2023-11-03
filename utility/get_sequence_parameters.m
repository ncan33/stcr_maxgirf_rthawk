function [var] = get_sequence_parameters(var, paths)
    %% Read a .seq file
    start_time = tic;
    tstart = tic; fprintf('%s: Reading a .seq file: %s... \n', datetime, paths.seq_file);
    seq = mr.Sequence;
    seq.read(paths.seq_file);
    fprintf('%s: done! (%6.4f/%6.4f sec)\n', datetime, toc(tstart), toc(start_time));

    %% Parse parameters
    var.base_resolution = seq.getDefinition('BaseResolution');
    var.discard_post    = seq.getDefinition('DiscardPost');
    var.discard_pre     = seq.getDefinition('DiscardPre');
    var.real_dwell_time = seq.getDefinition('RealDwellTime'); % [sec]
    var.nr_averages     = seq.getDefinition('Averages');
    var.nr_interleaves  = seq.getDefinition('Interleaves');
    var.arm_samples     = seq.getDefinition('ArmSamples');
    var.grad_samples    = seq.getDefinition('GradSamples');
    var.fov             = seq.getDefinition('FOV');
    var.dist_factor     = 0; % seq.getDefinition('DistFactor');
    var.slice_thickness = seq.getDefinition('SliceThickness');
    var.series          = seq.getDefinition('Series');
    
    %% Adjustments for dynamic recon
    var.series = 'Ascending';
    var.nr_fully_sampled_frames = var.nr_averages;
    
end