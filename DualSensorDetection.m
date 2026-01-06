%% BME4503C – Dual-Sensor Detection
%% 1. BASELINE CALIBRATION
%% 2. DEVIATION THRESHOLDS
%% 3. RUN SYSTEM
%% ===== REQUIRED GRAPHS =====

clear; clc;

a = arduino('/dev/cu.usbmodem1101','Leonardo');
configurePin(a,'D9','DigitalOutput');

piezoPin  = 'A0';
tempPin   = 'A1';
ledPin    = 'D9';
buzzerPin = 'D3';

time = [];
piezoLog = [];
tempLog = [];

%% ===============================
%% 1. BASELINE CALIBRATION (5 sec)
disp('Calibrating baseline – DO NOT TOUCH SENSORS');
pause(1);

fs = 10;
calTime = 5;
Ncal = fs * calTime;

piezoBaseVals = zeros(Ncal,1);
tempBaseVals  = zeros(Ncal,1);

for i = 1:Ncal
    piezoBaseVals(i) = readVoltage(a,piezoPin);
    tempBaseVals(i)  = readVoltage(a,tempPin);
    pause(1/fs);
end

piezoBase = mean(piezoBaseVals);
tempBase  = mean(tempBaseVals);

fprintf('Baseline piezo: %.3f V\n', piezoBase);
fprintf('Baseline temp : %.3f V\n', tempBase);

%% ===============================
%% 2. DEVIATION THRESHOLDS (REAL)
piezoDeltaThresh = 0.08;   % sound change (V)
tempDeltaThresh  = 0.05;   % heat change (V)

%% ===============================
%% 3. RUN SYSTEM
disp('SYSTEM RUNNING – REQUIRES SOUND + HEAT');
pause(1);

fs = 5;          % samples per second
tic;             % START TIMER IMMEDIATELY BEFORE LOOP

while toc < 300  % EXACTLY 5 minutes (wall-clock time)

    piezoV = readVoltage(a,piezoPin);
    tempV  = readVoltage(a,tempPin);

    piezoDelta = piezoV - piezoBase;
    tempDelta  = tempV  - tempBase;

    time(end+1)     = toc;
    piezoLog(end+1) = piezoDelta;
    tempLog(end+1)  = tempDelta;

    if piezoDelta > piezoDeltaThresh && tempDelta > tempDeltaThresh
        writeDigitalPin(a,ledPin,1);
        playTone(a,buzzerPin,2000,0.3);   % blocking, but now accounted for
    else
        writeDigitalPin(a,ledPin,0);
    end

    pause(1/fs);
end

writeDigitalPin(a,ledPin,0);
disp('DONE');

%% ===== REQUIRED GRAPHS =====
figure;

subplot(2,1,1)
plot(time, piezoLog, 'b')
yline(piezoDeltaThresh,'r--')
xlabel('Time (s)')
ylabel('Sound Change')
title('Sound vs Time')
grid on

subplot(2,1,2)
plot(time, tempLog, 'k')
yline(tempDeltaThresh,'r--')
xlabel('Time (s)')
ylabel('Temperature Change')
title('Temperature vs Time')
grid on
