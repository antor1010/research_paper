function [Rate_PS, Energy_PS] = ps_model(params)

Pt = params.Pt;
sigma2 = params.sigma2;
alpha = params.alpha;
d = params.d;
rho = params.rho;

h = 1 ./ (d.^alpha);

Rate_PS = zeros(length(rho), length(d));
Energy_PS = zeros(length(rho), length(d));

for i = 1:length(rho)
    for j = 1:length(d)
        Rate_PS(i,j) = log2(1 + (1 - rho(i))*Pt*h(j)/sigma2);
        Energy_PS(i,j) = rho(i) * Pt * h(j);
    end
end

end