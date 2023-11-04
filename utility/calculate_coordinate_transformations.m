function [coord] = calculate_coordinate_transformations(header, coord)
    %% Calculate a transformation matrix from the RCS to the GCS [r,c,s] <=> [PE,RO,SL]
    coord.R_rcs2gcs = [0    1    0 ; % [PE]   [0 1 0] * [r]
                       1    0    0 ; % [RO] = [1 0 0] * [c]
                       0    0    1]; % [SL]   [0 0 1] * [s]

    %% Calculate a rotation matrix from the GCS to the PCS
    [coord.R_gcs2pcs, coord.phase_sign, coord.read_sign, ~] = ...
        siemens_calculate_transform_gcs_to_pcs(coord.dNormalSag, ...
        coord.dNormalCor, coord.dNormalTra, coord.dRotAngle);

    %% Calculate a rotation matrix from the PCS to the DCS
    coord.R_pcs2dcs = siemens_calculate_transform_pcs_to_dcs(header.patient_position);

    %% Calculate a rotation matrix from the GCS to the DCS
    coord.R_gcs2dcs = coord.R_pcs2dcs * coord.R_gcs2pcs;

    %% Calculate a rotation matrix from the RCS to the PCS
    coord.R_rcs2pcs = coord.R_rcs2gcs * coord.R_gcs2pcs;

    %% Calculate a slice ofset of a stack in the RCS [m]
    rcs_offset_stack = coord.R_rcs2pcs.' * coord.pcs_offset_stack;
    
    %% Calculate slice offsets in the RCS [m]
    rcs_offsets = zeros(3, 1, 'double'); % there is a difference between rcs_offsets and rcs_offset_stack if data is multi-slice. in this case, it's not multi-slice, so we simplify the code (adopted from MaxGIRF)
    coord.rcs_offsets = rcs_offsets + rcs_offset_stack; 
    
    %% Calculate slice offsets in the PCS [m]
    coord.pcs_offsets = coord.R_rcs2pcs * coord.rcs_offsets;

end