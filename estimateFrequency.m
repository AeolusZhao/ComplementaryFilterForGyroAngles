function f = estimateFrequency(signal, sampleFrequency)

% % nSamples samples at sampleFrequency sample rate
nSamples = length(signal);
% Fsignal = fft(signal, nSamples);
% magnitude = abs(Fsignal);
% phase = unwrap(angle(Fsignal));
%[Pxx,f] = pwelch(signal,gausswin(nSamples),nSamples/2,nSamples,sampleFrequency);
window = 5000;
overlap = window/2;
[Pxx,f] = pwelch(detrend(signal),window,overlap,window, sampleFrequency);

% figure('Name', 'decompose fsginal'); clf;
% subplot(2, 1, 1);
% t = (0:nSamples-1)*(1/sampleFrequency);
% plot(t, magnitude);

% Get frequency estimate (spectral peak)
[~,loc] = max(Pxx);
estimatedFrequency = f(loc);
%meanFrequency = meanfreq(f);

% Plot time-domain signal
figure('Name', 'Time-domain and frequency spectrum'); clf;
subplot(2,1,1);
t = (0:nSamples-1)*(1/sampleFrequency);

plot(t, signal);
ylabel('amplitude'); xlabel('time (secs)');
axis tight;
title('Input Signal');

%Plot frequency spectrum
subplot(2,1,2);
plot(f,Pxx);
ylabel('PSD'); xlabel('Frequency (Hz)');
grid on;
title(['Frequency estimate = ',num2str(estimatedFrequency),' Hz']);

figure('Name', 'Log Pxx value');clf;
plot(f,10*log10(Pxx))
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')


