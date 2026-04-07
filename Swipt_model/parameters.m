function params = parameters()

params.Pt = 1;           % Transmit Power (W)
params.sigma2 = 1e-3;   % Noise Power
params.alpha = 3;       % Path loss exponent
params.d = 1:1:50;      % Distance

params.tau = 0:0.1:1;   % TS parameter
params.rho = 0:0.1:1;   % PS parameter

end