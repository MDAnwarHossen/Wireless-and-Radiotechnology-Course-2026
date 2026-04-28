% communication_assignment.m
% Wireless Communication Performance Simulation
% Technologies: WiFi, Bluetooth, and Cellular
% This script calculates and plots received power, SINR, and channel capacity
% as a function of distance using the Friis transmission equation.

clear all;
close all;
clc;

%% Common parameters
G_t = 1;              % Transmitting antenna gain
G_r = 1;              % Receiving antenna gain
c = 3*1e8;            % Speed of light in m/s
Pn = 500*1e-6;        % Noise power in watts

%% Task 1: WiFi Simulation
f_wifi = 2.4*1e9;     % WiFi frequency in Hz (IEEE 802.11b)
BW_wifi = 22*1e6;     % WiFi bandwidth in Hz
d_wifi = 1:5:100;     % Distance range in meters
P_t_wifi = 100*1e-3;  % WiFi transmit power in watts
lamb_wifi = c/f_wifi; % WiFi wavelength

% Friis received power
Pr_wifi = (P_t_wifi*G_t*G_r*lamb_wifi^2)./((4*pi*d_wifi).^2);
Pr_wifi_dB = 10*log10(Pr_wifi);

% SINR calculation
SINR_wifi = Pr_wifi./Pn;
SINR_wifi_dB = 10*log10(SINR_wifi);

% Channel capacity
C_wifi = BW_wifi*log2(1 + SINR_wifi);
C_wifi_dB = 10*log10(C_wifi);

%% Task 2: Bluetooth Simulation
f_bluetooth = 2.45*1e9;       % Bluetooth frequency in Hz
BW_bluetooth = 2*1e6;         % Bluetooth bandwidth in Hz
d_bluetooth = 0.5:0.5:10;     % Distance range in meters
P_t_bluetooth = 10*1e-3;      % Bluetooth transmit power in watts
lamb_bluetooth = c/f_bluetooth;

Pr_bluetooth = (P_t_bluetooth*G_t*G_r*lamb_bluetooth^2)./((4*pi*d_bluetooth).^2);
Pr_bluetooth_dB = 10*log10(Pr_bluetooth);

SINR_bluetooth = Pr_bluetooth./Pn;
SINR_bluetooth_dB = 10*log10(SINR_bluetooth);

C_bluetooth = BW_bluetooth*log2(1 + SINR_bluetooth);
C_bluetooth_dB = 10*log10(C_bluetooth);

%% Task 3: Cellular Simulation
f_cellular = 850*1e6;         % Cellular frequency in Hz (2G GSM)
BW_cellular = 200*1e3;        % Cellular bandwidth in Hz
d_cellular = 100:100:5000;    % Distance range in meters
P_t_cellular = 40;            % Cellular transmit power in watts
lamb_cellular = c/f_cellular;

Pr_cellular = (P_t_cellular*G_t*G_r*lamb_cellular^2)./((4*pi*d_cellular).^2);
Pr_cellular_dB = 10*log10(Pr_cellular);

SINR_cellular = Pr_cellular./Pn;
SINR_cellular_dB = 10*log10(SINR_cellular);

C_cellular = BW_cellular*log2(1 + SINR_cellular);
C_cellular_dB = 10*log10(C_cellular);

%% Plot results for each technology
figure('Name','Wireless Communication Performance');

% Received Power plots
subplot(3,3,1);
plot(d_wifi, Pr_wifi_dB, 'LineWidth', 1.5);
title('WiFi');
ylabel('P_r (dB)');
grid on;

subplot(3,3,2);
plot(d_bluetooth, Pr_bluetooth_dB, 'LineWidth', 1.5);
title('Bluetooth');
grid on;

subplot(3,3,3);
plot(d_cellular, Pr_cellular_dB, 'LineWidth', 1.5);
title('Cellular');
grid on;

% SINR plots
subplot(3,3,4);
plot(d_wifi, SINR_wifi_dB, 'LineWidth', 1.5);
ylabel('SINR (dB)');
grid on;

subplot(3,3,5);
plot(d_bluetooth, SINR_bluetooth_dB, 'LineWidth', 1.5);
grid on;

subplot(3,3,6);
plot(d_cellular, SINR_cellular_dB, 'LineWidth', 1.5);
grid on;

% Capacity plots
subplot(3,3,7);
plot(d_wifi, C_wifi_dB, 'LineWidth', 1.5);
ylabel('Capacity (dB)');
xlabel('distance (m)');
grid on;

subplot(3,3,8);
plot(d_bluetooth, C_bluetooth_dB, 'LineWidth', 1.5);
xlabel('distance (m)');
grid on;

subplot(3,3,9);
plot(d_cellular, C_cellular_dB, 'LineWidth', 1.5);
xlabel('distance (m)');
grid on;

%% Task 4: Comparative Analysis
figure('Name','Comparative Analysis');

subplot(3,1,1);
plot(d_wifi, Pr_wifi_dB, 'LineWidth', 1.5); hold on;
plot(d_bluetooth, Pr_bluetooth_dB, 'LineWidth', 1.5);
plot(d_cellular, Pr_cellular_dB, 'LineWidth', 1.5);
title('Received Power Comparison');
ylabel('P_r (dB)');
legend('WiFi','Bluetooth','Cellular');
grid on;

subplot(3,1,2);
plot(d_wifi, SINR_wifi_dB, 'LineWidth', 1.5); hold on;
plot(d_bluetooth, SINR_bluetooth_dB, 'LineWidth', 1.5);
plot(d_cellular, SINR_cellular_dB, 'LineWidth', 1.5);
title('SINR Comparison');
ylabel('SINR (dB)');
legend('WiFi','Bluetooth','Cellular');
grid on;

subplot(3,1,3);
plot(d_wifi, C_wifi_dB, 'LineWidth', 1.5); hold on;
plot(d_bluetooth, C_bluetooth_dB, 'LineWidth', 1.5);
plot(d_cellular, C_cellular_dB, 'LineWidth', 1.5);
title('Channel Capacity Comparison');
ylabel('Capacity (dB)');
xlabel('distance (m)');
legend('WiFi','Bluetooth','Cellular');
grid on;

%% Display short numerical summary
fprintf('Wireless Communication Simulation Summary\n');
fprintf('-----------------------------------------\n');
fprintf('WiFi:      Pr at first distance = %.2f dB, Pr at last distance = %.2f dB\n', Pr_wifi_dB(1), Pr_wifi_dB(end));
fprintf('Bluetooth: Pr at first distance = %.2f dB, Pr at last distance = %.2f dB\n', Pr_bluetooth_dB(1), Pr_bluetooth_dB(end));
fprintf('Cellular:  Pr at first distance = %.2f dB, Pr at last distance = %.2f dB\n', Pr_cellular_dB(1), Pr_cellular_dB(end));
