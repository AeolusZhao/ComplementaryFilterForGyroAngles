clear all;

m = 25000; %For psv data 3000000 For roof data 139500
start = 1; %For psv data start point 150000 for roof 37500
stop = start + m - 1;
[time, accX, accY, accZ, gyroX, gyroY, gyroZ, dt] = readDataFromSensorLog(stop);

AngleXFromGyro = cumsum(gyroX) * dt; % degree
AngleYFromGyro = cumsum(gyroY) * dt; % degree
%AngleZFromGyro = cumsum(gyroZ) * dt; % degree

AngleXFromAcc = atand( accY ./ sqrt(accX.^2 + accZ.^2) ) ; % degree
AngleYFromAcc = atand( -accX ./ sqrt(accY.^2 + accZ.^2) ) ; % degree
% AngleZFromAcc = atand( accZ./ sqrt(accX.^2 + accY.^2) ) ; % degree

highCoe = 0.98; 
lowCoe = 0.02;

angleX = zeros(stop, 1);
angleX(1) = highCoe * (gyroX(1)*dt) + lowCoe * AngleXFromAcc(1);

angleY = zeros(stop, 1);
angleY(1) = highCoe * (gyroY(1)*dt) + lowCoe * AngleYFromAcc(1);

%angleZ = zeros(m, 1);
%angleZ(1) = highCoe * (gyroZ(1)*dt) + lowCoe * AngleZFromAcc(1);

%   hSurface = plotCamera();
%   direction = [0 1 0];

for i = 2:stop
 angleX(i) = highCoe * ( angleX(i-1) + gyroX(i) * dt ) + lowCoe * AngleXFromAcc(i);
 angleY(i) = highCoe * ( angleY(i-1) + gyroY(i) * dt ) + lowCoe * AngleYFromAcc(i);
 %angleZ(i) = highCoe * ( angleZ(i-1) + gyroZ(i) * dt ) + lowCoe * AngleZFromAcc(i); 
 %somehow rotate using the previous pos as reference, thus here subtract
%  %the previoius pos
%  if i>2500
%    rotate(hSurface,direction, (angleY(i) - angleY(i-1)) ); 
%    figure(2); plot(time, angleY);
%    drawnow
%  end
end

figure(1); clf; hold all;
plot(time(start:stop), angleY(start:stop)) 
legend('angleX');
xlabel('time(second)');
ylabel('degree');

W=1501; %15001
localSums = imboxfilt(angleY, [W 1], 'NormalizationFactor',1);
calSpectrogram(localSums, 250);

angleY = angleY - localSums/W;
W=7;
angleY = imfilter(angleY, [1 2 1]/4);

estimateFrequency(angleY(start:stop), 250);
% scanFixedIntervaltoCalFreq(angleY(start:stop), 250);
calSpectrogram(angleY(start:stop), 250);


% plot(time, angleY, 'LineWidth', 1) 
% legend('angleY');
% plot(time, AngleXFromAcc) 
% plot(time, AngleXFromGyro);
% legend('angleX','AngleXFromAcc', 'AngleXFromGyro');
% xlabel('time(minute)');
% ylabel('degree');
% 
% figure(2);
% plot(time, angleY, time, AngleYFromAcc, time, AngleYFromGyro);
% legend('angleY','AngleYFromAcc', 'AngleYFromGyro');


% [maxAplitudeX, indexMaxX] = max(y(start:stop));
% [minAplitudeX, indexMinX] = min(y(start:stop));
% [maxAplitudeY, indexMaxY] = max(angleY(start:stop));
% [minAplitudeY, indexMinY] = min(angleY(start:stop));

% indexStart = start + indexMaxX - 1000;
% indexStop = start + indexMaxX + 1000;
% figure(10);clf; plot(time(indexStart :indexStop), angleX(indexStart:indexStop));
% estimateFrequency(angleX(indexStart:indexStop), 250);

% figure(10);
% findpeaks(angle(start:stop), 'MINPEAKHEIGHT', 32.35);
% % findpeaks(angleX(start:stop));
% estimateFrequency(angleY(start:stop), 250);
%what do try next: use FFT to transfer data to frequency domain, then use
%findpeak to find top 8 peaks and get corresponding frequency!

% xlabel('time in seconds');
% ylabel('degree');
