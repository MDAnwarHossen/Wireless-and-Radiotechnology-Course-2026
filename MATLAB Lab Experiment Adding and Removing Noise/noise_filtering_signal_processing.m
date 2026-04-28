% Noise Addition and Removal from a Signal using MATLAB
% Objective: Generate a sinusoidal signal, add Gaussian white noise,
% and remove high-frequency noise using a low-pass Butterworth filter.

clc;
clear;
close all;

%% Parameters
fs = 1000;              % Sampling frequency in Hz
t = 0:1/fs:1;           % Time vector from 0 to 1 second
f_signal = 5;           % Frequency of sinusoidal signal in Hz
amplitude = 1;          % Amplitude of signal
noise_level = 0.5;      % Noise strength
cutoff_frequency = 10;  % Low-pass filter cutoff frequency in Hz
filter_order = 4;       % Butterworth filter order

%% Generate sinusoidal signal
original_signal = amplitude * sin(2*pi*f_signal*t);

%% Add Gaussian white noise
noise = noise_level * randn(size(t));
noisy_signal = original_signal + noise;

%% Design low-pass Butterworth filter
normalized_cutoff = cutoff_frequency / (fs/2);
[b, a] = butter(filter_order, normalized_cutoff, 'low');

%% Apply filter
filtered_signal = filtfilt(b, a, noisy_signal);

%% Plot original and noisy signals
figure;
plot(t, original_signal, 'LineWidth', 1.5);
hold on;
plot(t, noisy_signal);
grid on;
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Original Signal and Noisy Signal');
legend('Original Signal', 'Noisy Signal');

%% Plot filtered signal
figure;
plot(t, original_signal, 'LineWidth', 1.5);
hold on;
plot(t, filtered_signal, 'LineWidth', 1.5);
grid on;
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Original Signal and Filtered Signal');
legend('Original Signal', 'Filtered Signal');

%% Plot all signals together
figure;
plot(t, original_signal, 'LineWidth', 1.5);
hold on;
plot(t, noisy_signal);
plot(t, filtered_signal, 'LineWidth', 1.5);
grid on;
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Noise Addition and Removal using Low-pass Filter');
legend('Original Signal', 'Noisy Signal', 'Filtered Signal');

%% Display information
fprintf('Sampling frequency: %d Hz\n', fs);
fprintf('Signal frequency: %d Hz\n', f_signal);
fprintf('Noise level: %.2f\n', noise_level);
fprintf('Cutoff frequency: %d Hz\n', cutoff_frequency);
fprintf('Filter order: %d\n', filter_order);
