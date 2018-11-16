clear all;
filename = 'log_0000.csv';
gyroData = readtable(filename); 

m = 10000;
time = gyroData.unit__timestamp_ms_(1:m) / 1000; %seconds
accX = gyroData.bmi160_a_x_mg_(1:m);
accY = gyroData.bmi160_a_y_mg_(1:m);
accZ = gyroData.bmi160_a_z_mg_(1:m);
gyroX = gyroData.bmi160_g_x_mDeg_(1:m) / 1000; %degree
gyroY = gyroData.bmi160_g_y_mDeg_(1:m) / 1000; %degree
gyroZ = gyroData.bmi160_g_z_mDeg_(1:m) / 1000; %degree

AngleXFromAcc = atan( accX./ sqrt(accY.^2 + accZ.^2) );
AngleYFromAcc = atan( accY./ sqrt(accX.^2 + accZ.^2) );
AngleZFromAcc = atan( accZ./ sqrt(accX.^2 + accY.^2) );

dt = 0.004; % seconds

AngleXFromGyro = cumsum(gyroX) * dt;
AngleYFromGyro = cumsum(gyroY) * dt;
AngleZFromGyro = cumsum(gyroZ) * dt;

highCoe = 0.995; 
lowCoe = 0.005;
angleX = zeros(m, 1);
angleX(1) = highCoe * (gyroX(1)*dt) + lowCoe * AngleXFromAcc(1);
for i = 2:m
 angleX(i) = highCoe * ( angleX(i-1) + gyroX(i) * dt ) + lowCoe * AngleXFromAcc(i);
end

% dt = 0.004; % msec to sec
% newGyroX = cumsum(gyroX) * dt/1000;  % mdeg to deg
% 
figure(1); clf; plot(time, AngleXFromGyro, time, AngleXFromAcc, time, angleX);
legend('AngleXFromGyro','AngleXFromAcc', 'angleX')
% figure('Name', 'gyroX');
% plot(time, gyroX);
% figure('Name', 'gyroY');
% plot(time, gyroY);
% figure('Name', 'gyroZ');
% plot(time, gyroZ);
% 
% figure('Name', 'accX');
% plot(time, accX);
% figure('Name', 'accY');
% plot(time, accY);
% figure('Name', 'accZ');
% plot(time, accZ);