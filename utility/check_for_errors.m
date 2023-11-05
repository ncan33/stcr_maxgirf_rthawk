function check_for_errors(nr_arms_per_frame, header)
    % Ensure that nr_arms_per_frame <= nr_interleaves
    if nr_arms_per_frame > header.nr_interleaves
        error(['The number of arms per frame must be smaller than or ', ...
            'equal to the number of unique views. In this case, the ', ...
            'number of unique views is ', num2str(header.nr_interleaves),
            ' but the number of arms per frame is ',
            num2str(nr_arms_per_frame), '.'])
    end
end

