Fs = 44100;
y = audioread('guitartune.wav');
nSamples = length(y);
time = (0:nSamples-1)*(1/Fs);
[maxAplitudeX, indexMaxX] = max(y);
[minAplitudeX, indexMinX] = min(y);
indexStart = 1;
indexStop = nSamples;
figure('Name', 'input signal');clf; plot(time(indexStart :indexStop), y(indexStart:indexStop));

Y = fft(y, nSamples);
magnitudeY = abs(Y);
phaseY = unwrap(angle(Y));

estimateFrequency(y, Fs);
calSpectrogram(y, Fs)


