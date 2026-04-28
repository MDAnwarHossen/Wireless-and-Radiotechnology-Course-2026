% ASK Modulation and Demodulation with Different SNR Values
% Objective:
% To investigate how varying Signal-to-Noise Ratio (SNR) affects
% the demodulation performance of a communication system.

clc;
clear;
close all;

%% Parameters
fs = 1000;              % Sampling frequency in Hz
t = 0:1/fs:1;           % Time vector
f_c = 50;               % Carrier frequency in Hz
SNR_values = [10 5 0 -5]; % SNR values in dB

%% Generate Binary Message Signal
message_signal = randi([0 1], 1, length(t));

%% ASK Modulation
carrier = cos(2*pi*f_c*t);
modulated_signal = message_signal .* carrier;

%% Plot Original Message and Modulated Signal
figure;
subplot(2,1,1);
plot(t, message_signal, 'LineWidth', 1.2);
title('Original Binary Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-0.2 1.2]);

subplot(2,1,2);
plot(t, modulated_signal, 'LineWidth', 1.2);
title('ASK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% Noise Addition and Demodulation for Different SNR Values
for i = 1:length(SNR_values)
    SNR = SNR_values(i);

    % Add Gaussian white noise
    received_signal = awgn(modulated_signal, SNR, 'measured');

    % Coherent demodulation: multiply by same carrier
    demodulated_raw = received_signal .* carrier;

    % Low-pass filter to remove high-frequency components
    cutoff_frequency = 20; % Hz
    [b, a] = butter(5, cutoff_frequency/(fs/2), 'low');
    filtered_signal = filtfilt(b, a, demodulated_raw);

    % Decision threshold
    threshold = 0.25;
    demodulated_bits = filtered_signal > threshold;

    % Calculate Bit Error Rate
    bit_errors = sum(message_signal ~= demodulated_bits);
    BER = bit_errors / length(message_signal);

    % Display results in command window
    fprintf('SNR = %d dB | Bit Errors = %d | BER = %.4f\n', SNR, bit_errors, BER);

    % Plot results
    figure;

    subplot(4,1,1);
    plot(t, modulated_signal, 'LineWidth', 1.1);
    title(['Original ASK Modulated Signal, SNR = ', num2str(SNR), ' dB']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

    subplot(4,1,2);
    plot(t, received_signal, 'LineWidth', 1.1);
    title(['Received Signal with Noise, SNR = ', num2str(SNR), ' dB']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

    subplot(4,1,3);
    plot(t, filtered_signal, 'LineWidth', 1.1);
    hold on;
    yline(threshold, '--', 'Threshold');
    title('Filtered Demodulated Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

    subplot(4,1,4);
    plot(t, demodulated_bits, 'LineWidth', 1.1);
    title(['Final Demodulated Binary Signal | BER = ', num2str(BER)]);
    xlabel('Time (s)');
    ylabel('Bit Value');
    grid on;
    ylim([-0.2 1.2]);
end
