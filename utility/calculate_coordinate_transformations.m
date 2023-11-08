function [coord] = calculate_coordinate_transformations(kspace_info, header)
    % [coord] = calculate_coordinate_transformations(kspace_info, header)
    % Calculate coordinate transformations for RTHawk.

    %% Get the quaternion information
    QuaternionW     = kspace_info.('user_QuaternionW');
    QuaternionX     = kspace_info.('user_QuaternionX');
    QuaternionY     = kspace_info.('user_QuaternionY');
    QuaternionZ     = kspace_info.('user_QuaternionZ');
    
    %% Calculate a transformation matrix from the RCS to the PCS [R,C,S] <=> [SAG,COR,TRA]
    %--------------------------------------------------------------------------
    % Convert the quaternion to a rotation matrix representation
    % file: scanning_hawk/doc/RthLibs_doc_html/class_rth_quaternion.html
    % Calculate a rotation matrix from RCS to PCS
    %--------------------------------------------------------------------------
    R_rcs2pcs = zeros(3, 3, 'double');
    R_rcs2pcs(1) = 1 - (2 * QuaternionY^2 + 2 * QuaternionZ^2);
    R_rcs2pcs(2) = 2 * QuaternionX * QuaternionY + 2 * QuaternionZ * QuaternionW;
    R_rcs2pcs(3) = 2 * QuaternionX * QuaternionZ - 2 * QuaternionY * QuaternionW;
    R_rcs2pcs(4) = 2 * QuaternionX * QuaternionY - 2 * QuaternionZ * QuaternionW;
    R_rcs2pcs(5) = 1 - (2 * QuaternionX^2 + 2 * QuaternionZ^2);
    R_rcs2pcs(6) = 2 * QuaternionY * QuaternionZ + 2 * QuaternionX * QuaternionW;
    R_rcs2pcs(7) = 2 * QuaternionX * QuaternionZ + 2 * QuaternionY * QuaternionW;
    R_rcs2pcs(8) = 2 * QuaternionY * QuaternionZ - 2 * QuaternionX * QuaternionW;
    R_rcs2pcs(9) = 1 - (2 * QuaternionX^2 + 2 * QuaternionY^2);
    
    coord.R_rcs2pcs = R_rcs2pcs; % save to coord struct
    
    %% Calculate a rotation matrix from the PCS to the DCS
    coord.R_pcs2dcs = siemens_calculate_matrix_pcs_to_dcs(header.patient_position);

    %% Calculate a rotation matrix from the RCS to the DCS
    coord.R_rcs2dcs = coord.R_pcs2dcs * coord.R_rcs2pcs;

    %% Get a slice offset of a stack in the PCS [m]
    coord.pcs_offsets = [kspace_info.TranslationX;
                         kspace_info.TranslationY;
                         kspace_info.TranslationZ] * 1e-3; % [mm] * [m/1e3mm] => [m]

    %% Calculate a slice ofset of a stack in the RCS [m]
    coord.rcs_offsets = coord.R_rcs2pcs.' * coord.pcs_offsets;

    %% Calculate slice offsets in the DCS [m]
    coord.dcs_offsets = coord.R_pcs2dcs * coord.pcs_offsets; % 3 x 1
    
end