function [Psi,inv_L] = calculate_receiver_noise_matrix(ismrmrd_noise_file)


%% Read an ismrmrd file
tstart = tic; fprintf('%s: Reading an ISMRMRD file: %s... \n', datetime, ismrmrd_noise_file);
if exist(ismrmrd_noise_file, 'file')
    dset = ismrmrd.Dataset(ismrmrd_noise_file, 'dataset');
    fprintf('%s: done! (%6.4f sec)\n', datetime, toc(tstart));
else
    warning('File %s does not exist.  Please generate it.' , ismrmrd_noise_file);
    Psi = single(1);
    inv_L = single(1);
    return;
end
raw_data = dset.readAcquisition();

%% Sort noise data
is_noise = raw_data.head.flagIsSet('ACQ_IS_NOISE_MEASUREMENT');
meas = raw_data.select(find(is_noise));
nr_repetitions = length(meas.data); % number of repetitions
[nr_samples,nr_channels] = size(meas.data{1});
noise = complex(zeros(nr_channels, nr_samples, nr_repetitions, 'single'));
for idx = 1:nr_repetitions
    noise(:,:,idx) = meas.data{idx}.'; % nr_samples x nr_channels => nr_channels x nr_samples
end

%% Calculate the receiver noise matrix
% Use the definition in Appendix B of Pruessmann et al. (MRM 46:638�651 (2001))
% ns denotes the number of noise samples taken per channel
% eta lists these samples in an nc x ns matrix
tstart = tic; fprintf('%s: Calculating the receiver noise matrix... \n', datetime);
Nc = nr_channels;
Ns = nr_samples * nr_repetitions;
eta = reshape(noise, [Nc Ns]);
Psi = eta * eta' / Ns; % Equation B1
fprintf('%s: done! (%6.4f sec)\n', datetime, toc(tstart));

%% Calculate the Cholesky decomposition of the receiver noise matrix
tstart = tic; fprintf('%s: Calculating the Cholesky decomposition of the receiver noise matrix... \n', datetime);
L = chol(Psi, 'lower'); % Equation B4
inv_L = inv(L);
fprintf('%s: done! (%6.4f sec)\n', datetime, toc(tstart));

end
