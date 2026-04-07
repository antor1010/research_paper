function [Rate_TS, Energy_TS] = ts_model(params)

Pt = params.Pt;
sigma2 = params.sigma2;
alpha = params.alpha;
d = params.d;
tau = params.tau;

h = 1 ./ (d.^alpha);

Rate_TS = zeros(length(tau), length(d));
Energy_TS = zeros(length(tau), length(d));

for i = 1:length(tau)
    for j = 1:length(d)
        Rate_TS(i,j) = (1 - tau(i)) * log2(1 + Pt*h(j)/sigma2);
        Energy_TS(i,j) = tau(i) * Pt * h(j);
    end
end

end