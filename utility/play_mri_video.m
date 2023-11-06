function play_mri_video(n_frames, fps, video_matrix, caxis_upper, ...
    save_video, resize_figure, convert_to_mov, vid_name)
    % Parameters in brackets are optional. Call this function as:
    %
    % play_mri_video(n_frames, fps, video_matrix, [caxis_upper], [save_video], [resize_figure]
    % [convert_to_mov], [vid_name])
    %
    % Parameters:
    % - n_frames: number of frame to show. set n_frames to 'all' if you
    %       want to play every frame.
    % - fps: frames per second. 1 / ([TR in seconds] * Narms_per_frame)
    % - video_matrix: 3D matrix where the 3rd dimension is the temporal one
    % - caxis_upper: upper limit of caxis. if left empty, one will be
    %       determined automatically using a combination of max and mean
    % - save_video: set this to 1 if you wish to save video in the
    %       make_video directory's tmp folder for videomaking
    % - resize_figure: if set to 1, a figure and the user is asked to
    %       resize it before plotting. if set to 0, the video will be plotted
    %       in the current figure (if none exists, a standard figure is used).
    % - convert_to_mov: if set to 1, save video as .mov instead of .avi
    % - vid_name: set custom video name. default is mri_video.mov
    
    arguments
        n_frames
        fps
        video_matrix
        caxis_upper = NaN
        save_video = 0
        resize_figure = 0
        convert_to_mov = 1
        vid_name = 'mri_video'
    end
    
    if ~isnumeric(n_frames)
        n_frames = size(video_matrix, 3);
    end
    
    if save_video
        if resize_figure
            figure;
            input(['Resize the figure as you wish. When done, press ', ...
                'enter in command window'])
        end
        
        video = VideoWriter(vid_name);
        video.FrameRate = fps;
        open(video)
    end
    
    for i = 1:n_frames
        a = abs(video_matrix(:,:,i));
        %a = abs(video_matrix(70:349,  70:349, i)); % for NUFFT
        %a = fliplr(rot90(a, -1)); % for NUFFT
        imagesc(a); axis image; colorbar; colormap gray
        title(['Frame ', num2str(i)])
        if isnan(caxis_upper)
            caxis([0 abs(mean(squeeze(max(squeeze(max(video_matrix))))))])
        else
            caxis([0 caxis_upper])
        end
        
        %% play vs. save video
        if ~save_video
            pause(1/fps)
        else
            saveas(gcf, ['/server/home/ncan/make_video/tmp/', num2str(i), '.png'])
            image = imread(['/server/home/ncan/make_video/tmp/', num2str(i), '.png']);
            writeVideo(video, image);
            disp(['Frame ', num2str(i),' done!'])
        end
    end
    
    if save_video && convert_to_mov
        close(video)
        disp('Frames successfully saved in ncan/make_video/tmp')
        convert_command = sprintf('ffmpeg -i %s.avi -c:v copy -c:a copy %s.mov', vid_name, vid_name);
        system(convert_command);
        system(['rm ',vid_name,'.avi']);
    end
end