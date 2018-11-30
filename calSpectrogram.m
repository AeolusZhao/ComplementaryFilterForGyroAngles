function calSpectrogram(signal, frequency)

nSamples = length(signal);
window = 1500; % 30000
overlap = window / 2;

% s = spectrogram(signal, window, window/2, window);

figure('name', 'Spectrogram');
spectrogram(signal-mean(signal), window, overlap, window, frequency, 'yaxis')
% view(-77, 72);
% shading interp
% colorbar off
