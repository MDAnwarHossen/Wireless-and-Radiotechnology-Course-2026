# Thermal Noise Simulation using MATLAB

## Objective

To simulate and analyze thermal noise using MATLAB, and visualize its characteristics in both time domain and frequency domain using Power Spectral Density (PSD).

---

## Parameters Used

- Bandwidth (B) = 1 MHz
- Resistance (R) = 100 ohms
- Temperature (T) = 300 K
- Boltzmann Constant (k) = 1.38 × 10^-23
- Number of Samples = 10000

---

## MATLAB Code

```matlab
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
```

---

## Results

### Time Domain Observation

The generated thermal noise signal changes randomly over time. The waveform does not follow a fixed pattern because thermal noise is caused by random movement of electrons inside a resistor.

### Power Spectral Density (PSD) Observation

The PSD plot shows how the noise power is distributed across frequency. Thermal noise behaves like white noise, meaning the power is nearly evenly spread across the bandwidth.

---

## Conclusion

Thermal noise increases when:

- Bandwidth increases
- Resistance increases
- Temperature increases

This experiment helps in understanding how thermal noise is generated and how it affects communication systems and electronic circuits.

---

## Submission Files

- thermal_noise.m
- Short Lab Report (PDF/Word or README file)
