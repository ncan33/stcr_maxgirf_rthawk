function [u, v] = calculate_encoding_matrix(k_bar, p, B0map, t, frame, nr_frames, para)
    %% Calculate the SVD of the higher-order encoding matrix (Nk x N)
    fprintf('%s:(%2d/%2d) Calculating the randomized SVD... ', datetime, frame, nr_frames);
    [u_tilde,s_tilde,v_tilde] = rthawk_calculate_rsvd_higher_order_encoding_matrix( ...
        k_bar(:, 4:end), p(:, 4:end), para.Lmax, para.os, reshape( ...
        B0map(:, :, frame), [size(p, 1) 1]), t, para.static_B0_correction);
    u = u_tilde(:, 1:para.Lmax); % Nk x Lmax
    s = s_tilde(1:para.Lmax, 1:para.Lmax); % Lmax x Lmax
    v = v_tilde(:, 1:para.Lmax) * s_tilde(1:para.Lmax, 1:para.Lmax)'; % N x Lmax
    disp([newline, 'done!']);
    %figure; plot(diag(var.s));
    %title(sprintf('slice nr = %d', var.frame_nr));
    %drawnow;

    % u (Nk x L)
    % v (N1 x N2 x N3 x L)
  end