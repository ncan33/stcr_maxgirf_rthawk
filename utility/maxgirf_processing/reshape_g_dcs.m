function g_dcs = reshape_g_dcs(g_dcs, nr_samples, nr_arms_per_frame, ...
    nr_frames, view_order)
    
    g_dcs_new = zeros(3, nr_samples, nr_arms_per_frame, nr_frames);
    for i = 1:3
        g_dcs_intermediate = repmat(squeeze(g_dcs(i,:,:)), [1, ceil( ...
            nr_arms_total / nr_interleaves)]);
        g_dcs_intermediate = g_dcs_intermediate(:, view_order);
        g_dcs_new(i, :, :, :) = reshape(g_dcs_intermediate, ...
            [nr_samples, nr_arms_per_frame, nr_frames]);
    end
    
    g_dcs = g_dcs_new;
    
end