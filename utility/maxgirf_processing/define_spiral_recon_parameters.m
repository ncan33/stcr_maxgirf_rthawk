function [para] = define_spiral_recon_parameters(para)
    %% Set reconstruction options
    para.grid_os_factor1 = 1; % oversampling factor for gridding in the row    (R) direction
    para.grid_os_factor2 = 1; % oversampling factor for gridding in the column (C) direction

    para.cal_size = [24 24 1]; % size of the calibration region
    para.lambda = 0.001; % regularization parameter for spatial domain
    para.max_iter = 6; % max. number of CG iterations
    para.kappa = 1; % kappa: kappa=0 => W=I
    para.static_B0_correction = 0;
    para.Lmax = 20; % maximum rank of the SVD approximation of a higher-order encoding matrix
    para.L = 10; % rank of the SVD approximation of a higher-order encoding matrix
    para.os = 5; % oversampling parameter for randomized SVD
    para.Nl = 19; % number of spatial basis functions
    
end