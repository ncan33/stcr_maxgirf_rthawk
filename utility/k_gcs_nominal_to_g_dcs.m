function g_dcs = k_gcs_nominal_to_g_dcs(k_gcs_nominal, header, coord)
    %% Define the gyromagnetic ratio for 1H
    gamma = 4257.59 * (1e4 * 2 * pi); % gyromagnetic ratio for 1H [rad/sec/T]

    %% Calculate nominal gradient waveforms in the GCS [mT/m] [PE,RO,SL]
    % [rad/m] / [rad/sec/T] / [sec] * [1e3 mT/T] =>  *1e3 [mT/m]
    g_gcs_nominal = diff(cat(2, zeros(3, 1, header.nr_interleaves), ...
        k_gcs_nominal), 1, 2) / gamma / header.grad_raster_time * 1e3; % [mT/m]

    %% Interpolate nominal gradient waveforms in the GCS [mT/m] [PE,RO,SL] 
    t_GRT = ((0:header.grad_samples - 1) + 0.5).' * header.grad_raster_time; % GRT --> gradient raster time
    t_ADC = ((0:header.nr_samples - 1) + 0.5).' * header.real_dwell_time; % ADC --> analog to digital converter (readout)

    g_gcs_nominal_interp = zeros(3, header.nr_samples, header.nr_interleaves, 'single');
    for idx1 = 1:header.nr_interleaves
        g_gcs_nominal_interp(1,:,idx1) = interp1(t_GRT, ...
            g_gcs_nominal(1,:,idx1), t_ADC, 'linear', 'extrap');
        g_gcs_nominal_interp(2,:,idx1) = interp1(t_GRT, ...
            g_gcs_nominal(2,:,idx1), t_ADC, 'linear', 'extrap');
        g_gcs_nominal_interp(3,:,idx1) = interp1(t_GRT, ...
            g_gcs_nominal(3,:,idx1), t_ADC, 'linear', 'extrap');
    end

    %% Calculate GIRF-predicted gradient waveforms in the GCS [mT/m] [PE,RO,SL]
    tRR = 1;
    sR.R = coord.R_gcs2dcs;
    sR.T = header.B0;
    [~,g_gcs] = apply_GIRF(permute(g_gcs_nominal, [2 3 1]), ...
        header.real_dwell_time, sR, tRR); % k:[cycle/cm] and g:[G/cm]
    g_gcs = permute(g_gcs, [3 1 2]); % Nk x Ni x 3 => 3 x Nk x Ni

    %% Change the sign of GIRF-predicted gradient waveforms in the GCS [mT/m] [PE,RO,SL]
    g_gcs(1,:) = coord.phase_sign * g_gcs(1,:); % [mT/m] PE (gu)
    g_gcs(2,:) = coord.read_sign  * g_gcs(2,:); % [mT/m] RO (gv)

    %--------------------------------------------------------------------------
    % Additional sign flip if gradient waveforms are obtained from MRD format
    % This may be not needed?
    %--------------------------------------------------------------------------
    g_gcs(1,:,:) = -g_gcs(1,:,:);

    %% Calculate GIRF-predicted gradient waveforms in the DCS [mT/m] [x,y,z]
    g_dcs = zeros(3, header.nr_samples, header.nr_interleaves, 'double');
    for i = 1:header.nr_interleaves
        g_dcs(:,:,i) = coord.R_gcs2dcs * g_gcs(:,:,i); % 3 x Nk
    end
end