function [paths] = bart_setup(paths)
    %--------------------------------------------------------------------------
    % Define a BART command
    %--------------------------------------------------------------------------
    if ispc
        command_prefix = 'wsl';
    else
        command_prefix = '';
    end
    paths.bart_command = sprintf('%s %s/bart', command_prefix, paths.bart_path);

    %--------------------------------------------------------------------------
    % Translate from a Windows path to a WSL path 
    %--------------------------------------------------------------------------
    if ispc
        bart_output_path = strrep(paths.output_path, '\', '/');
        paths.bart_output_path = sprintf('/mnt/%s/%s/', lower(bart_output_path(1)), bart_output_path(4:end));
    else
        paths.bart_output_path = sprintf('%s/', paths.output_path);
    end
end