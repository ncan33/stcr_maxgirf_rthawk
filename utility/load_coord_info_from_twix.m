function [coord] = load_coord_info_from_twix(paths)
    %% Read twix file
    twix = mapVBVD(paths.siemens_twix_file);
    if length(twix) > 1
        twix = twix{end};
    end

    %% Get a slice normal vector from Siemens TWIX format
    %--------------------------------------------------------------------------
    % dNormalSag: Sagittal component of a slice normal vector (in the PCS)
    %--------------------------------------------------------------------------
    if isfield(twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sNormal, 'dSag')
        coord.dNormalSag = twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sNormal.dSag;
    else
        coord.dNormalSag = 0;
    end

    %--------------------------------------------------------------------------
    % dNormalCor: Coronal component of a slice normal vector (in the PCS)
    %--------------------------------------------------------------------------
    if isfield(twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sNormal, 'dCor')
        coord.dNormalCor = twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sNormal.dCor;
    else
        coord.dNormalCor = 0;
    end

    %--------------------------------------------------------------------------
    % dNormalTra: Transverse component of a slice normal vector (in the PCS)
    %--------------------------------------------------------------------------
    if isfield(twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sNormal, 'dTra')
        coord.dNormalTra = twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sNormal.dTra;
    else
        coord.dNormalTra = 0;
    end

    %--------------------------------------------------------------------------
    % dRotAngle: Slice rotation angle ("swap Fre/Pha")
    %--------------------------------------------------------------------------
    if isfield(twix.hdr.MeasYaps.sSliceArray.asSlice{1}, 'dInPlaneRot')
        coord.dRotAngle = twix.hdr.MeasYaps.sSliceArray.asSlice{1}.dInPlaneRot; % [rad]
    else
        coord.dRotAngle = 0; % [rad]
    end

    %% Get a slice offset in the PCS from Siemens TWIX format
    if isfield(twix.hdr.MeasYaps.sSliceArray.asSlice{1}, 'sPosition')
        if isfield(twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sPosition, 'dSag')
            sag_offset_twix = twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sPosition.dSag; % [mm]
        else
            sag_offset_twix = 0; % [mm]
        end
        if isfield(twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sPosition, 'dCor')
            cor_offset_twix = twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sPosition.dCor; % [mm]
        else
            cor_offset_twix = 0; % [mm]
        end
        if isfield(twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sPosition, 'dTra')
            tra_offset_twix = twix.hdr.MeasYaps.sSliceArray.asSlice{1}.sPosition.dTra; % [mm]
        else
            tra_offset_twix = 0; % [mm]
        end
    else
        sag_offset_twix = 0; % [mm]
        cor_offset_twix = 0; % [mm]
        tra_offset_twix = 0; % [mm]
    end
    
    coord.pcs_offset_stack = [sag_offset_twix; cor_offset_twix; tra_offset_twix] * 1e-3; % [mm] * [m/1e3mm] => [m]
end