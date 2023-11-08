function paths = select_dataset(area, which_file)
    % paths = select_dataset(area, which_file)
    % Select a dataset.

    switch area
        % ---------------------------------------------------------------------
        case 'rthawk_lung'
            switch which_file
                % -------------------------------------------------------------
                % Freebreathing n34
                case 0
                    paths.path = "/server/home/pkumar/mri_data/disc/lung/vol0759_20231106/raw_hawk";
                    paths.name = "usc_disc_yt_2023_11_06_171628_multi_slice_golden_angle_spiral_gre_slice_1_fov_480_n34_slice_01.mat";
                % -------------------------------------------------------------
                % Freebreathing n21
                case 1
                    paths.path = "/server/home/pkumar/mri_data/disc/lung/vol0759_20231106/raw_hawk";
                    paths.name = "usc_disc_yt_2023_11_06_171535_multi_slice_golden_angle_spiral_gre_slice_1_fov_480_n21_slice_01.mat";
                % Breath hold n34
                case 2
                    paths.path = "/server/home/pkumar/mri_data/disc/lung/vol0759_20231106/raw_hawk";
                    paths.name = "usc_disc_yt_2023_11_06_172519_multi_slice_golden_angle_spiral_gre_slice_1_fov_480_n34_slice_01.mat";
            end
        % ---------------------------------------------------------------------
        case 'rthawk_phantom'
            switch which_file
                % -------------------------------------------------------------
                % z=80mm
                case 0 
                    paths.path = pwd;
                    paths.name = "phantom80mm.mat";
                % -------------------------------------------------------------
                % coronal
                case 1
            end
        % ---------------------------------------------------------------------
        case 'pulseq_lung'
            switch which_file
                % -------------------------------------------------------------
                % Breath-hold, TR = 9 ms
                case 0 
                    paths.folder = '/server/sdata/ncan/mri_data/disc/lung/vol0729_20231019';
                    paths.name = 'meas_MID00483_FID10137_tr_9_breath_hold';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR9.06_i90_avg36.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR9.06_i90_avg36.seq';
                % -------------------------------------------------------------
                % Breath-hold, TR = 12 ms
                case 1
                    paths.folder = '/server/sdata/ncan/mri_data/disc/lung/vol0729_20231019';
                    paths.name = 'meas_MID00486_FID10139_tr_12_breath_hold';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR11.98_i61_avg41.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR11.98_i61_avg41.seq';
                % -------------------------------------------------------------
                % Free-breathing, TR = 12 ms
                case 2
                    paths.folder = '/server/sdata/ncan/mri_data/disc/lung/vol0729_20231019';
                    paths.name = 'meas_MID00488_FID10141_tr_12_freebreathing';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR11.98_i61_avg41.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR11.98_i61_avg41.seq';
                % -------------------------------------------------------------
                % Breath-hold, TR = 7 ms
                case 3
                    paths.folder = '/server/sdata/ncan/mri_data/disc/lung/vol0731_20231021';
                    paths.name = 'meas_MID00073_FID10425_cor_6ms_lung_breathhold';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR7.22_i100_avg42.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR7.22_i100_avg42.seq';
                % -------------------------------------------------------------
                % Free-breathing, TR = 7 ms
                case 4
                    paths.folder = '/server/sdata/ncan/mri_data/disc/lung/vol0731_20231021';
                    paths.name = 'meas_MID00074_FID10426_cor_6ms_lung_freebreathing';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR7.22_i100_avg42.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR7.22_i100_avg42.seq';
            end
        case 'pulseq_phantom'
            switch which_file
                % -------------------------------------------------------------
                % Transversal, TR = 15ms, 0mm
                case 0 
                    paths.folder = '/server/sdata/ncan/mri_data/disc/phantom/phantom0359_20231005/transversal/spiral';
                    paths.name = 'meas_MID01268_FID08945_transversal_14ms_0mm';
                    paths.traj = 'traj_bssfp_spiralout_Tread_14.22ms_256mm_1.0mm_5mm_TE0.86_TR15.92_i15_avg10.h5';
                    paths.seq = 'bssfp_spiralout_Tread_14.22ms_256mm_1.0mm_5mm_TE0.86_TR15.92_i15_avg10.seq';
                % -------------------------------------------------------------
                % Transversal, TR = 15ms, 75mm
                case 1
                    paths.folder = '/server/sdata/ncan/mri_data/disc/phantom/phantom0359_20231005/transversal/spiral';
                    paths.name = 'meas_MID01280_FID08957_transversal_14ms_75mm';
                    paths.traj = 'traj_bssfp_spiralout_Tread_14.22ms_256mm_1.0mm_5mm_TE0.86_TR15.92_i15_avg10.h5';
                    paths.seq = 'bssfp_spiralout_Tread_14.22ms_256mm_1.0mm_5mm_TE0.86_TR15.92_i15_avg10.seq';
            end
        case 'pulseq_liver'
            switch which_file
                % 75mm liver
                case 0
                    paths.folder = '/server/sdata/ncan/mri_data/disc/liver/vol0736_20231024/freebreathing';
                    paths.name = 'meas_MID00376_FID10820_liver_15ms_75mm_free_breathing';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR15.18_i30_avg63.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR15.18_i30_avg63.seq';
                % 0mm liver
                case 1
                    paths.folder = '/server/sdata/ncan/mri_data/disc/liver/vol0736_20231024/freebreathing';
                    paths.name = 'meas_MID00374_FID10818_liver_15ms_0mm_free_breathing';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR15.18_i30_avg63.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR15.18_i30_avg63.seq';
            end
        case 'pulseq_kidney'
            switch which_file
                % 75mm liver
                case 0
                    paths.folder = '/server/sdata/ncan/mri_data/disc/kidney/vol0736_20231024/freebreathing';
                    paths.name = 'meas_MID00377_FID10821_kidney_15ms_75mm_free_breathing';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR15.18_i30_avg63.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR15.18_i30_avg63.seq';
                % 0mm kidney
                case 1
                    paths.folder = '/server/sdata/ncan/mri_data/disc/liver/vol0736_20231024/freebreathing';
                    paths.name = 'meas_MID00375_FID10819_kidney_15ms_0mm_free_breathing';
                    paths.traj = 'traj_bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR15.18_i30_avg63.h5';
                    paths.seq = 'bssfp_spiralout_480mm_1.0mm_6mm_TE1.00_TR15.18_i30_avg63.seq';
            end
        case 'cardiac'
            switch which_file
                % -------------------------------------------------------------
                % "Good" example
                case 0
                    paths.path = "/server/sdata/eyagiz/mri_data/disc/heart/vol0376_20220620/raw_hawk/";
                    paths.name = "usc_disc_yt_2022_06_20_144717_multi_slice_golden_angle_spiral_ssfp_slice_9_fov_240_n17_slice_06.mat";
                % -------------------------------------------------------------
                % "Bad" example
                case 1
            end
        % ---------------------------------------------------------------------
        case 'speech'
            switch which_file
                % -------------------------------------------------------------
                % "Good" example
                case 0 
                    paths.path = "/server/home/pkumar/mri_data/disc/speech/vol0634_20230601/raw_hawk/";
                    paths.name = "usc_disc_20230601_172615_pk_speech_rt_ssfp_fov24_res24_n13_vieworder_bitr.mat";
                % -------------------------------------------------------------
                % "Bad" example
                case 1
            end
        end
end