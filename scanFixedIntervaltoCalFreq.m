function scanFixedIntervaltoCalFreq(signal, sampleFrequency)

nSamples = length(signal);
scanInterval = 100;
nIter = int32(nSamples / scanInterval) - 1;
DominantF = zeros(nIter, 1);
for i = 1 : nIter  
    partialSignal = signal(( 1+ (i-1)*scanInterval) : i*scanInterval);
    [Pxx,f] = pwelch((partialSignal-mean(partialSignal)),gausswin(scanInterval),scanInterval/2,scanInterval,sampleFrequency);
    [~,loc] = max(Pxx);
    DominantF(i) = f(loc);
end

partialT = (0:nIter-1);
figure('name', 'scan interval');
plot(partialT, DominantF);
grid on;
title(['Scan interval = ',num2str(scanInterval*4/1000),' s']);
