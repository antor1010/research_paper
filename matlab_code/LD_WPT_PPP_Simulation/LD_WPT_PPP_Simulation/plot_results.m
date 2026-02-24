theta = logspace(-7,-3,50);

Pc = zeros(length(theta),1);

for i = 1:length(theta)
    Pc(i) = mean(Pdc_MC > theta(i));
end

figure;
semilogx(theta, Pc, 'LineWidth',2);
grid on;
xlabel('Energy Threshold \theta (W)');
ylabel('Energy Coverage Probability');
title('Energy Coverage Probability for Long-Distance WPT');
ylim([0 1]);