%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RF Planning Studio
% Goal: See how simple design choices change link feasibility.
% Tests:
% 1) Increase gateway height by +5 m
% 2) Increase antenna gain to 5 dBi
% 3) Change environment exponent n = 2.0, 3.5, 4.0
% 4) Move obstacle position along the path for Fresnel study
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; close all;

%% -------------------------
% Baseline link parameters
%% -------------------------
c = 3e8;
f = 868e6;              % Hz
lambda = c/f;
D = 4000;               % m link length
Ptx = 14;               % dBm
Gtx = 2; Grx = 2;       % dBi
Lcable = 1;             % dB cable + connector loss
Srx = -120;             % dBm receiver sensitivity
fadeMargin = 10;        % dB safety margin
htx = 20; hrx = 2;      % m gateway and sensor heights
n = 2.7;                % environment exponent

% Obstacle for Fresnel study
xObs = 0.5 * D;
hObsAboveLOS = 3;       % m above LOS line
clearRatio = 0.60;      % 60% Fresnel clearance rule

%% -------------------------
% Helper formulas
%% -------------------------
FSPL = @(fHz, d) (20*log10(fHz) + 20*log10(d) - 147.55);
PLlog = @(PL0, d, d0, n) (PL0 + 10*n*log10(d./d0));
EIRP = @(Ptx, Gtx, Lc) (Ptx + Gtx - Lc);
PrxFun = @(EIRP, Grx, PL, m) (EIRP + Grx - PL - m);
FresnelR = @(lambda, x, D) sqrt((lambda .* x .* (D-x)) ./ D);

%% -------------------------
% Distance sweep
%% -------------------------
d = logspace(log10(200), log10(12000), 300);
dkm = d/1000;
d0 = 100;
PL0 = FSPL(f, d0);

%% -------------------------
% Baseline calculation
%% -------------------------
PL = PLlog(PL0, d, d0, n);
Prx = PrxFun(EIRP(Ptx, Gtx, Lcable), Grx, PL, fadeMargin);

% Estimate baseline coverage where received power is above sensitivity
idxBase = find(Prx >= Srx, 1, 'last');
rangeBase = dkm(idxBase);

%% -------------------------
% Fresnel baseline check
%% -------------------------
rF = FresnelR(lambda, xObs, D);
requiredClear = clearRatio * rF;
fresnelOK = (hObsAboveLOS < requiredClear);

%% -------------------------
% Experiment 1: Increase gateway height by +5 m
%% -------------------------
htx_1 = htx + 5;
maxLOS = 3.57*(sqrt(htx) + sqrt(hrx));
maxLOS_1 = 3.57*(sqrt(htx_1) + sqrt(hrx));

%% -------------------------
% Experiment 2: Increase antenna gains to 5 dBi
%% -------------------------
Gtx_2 = 5; Grx_2 = 5;
Prx_2 = PrxFun(EIRP(Ptx, Gtx_2, Lcable), Grx_2, PL, fadeMargin);
idxGain = find(Prx_2 >= Srx, 1, 'last');
rangeGain = dkm(idxGain);

%% -------------------------
% Experiment 3: Change environment exponent
%% -------------------------
n_values = [2.0 3.5 4.0];
Prx_n = zeros(length(n_values), length(d));
range_n = zeros(size(n_values));

for i = 1:length(n_values)
    PL_temp = PLlog(PL0, d, d0, n_values(i));
    Prx_n(i,:) = PrxFun(EIRP(Ptx, Gtx, Lcable), Grx, PL_temp, fadeMargin);
    idx = find(Prx_n(i,:) >= Srx, 1, 'last');
    if isempty(idx)
        range_n(i) = NaN;
    else
        range_n(i) = dkm(idx);
    end
end

%% -------------------------
% Experiment 4: Move obstacle position
%% -------------------------
xObs_values = [0.1 0.3 0.5 0.7 0.9] * D;
rF_values = FresnelR(lambda, xObs_values, D);
requiredClear_values = clearRatio * rF_values;
fresnelOK_values = hObsAboveLOS < requiredClear_values;

%% -------------------------
% Plot received power curves
%% -------------------------
figure('Name','RF Planning Studio');
semilogx(dkm, Prx, 'LineWidth', 2); grid on; hold on;
yline(Srx, '--', 'Sensitivity', 'LineWidth', 1.5);
semilogx(dkm, Prx_2, 'LineWidth', 2);
semilogx(dkm, Prx_n(1,:), 'LineWidth', 2);
semilogx(dkm, Prx_n(2,:), 'LineWidth', 2);
semilogx(dkm, Prx_n(3,:), 'LineWidth', 2);
xlabel('Distance (km)');
ylabel('Received power after margin (dBm)');
title('RF Planning Studio: Received Power vs Distance');
legend('Baseline n=2.7, Gain=2 dBi','Sensitivity','Gain=5 dBi','n=2.0','n=3.5','n=4.0','Location','best');

%% -------------------------
% Print results
%% -------------------------
fprintf('--- BASELINE ---\n');
fprintf('Frequency: %.0f MHz\n', f/1e6);
fprintf('Baseline estimated coverage: %.2f km\n', rangeBase);
fprintf('Max LOS distance: %.2f km\n', maxLOS);
fprintf('Fresnel at midpoint: r = %.2f m, 60%% = %.2f m, obstacle = %.2f m => %s\n', ...
    rF, requiredClear, hObsAboveLOS, string(fresnelOK));

fprintf('\n--- EXPERIMENT 1: HEIGHT +5 m ---\n');
fprintf('New gateway height: %.1f m\n', htx_1);
fprintf('New max LOS distance: %.2f km\n', maxLOS_1);
fprintf('LOS improvement: %.2f km\n', maxLOS_1 - maxLOS);

fprintf('\n--- EXPERIMENT 2: ANTENNA GAIN 5 dBi ---\n');
fprintf('Coverage with 5 dBi antennas: %.2f km\n', rangeGain);
fprintf('Range improvement over baseline: %.2f km\n', rangeGain - rangeBase);

fprintf('\n--- EXPERIMENT 3: ENVIRONMENT EXPONENT ---\n');
for i = 1:length(n_values)
    fprintf('n = %.1f => estimated coverage: %.2f km\n', n_values(i), range_n(i));
end

fprintf('\n--- EXPERIMENT 4: FRESNEL STUDY ---\n');
for i = 1:length(xObs_values)
    fprintf('Obstacle at %.0f%% of path: Fresnel r = %.2f m, 60%% = %.2f m, OK = %s\n', ...
        100*xObs_values(i)/D, rF_values(i), requiredClear_values(i), string(fresnelOK_values(i)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
