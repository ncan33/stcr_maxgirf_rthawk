function image_coil_combined = recon_2d(nr_arms_per_frame, TR_to_trim, ...
    area, which_file, useGPU)
    % written by Nejat Can
    % template by Prakash Kumar and Ecrin Yagiz
    % 2D gridding recon using a "Fatrix" encoding operator.

    arguments
        nr_arms_per_frame = 61
        TR_to_trim = 0
        area = 'lung'
        which_file = 1
        useGPU = 1
    end

    close all

    %% Setup paths
    addpath(genpath('./encoding/'))
    addpath(genpath('./utility/'))
    addpath('./thirdparty')

    %% Select which dataset to use [See select_dataset.m]
    paths = select_dataset(area, which_file);

    %% Load Data and prep
    [kspace, kx, ky, header, ~, DCF] = load_and_prep_data( ...
    nr_arms_per_frame, TR_to_trim, paths);

    %% Encoding
    oversampling = 1; % oversampling factor

    % construct encoding operator F
    F = Fnufft_2D(kx, ky, header.nr_coils, header.matrix_size, useGPU, DCF(:,1), oversampling, [4,4]);

    % adjoint test on the operator F (optional)
    test_fatrix_adjoint(F);
    
    % encode kspace into image
    image = F' * kspace;

    % estimate sensitivity maps
    sens = get_sens_map(image, '2D');

    % C = 2D coil operator
    C = C_2D(size(image), sens);
    image_coil_combined = C' * image;

end
 