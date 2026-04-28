clc;
clear;
close all;

% Parameters
B = 1e6;              % Bandwidth = 1 MHz
R = 100;              % Resistance = 100 ohms
T = 300;              % Temperature = 300 K
k = 1.38e-23;         % Boltzmann constant
n_samples = 10000;

% Time vector
time = 0 : 1/B : (n_samples-1)/B;

% Thermal noise voltage
thermal_noise = sqrt(4 * k * T * R * B) * randn(1, n_samples);

% Time domain plot
figure;
plot(time, thermal_noise);
xlabel('Time (s)');
ylabel('Noise Voltage (V)');
title('Thermal Noise in Time Domain');
grid on;

% PSD Analysis
[psd, freq] = pwelch(thermal_noise, [], [], [], B);

figure;
semilogx(freq, 10*log10(psd));
xlabel('Frequency (Hz)');
ylabel('PSD (dB/Hz)');
title('Power Spectral Density of Thermal Noise');
grid on;