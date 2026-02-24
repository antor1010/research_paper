parameters

Pdc_MC = run_montecarlo(MC, lambda, R, Pt, Gt, Gr, ...
    alpha_LoS, alpha_NLoS, beta, sigma, Pmax, a, b, P_sens);

plot_results

fprintf('Min Pdc  = %.2e W\n', min(Pdc_MC));
fprintf('Mean Pdc = %.2e W\n', mean(Pdc_MC));
fprintf('Max Pdc  = %.2e W\n', max(Pdc_MC));