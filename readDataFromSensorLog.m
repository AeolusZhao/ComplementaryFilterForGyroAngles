function [time, accX, accY, accZ, gyroX, gyroY, gyroZ, dt] = readDataFromSensorLog(m)

filename = 'log_0000.csv';
rawData = readtable(filename); 



time = rawData.unit__timestamp_ms_(1:m) / 1000; %seconds
accX = rawData.bmi160_a_x_mg_(1:m);
accY = rawData.bmi160_a_y_mg_(1:m);
accZ = rawData.bmi160_a_z_mg_(1:m);
gyroX = rawData.bmi160_g_x_mDeg_(1:m) / 1000; %degree
gyroY = rawData.bmi160_g_y_mDeg_(1:m) / 1000; %degree
gyroZ = rawData.bmi160_g_z_mDeg_(1:m) / 1000; %degree

dt = time(2) - time(1); % seconds