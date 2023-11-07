function display_phase_coefficients(k_bar, t, header, nr_arms_per_frame)
    %% Display the phase coefficients
    ell_list = [1:6, 8:9].';
    figure('Color', 'w', 'Position', [6 178 1749 800]);
    for i = 1:length(ell_list)
        ell = ell_list(i);
        ax = subplot(2,4,i);
        if ell == 1
            title_text = '$$k_{1,i}(t) = \int_{0}^{t} G_{x,i}(\tau) d \tau$$';
            ylabel_text = '[rad/m]';
            basis_text = '$$p_1(\mathbf{r}) = x$$';
        elseif ell == 2
            title_text = '$$k_{2,i}(t) = \int_{0}^{t} G_{y,i}(\tau) d \tau$$';
            ylabel_text = '[rad/m]';
            basis_text = '$$p_2(\mathbf{r}) = y$$';
        elseif ell == 3
            title_text = '$$k_{3,i}(t) = \int_{0}^{t} G_{z,i}(\tau) d \tau$$';
            ylabel_text = '[rad/m]';
            basis_text = '$$p_3(\mathbf{r}) = z$$';
        elseif ell == 4
            title_text = '$$k_{4,i}(t) = \int_{0}^{t} G_{z,i}^2(\tau) / (8 B_0) d \tau$$';
            ylabel_text = '[rad/m^2]';
            basis_text = '$$p_4(\mathbf{r}) = x^2$$';
        elseif ell == 5
            title_text = '$$k_{5,i}(t) = \int_{0}^{t} G_{z,i}^2(\tau) / (8 B_0) d \tau$$';
            ylabel_text = '[rad/m^2]';
            basis_text = '$$p_5(\mathbf{r}) = y^2$$';
        elseif ell == 6
            title_text = '$$k_{6,i}(t) = \int_{0}^{t} (G_{x,i}^2(\tau) + G_{y,i}^2(\tau)) / (2 B_0) d \tau$$';
            ylabel_text = '[rad/m^2]';
            basis_text = '$$p_6(\mathbf{r}) = z^2$$';
        elseif ell == 8
            title_text = '$$k_{8,i}(t) = \int_{0}^{t} -G_{y,i}(\tau) G_{z,i}(\tau) / (2 B_0) d \tau$$';
            ylabel_text = '[rad/m^2]';
            basis_text = '$$p_8(\mathbf{r}) = yz$$';
        elseif ell == 9
            title_text = '$$k_{9,i}(t) = \int_{0}^{t} -G_{x,i}(\tau) G_{z,i}(\tau) / (2 B_0) d \tau$$';
            ylabel_text = '[rad/m^2]';
            basis_text = '$$p_9(\mathbf{r}) = xz$$';
        end

        hold on;
        plot(t * 1e3, reshape(k(:,ell,:,1), [header.nr_samples nr_arms_per_frame]));
        if ell > 3
            plot(t * 1e3, k_bar(:,ell,1), 'Color', 'r', 'LineWidth', 2);
        end
        YLim = ax.YLim;
        text(0.3, YLim(2) * 0.99, basis_text, 'Interpreter', 'latex', 'FontSize', 14, 'VerticalAlignment', 'top');
        xlabel('Time [msec]');
        ylabel(ylabel_text);
        title(title_text, 'Interpreter', 'latex', 'FontSize', 12);
        set(gca, 'Box', 'On');
        grid on; grid minor;
    end
    drawnow;
end