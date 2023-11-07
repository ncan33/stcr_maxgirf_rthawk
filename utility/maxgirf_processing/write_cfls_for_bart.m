function write_cfls_for_bart(paths, para, DCF, traj)
    %--------------------------------------------------------------------------
    % traj (3 x Nk x Ni)
    %--------------------------------------------------------------------------
    cfl_file = fullfile(paths.output_path, 'traj');
    writecfl(cfl_file, traj);

    %--------------------------------------------------------------------------
    % dcf (1 x Nk x Ni)
    %--------------------------------------------------------------------------
    cfl_file = fullfile(paths.output_path, 'dcf');
    writecfl(cfl_file, DCF);

    %--------------------------------------------------------------------------
    % argmin ||sqrt(W) * (F * S * m - y)||_2^2 + Phi(m)
    % pics uses a normal operator to solve the least-squares problem,
    % we need the square root of our filter here:
    % weights = sqrt(W), where W = dcf^kappa
    %--------------------------------------------------------------------------
    cfl_file = fullfile(paths.output_path, sprintf('weights_kappa%g', para.kappa));
    writecfl(cfl_file, sqrt( (DCF).^para.kappa ));

end