
clear; clc; close all;

%% ---------------- 1. SYSTEM PARAMETERS -------------------------

fc      = 915e6;        
c       = 3e8;          
lambda  = c/fc;         
Pt_dBm  = 20;            
                         

Pt      = 10^((Pt_dBm-30)/10);

Gt      = 10^(6/10);     
Gr      = 10^(2.15/10);  

B       = 1e6;           
N0_dBm  = -70;           
                        

N0      = 10^((N0_dBm-30)/10);

eta     = 0.6;           
alpha_r = linspace(0,1,200);  
rho_r   = linspace(0,1,200);   

%% ---------------- 2. DISTANCE / PATH-LOSS ASSUMPTIONS -----------

distances = [10 30 50];    
n_path    = 2.5;            

colors = {'b','r',[0.1 0.6 0.1]};

%% ---------------- 3. COMPUTE Pr, SNR FOR EACH DISTANCE -----------

Pr    = zeros(size(distances));
gamma = zeros(size(distances));

for k = 1:length(distances)
    d = distances(k);
    PL = (lambda/(4*pi*d))^n_path;
    Pr(k)    = Pt * Gt * Gr * PL;
    gamma(k) = Pr(k) / N0;
end

fprintf('=====================================================\n');
fprintf(' Distance-dependent Link Budget (n = %.1f)\n', n_path);
fprintf('=====================================================\n');
for k = 1:length(distances)
    fprintf(' d = %3d m | Pr = %8.4e W | SNR = %8.2f (%.2f dB)\n', ...
        distances(k), Pr(k), gamma(k), 10*log10(gamma(k)));
end
fprintf('=====================================================\n\n');

%% ---------------- 4. TS & PS RATE-ENERGY MODELS -------------------


figure('Name','SWIPT TS vs PS Trade-off','Color','w');
hold on; grid on; box on;

legend_entries = {};

for k = 1:length(distances)

    R_TS = (1-alpha_r) .* B .* log2(1+gamma(k));
    E_TS = alpha_r .* eta .* Pr(k);

    R_PS = B .* log2(1 + rho_r.*gamma(k));
    E_PS = (1-rho_r) .* eta .* Pr(k);

    plot(E_TS*1e6, R_TS/1e6, '-',  'Color', colors{k}, 'LineWidth', 2);
    plot(E_PS*1e6, R_PS/1e6, '--', 'Color', colors{k}, 'LineWidth', 2);

    legend_entries{end+1} = sprintf('TS, d=%dm', distances(k)); 
    legend_entries{end+1} = sprintf('PS, d=%dm', distances(k));

    fprintf('d = %3d m | Max TS Rate = %6.3f Mbps | Max TS Energy = %6.4f µW\n', ...
        distances(k), max(R_TS)/1e6, max(E_TS)*1e6);
    fprintf('           | Max PS Rate = %6.3f Mbps | Max PS Energy = %6.4f µW\n', ...
        max(R_PS)/1e6, max(E_PS)*1e6);
end

xlabel('Harvested Energy (µW)');
ylabel('Information Rate (Mbps)');
title('SWIPT Rate-Energy Trade-off: TS (solid) vs PS (dashed)');
legend(legend_entries, 'Location', 'northeast');
set(gca,'FontSize',11);

drawnow;
saveas(gcf, fullfile(pwd,'SWIPT_Tradeoff.png'));
fprintf('\nPlot saved as SWIPT_Tradeoff.png\n');

%% ---------------- 5. SNR SENSITIVITY (fixed distance) -------------

d_fixed   = 30;
PL_fixed  = (lambda/(4*pi*d_fixed))^n_path;
Pr_fixed  = Pt*Gt*Gr*PL_fixed;
gamma0    = Pr_fixed / N0;

snr_offsets_dB = [-3 0 3];
figure('Name','SWIPT under SNR uncertainty','Color','w');
hold on; grid on; box on;
legend_entries2 = {};

for i = 1:length(snr_offsets_dB)
    g = gamma0 * 10^(snr_offsets_dB(i)/10);

    R_PS = B .* log2(1 + rho_r.*g);
    E_PS = (1-rho_r) .* eta .* Pr_fixed;

    plot(E_PS*1e6, R_PS/1e6, 'LineWidth', 2);
    legend_entries2{end+1} = sprintf('PS, SNR offset = %+d dB', snr_offsets_dB(i));
end

xlabel('Harvested Energy (µW)');
ylabel('Information Rate (Mbps)');
title(sprintf('PS Rate-Energy under SNR Uncertainty (d = %d m)', d_fixed));
legend(legend_entries2, 'Location', 'northeast');
set(gca,'FontSize',11);

drawnow;
saveas(gcf, fullfile(pwd,'SWIPT_SNR_Sensitivity.png'));
fprintf('Plot saved as SWIPT_SNR_Sensitivity.png\n');