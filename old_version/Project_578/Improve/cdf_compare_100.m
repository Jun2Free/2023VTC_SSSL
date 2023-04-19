%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm - 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('LS_100.mat')
de_lin = de;

load('LS_100_3points.mat')
de_nonlin = de;

load('LS_100_all.mat')
de_lin2 = de;

load('LS_100_3points2.mat')
de_lin3 = de;

a = cdfplot(de_lin); 
set(a, 'LineStyle', '-', 'Color', 'r','LineWidth',3);
hold on; grid on;
b = cdfplot(de_nonlin)
set(b, 'LineStyle', '-', 'Color', 'b','LineWidth',3);
c = cdfplot(de_lin2)
set(c, 'LineStyle', '-', 'Color', 'g','LineWidth',3);
d = cdfplot(de_lin3)
set(d, 'LineStyle', '-', 'Color', 'k','LineWidth',3);

title('Performance Compare', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("LLS", "LLS_3points", "LLS_all", "LLS_border",FontSize=20);
