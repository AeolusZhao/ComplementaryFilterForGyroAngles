function f = estimateFrequency(signal, sampleFrequency)

% nSamples samples at sampleFrequency sample rate
nSamples = length(signal);

[Pxx,f] = pwelch(signal,gausswin(nSamples),nSamples/2,nSamples,sampleFrequency);

% Get frequency estimate (spectral peak)
[~,loc] = max(Pxx);
estimatedFrequency = f(loc);

% Plot time-domain signal
figure(3);
subplot(2,1,1);
t = (0:nSamples-1)*(1/sampleFrequency);
plot(t, signal);
ylabel('Amplitude'); xlabel('Time (secs)');
axis tight;
title('Input Signal');
% Plot frequency spectrum
subplot(2,1,2);
plot(f,Pxx);
ylabel('PSD'); xlabel('Frequency (Hz)');
grid on;

title(['Frequency estimate = ',num2str(estimatedFrequency),' Hz']);


figure(5)
plot(f,10*log10(Pxx))
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')