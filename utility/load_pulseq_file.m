function [paths, header] = load_pulseq_file(paths)
    %% Add Pulseq filepaths to paths struct
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

    %% Read a .seq file
    seq = mr.Sequence;
    seq.read(paths.seq_file);

    %% Parse Pulseq header
    header = get_sequence_parameters();
end