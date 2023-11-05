function image_coil_combined = recon_2d(nr_arms_per_frame, TR_to_trim, useGPU)
    % Nejat Can, Prakash Kumar, Ecrin Yagiz
    % 2D gridding recon using a "Fatrix" encoding operator.

    arguments
        nr_arms_per_frame = 30
        TR_to_trim = nr_arms_per_frame * 20
        useGPU = 1
    end

    close all; clc

    %% Setup paths
    addpath(genpath('./encoding/'))
    addpath(genpath('./utility/'))
    setup()

    %% Select which dataset to use [See select_dataset.m]
    area = 'pulseq_lung'; which_file = 0;
    paths = select_dataset(area, which_file);

    %% Load Data and prep
    [kspace, kx, ky, header, DCF] = load_and_prep_data(nr_arms_per_frame, ...
    TR_to_trim, paths);

    %% Encoding operators:

    % construct encoding operator F
    F = Fnufft_2D(kx, ky, header.nr_coils, header.matrix_size, useGPU, DCF(:,1), 1, [4,4]);

    % adjoint test on the operator F (optional)
    test_fatrix_adjoint(F);
    
    %encode kspace into image
    image = F' * kspace;

    % estimate sensitivity maps
    sens = get_sens_map(image, '2D');

    % C = 2D coil operator.
    C = C_2D(size(image), sens);
    image_coil_combined = C' * image;

end
 