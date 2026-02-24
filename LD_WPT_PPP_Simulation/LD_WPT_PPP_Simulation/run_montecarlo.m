function Pdc_MC = run_montecarlo(MC, lambda, R, Pt, Gt, Gr, ...
    alpha_LoS, alpha_NLoS, beta, sigma, Pmax, a, b, P_sens)

Pdc_MC = zeros(MC,1);

for m = 1:MC

    r = ppp_generation(lambda, R);
    if isempty(r)
        continue;
    end

    h = channel_model(r, alpha_LoS, alpha_NLoS, beta, sigma);


    Pr = Pt * Gt * Gr * max(h);


    Pr = max(Pr - P_sens, 0);

    Pdc_MC(m) = rectifier_model(Pr, Pmax, a, b);

end

end