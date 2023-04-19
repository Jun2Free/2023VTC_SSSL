%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm - 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('LS_300.mat')
de_lin = de;

load('NLS_300.mat')
de_nonlin = de;

a = cdfplot(de_lin); 
set(a, 'LineStyle', '-', 'Color', 'r','LineWidth',3);
hold on; grid on;
b = cdfplot(de_nonlin)
set(b, 'LineStyle', '-', 'Color', 'b','LineWidth',3);

title('Performance Compare', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("LLS", "NLLS", FontSize=20);
