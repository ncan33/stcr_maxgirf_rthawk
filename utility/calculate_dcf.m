function [DCF] = calculate_dcf(k_rcs, header)
    %% Calculate a density compensation function (1 x Nk x Ni)
    coords = k_rcs / (2 * header.krmax); % 3 x Nk x Ni
    coords(3,:,:) = 0;
    numIter = 25;
    verbose = 0;
    DCF = sdc3_MAT(coords, numIter, header.matrix_size(1), verbose, 2);
    DCF = single(reshape(DCF / max(DCF(:)), [1 header.nr_samples header.nr_interleaves]));
    
end