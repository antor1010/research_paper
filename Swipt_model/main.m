clc;
clear;
close all;

% Load parameters
params = parameters();

% Run models
[Rate_TS, Energy_TS] = ts_model(params);
[Rate_PS, Energy_PS] = ps_model(params);

% Plot results
plot_results(Rate_TS, Energy_TS, Rate_PS, Energy_PS, params);