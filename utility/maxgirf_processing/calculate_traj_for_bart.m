function [traj] = calculate_traj_for_bart(k_rcs, nr_samples, nr_interleaves, nr_frames)
    %% Calculate k-space trajectories for BART
    %--------------------------------------------------------------------------
    % A minus is required to perform forward FFT to move from k-space to image space
    % scaled to [-0.5,0.5] and then [-0.5,0.5] * N
    %--------------------------------------------------------------------------
    traj = zeros(3, nr_samples, nr_interleaves, nr_frames, 'single');
    
    for frame = 1:nr_frames
        traj(1, :, :, frame) = -k_rcs(1, :, :, frame) / (2 * header.krmax); %* header.matrix_size(1);
        traj(2, :, :, frame) = -k_rcs(2, :, :, frame) / (2 * header.krmax); %* header.matrix_size(2);
        traj(3, :, :, frame) = -k_rcs(3, :, :, frame) / (2 * header.krmax); %* 1;
    end
    
    %% Display k-space trajectories for the calibration region
    FontSize = 14;
    figure('Color', 'w');
    plot3(squeeze(traj(1,:,:,1)), squeeze(traj(2,:,:,1)), squeeze(traj(3,:,:,1)));
    axis image;
    grid on; grid minor;
    set(gca, 'Box', 'On', 'FontSize', FontSize);
    xlabel(sprintf('$k_{\\mathrm{RO}} \\in [-\\lfloor%d/2\\rfloor, \\lceil%d/2\\rceil-1]$', var.N1, var.N1), 'Interpreter', 'latex', 'FontSize', FontSize, 'Color', 'k');
    ylabel(sprintf('$k_{\\mathrm{PE}} \\in [-\\lfloor%d/2\\rfloor, \\lceil%d/2\\rceil-1]$', var.N2, var.N2), 'Interpreter', 'latex', 'FontSize', FontSize, 'Color', 'k');
    title('K-space trajectories');
    view(0,90);
    drawnow;
    
    pause(1)
    close
end