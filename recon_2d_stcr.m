function img_recon = recon_2d_stcr(nr_arms_per_frame, TR_to_trim, ...
    maxgirf_flag, weight_tTV, weight_sTV, delta, area, which_file, useGPU)
    % Written by Nejat Can. Template by Prakash Kumar and Ecrin Yagiz
    % img_recon = recon_2d_stcr(nr_arms_per_frame, TR_to_trim, area, which_file, useGPU)
    % 2D STCR recon using a "Fatrix" encoding operator.
    
    arguments
        nr_arms_per_frame = 30
        TR_to_trim = 30*61
        maxgirf_flag = 1
        weight_tTV = 0.05
        weight_sTV = 0.01
        delta = 0.2
        area = 'pulseq_lung'
        which_file = 2
        useGPU = 1
    end

    close all

    %% Setup paths
    run('utility/setup.m')
    addpath(genpath('./encoding/'))
    addpath(genpath('./utility/'))
    addpath('./thirdparty/')
    addpath('./optim/');

    %% Select which dataset to use [See select_dataset.m]
    paths = select_dataset(area, which_file);

    %% Load Data and prep
    [kspace, kx, ky, header, maxgirf_vars, DCF] = load_and_prep_data( ...
    nr_arms_per_frame, TR_to_trim, paths);

    %% Define recon parameters
    oversampling = 1; % define the oversampling factor

    % Solver Parameters
    Nmaxiter    = 80; % Max number of iterations
    Nlineiter   = 20; % Max number of it for Line Search
    betahow     = 'GD'; % NCG Update Methods
    linesearch_how  = 'mm'; % Line Search Method

    %% Encoding
    if maxgirf_flag == true
        %% Calculate MaxGIRF higher-order encoding matrix (u and v)
        [u, v, para] = calculate_maxgirf_encoding(nr_arms_per_frame, ...
            TR_to_trim, header, maxgirf_vars);

        %% Encoding matrix with MaxGIRF
        F = maxgirf_Fnufft_2D(kx, ky, u, v, para, header.nr_coils, ...
            header.matrix_size, useGPU, DCF(:,1), oversampling, [4,4]);
    elseif maxgirf_flag == false
        F = Fnufft_2D(kx, ky, header.nr_coils, header.matrix_size, ...
            useGPU, DCF(:,1), oversampling, [4,4]);
    else
        error('The parameter maxgirf_flag must be set to either 1 or 0.')
    end
    
    % --------- adjoint test on the operator F (optional). --------------------
    %test_fatrix_adjoint(F);

    % encode kspace into image
    image = F' * kspace;

    % C = 2D coil operator
    sens = get_sens_map(image, '2D');
    C = C_2D(size(image), sens, useGPU);

    % adjoint test on the operator C (optional)
    test_fatrix_adjoint(C);

    %% Calculate first estimate of the solver. Gridding recon + coil combination
    first_estimate = C' * image;
    scale = max(abs(first_estimate(:)));

    %% Regularization Operators

    % operators tfd and tv.
    T_tfd = TFD(size(first_estimate));
    T_tv = TV_2D(size(first_estimate));

    % --------- adjoint test on the operator TV (optional). -------------------
    test_fatrix_adjoint(T_tfd);
    test_fatrix_adjoint(T_tv);

    %% Define the L1 Approximation

    % Define potiential function as fair-l1.
    l1_func = potential_fun('fair-l1', delta); % smaller delta is more computationally expensive
                                               % as delta approaches zero, norm approaches l1
    %% Solver -> NCG 
    % need to define B, gradF, curvf, x0, niter, ninner, P, betahow, fun

    % -------------------------------------------------------------------------
    % prep for the NCG routine
    % -------------------------------------------------------------------------

    % Scale Regularization parameters
    lambdaTFD = weight_tTV * scale;
    lambdatTV = weight_sTV * scale;

    % ----- Data Consistency Term Related -------------------------------------
    gradDC = @(x) x - kspace;
    curvDC = @(x) 1;

    % ------------------ TTV Term Related -------------------------------------
    gradTFD = @(x) lambdaTFD * l1_func.dpot(x);
    curvTFD = @(x) lambdaTFD * l1_func.wpot(x);

    % ------------------ STV Term Related -------------------------------------
    gradtTV = @(x) lambdatTV * l1_func.dpot(x);
    curvtTV = @(x) lambdatTV * l1_func.wpot(x);

    % ------------------ Intermediate Step Cost -------------------------------
    costf = @(x,y) each_iter_fun(F, C, T_tfd, T_tv, lambdaTFD, lambdatTV, ...
                                 l1_func, kspace, x, y);

    % ------------- necessary for NCG routine ---------------------------------
    B = {F*C, T_tfd, T_tv};
    gradF = {gradDC, gradTFD, gradtTV};
    curvF = {curvDC, curvTFD, curvtTV};

    %% Actual Solver Here
    tic
    %[x, out] = ncg_inv_mm(B, gradF, curvF, first_estimate, 200, 20, eye,'dai-yuan', costf);
    [x, out] = ncg(B, gradF, curvF, first_estimate, Nmaxiter, Nlineiter, eye, betahow, linesearch_how, costf);
    toc

    %% Display the Result
    img_recon = gather(x);
    img_recon = rot90(img_recon, 2);
    %img_recon = crop_half_FOV(img_recon);

    %as(img_recon);

    out = cell2mat(out);
    Cost = structArrayToStructWithArrays(out);
    plotCost(Cost);

    %% Example of how to look at the line plot
    % disp('Put a Line in the Figure1 to see a line profile')
    % [profiles, lines] = draw_profile_(abs(img_recon));

    %% save video.
    %save_video("test.avi", img_recon, 0, 1000 / (kspace_info.user_TR * Narms_per_frame / 1000), false, 1/2);

    %% Helper functions
    % COST
    function [struct] = each_iter_fun(F, C, T_tfd, T_tv, lambdaTFD, lambdatTV, l1_func, kspace, x, y)
        % added normalization
        N = numel(x);
        struct.fidelityNorm = (0.5 * (norm(vec(F * C * x - kspace))^2)) / N;
        struct.spatialNorm = sum(vec(lambdatTV * l1_func.potk(T_tv * x))) / N;
        struct.temporalNorm = sum(vec(lambdaTFD * l1_func.potk(T_tfd * x))) / N;
        struct.totalCost = struct.fidelityNorm + struct.spatialNorm + struct.temporalNorm;
    end
end
