function image_coil_combined = recon_2d(nr_arms_per_frame, TR_to_trim, ...
    maxgirf_flag, area, which_file, useGPU)
    % written by Nejat Can
    % template by Prakash Kumar and Ecrin Yagiz
    % 2D gridding recon using a "Fatrix" encoding operator.

    arguments
        nr_arms_per_frame = 15
        TR_to_trim = 10*34
        maxgirf_flag = 0
        area = 'rthawk_lung'
        which_file = 0
        useGPU = 1
    end

    close all

    %% Setup paths
    run('utility/setup.m')
    addpath(genpath('./encoding/'))
    addpath(genpath('./utility/'))
    addpath('./thirdparty')

    %% Select which dataset to use [See select_dataset.m]
    paths = select_dataset(area, which_file);

    %% Load data and prep
    [kspace, kx, ky, header, g_dcs, coord, DCF] = load_and_prep_data( ...
    nr_arms_per_frame, TR_to_trim, paths);
    
    %% Encoding
    oversampling = 1; % oversampling factor

    if maxgirf_flag == true
        %% Calculate MaxGIRF higher-order encoding matrix (u and v)
        [u, v, para] = calculate_maxgirf_encoding(nr_arms_per_frame, ...
            TR_to_trim, header, g_dcs, coord);

        %% Encoding matrix with MaxGIRF
        F = maxgirf_Fnufft_2D(kx, ky, u, v, para, header.nr_coils, ...
            header.matrix_size, useGPU, DCF(:,1), oversampling, [4,4]);
        
    elseif maxgirf_flag == false
        F = Fnufft_2D(kx, ky, header.nr_coils, header.matrix_size, ...
            useGPU, DCF(:,1), oversampling, [4,4]);
    else
        error('The parameter maxgirf_flag must be set to either 1 or 0.')
    end

    % adjoint test on the operator F (optional)
    test_fatrix_adjoint(F);
    
    % encode kspace into image
    image = F' * kspace;

    % estimate sensitivity maps
    sens = get_sens_map(image, '2D');

    % C = 2D coil operator
    C = C_2D(size(image), sens);
    image_coil_combined = C' * image;

    image_coil_combined = rot90(image_coil_combined, 2);
    
end
 