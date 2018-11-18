clear all;

%specify how many entries from the log file to read
m = 1000;

[time, accX, accY, accZ, gyroX, gyroY, gyroZ, dt] = readDataFromSensorLog(m);

% AngleXFromGyro = cumsum(gyroX) * dt;
% AngleYFromGyro = cumsum(gyroY) * dt;
% AngleZFromGyro = cumsum(gyroZ) * dt;
AngleXFromAcc = atan( accX./ sqrt(accY.^2 + accZ.^2) );
AngleYFromAcc = atan( accY./ sqrt(accX.^2 + accZ.^2) );
AngleZFromAcc = atan( accZ./ sqrt(accX.^2 + accY.^2) );

highCoe = 0.98; 
lowCoe = 0.02;

angleX = zeros(m, 1);
angleX(1) = highCoe * (gyroX(1)*dt) + lowCoe * AngleXFromAcc(1);

angleY = zeros(m, 1);
angleY(1) = highCoe * (gyroY(1)*dt) + lowCoe * AngleYFromAcc(1);

angleZ = zeros(m, 1);
angleZ(1) = highCoe * (gyroZ(1)*dt) + lowCoe * AngleZFromAcc(1);

hSurface = plotCamera();
origin = [0, 0, 0];
direction = [0 1 0];

for i = 2:m
 angleX(i) = highCoe * ( angleX(i-1) + gyroX(i) * dt ) + lowCoe * AngleXFromAcc(i);
 angleY(i) = highCoe * ( angleY(i-1) + gyroY(i) * dt ) + lowCoe * AngleYFromAcc(i);
 angleZ(i) = highCoe * ( angleZ(i-1) + gyroZ(i) * dt ) + lowCoe * AngleZFromAcc(i); 
 %somehow rotate using the previous pos as reference, thus here subtract
 %the previoius pos
 rotate(hSurface,direction, (angleY(i) - angleY(i-1)) );
 
%  figure(2); plot(time, angleX, time, angleY, time, angleZ);
%  legend('angleX','angleY', 'angleZ')
 drawnow
end

figure(1); plot(time, angleX, time, angleY, time, angleZ);
legend('angleX','angleY', 'angleZ')
