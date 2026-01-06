%% REAL FIXED 60 SEC RECORDER + PLOTS
clear; clc; close all;

port = '/dev/cu.usbmodem101';
baud = 115200;

s = serialport(port, baud);
flush(s);

disp('Recording 60 seconds...');
duration = 60;
Fs = 50;
N = Fs * duration;

x = zeros(N,1);
t = (0:N-1)/Fs;

for k = 1:N
    raw = readline(s);      
    value = str2double(raw);
    if isnan(value)
        value = x(max(k-1,1));
    end
    x(k) = value;
end

disp('Done. Plotting now...');

%% Convert ADC to volts
rawSig = x * (5/1023);

%% Remove DC
x_dc = rawSig - mean(rawSig);

%% Manual bandpass
lowPassWindow = round(Fs/2);
x_low = movmean(x_dc, lowPassWindow);

driftWindow = round(Fs*8);
drift = movmean(x_low, driftWindow);

x_bandpassed = x_low - drift;

%% PLOTS
figure;

subplot(3,1,1);
plot(t, rawSig, 'k');
title('Raw Respiration Signal');
xlabel('Time (s)'); ylabel('Voltage (V)'); grid on;

subplot(3,1,2);
plot(t, x_dc, 'b');
title('DC Removed');
xlabel('Time (s)'); ylabel('Voltage (V)'); grid on;

subplot(3,1,3);
plot(t, x_bandpassed, 'r');
title('Filtered Signal (0.05–2.0 Hz Approx)');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;
