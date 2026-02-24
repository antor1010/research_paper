function h = channel_model(r, alpha_LoS, alpha_NLoS, beta, sigma)

N = length(r);

P_LoS = exp(-beta * r);
isLoS = rand(N,1) < P_LoS;

alpha = alpha_NLoS * ones(N,1);
alpha(isLoS) = alpha_LoS;

shadowing = 10.^(sigma * randn(N,1) / 10);
fading = exprnd(1, N, 1);

h = fading .* shadowing .* r.^(-alpha);

end