clc; clear;

lambda = 5e-6;          % PB density (sparse)
R = 500;                % Network radius (m)

alpha_LoS  = 3.2;
alpha_NLoS = 4.8;
beta = 0.02;            % Blockage severity

sigma = 8;              % Shadowing (dB)
MC = 10000;             % Monte Carlo runs


fc = 2.45e9;
c = 3e8;
lambda_c = c/fc;

Pt_dBm = 36;            % 4 W realistic EIRP
Pt = 10^((Pt_dBm-30)/10);

Gt = 10^(3/10);         % 3 dBi antenna
Gr = Gt;

P_sens = 1e-5;          % Rectifier sensitivity (−20 dBm)


Pmax = 3e-4;            % 5 mW saturation
a = 80;
b = 1e-4;