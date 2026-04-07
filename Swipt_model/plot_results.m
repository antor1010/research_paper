function plot_results(Rate_TS, Energy_TS, Rate_PS, Energy_PS, params)

d = params.d;

% Trade-off plot
figure;
plot(Energy_TS(:,10), Rate_TS(:,10), '-o'); hold on;
plot(Energy_PS(:,10), Rate_PS(:,10), '-x');
xlabel('Energy');
ylabel('Rate');
legend('TS','PS');
title('Rate vs Energy');
grid on;

% Distance vs Energy
figure;
plot(d, Energy_TS(5,:), 'r'); hold on;
plot(d, Energy_PS(5,:), 'b');
xlabel('Distance');
ylabel('Energy');
legend('TS','PS');
title('Energy vs Distance');
grid on;

end