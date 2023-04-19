%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm - 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('LS_500.mat')
de_lin = de;

load('LS_500_3points.mat')
de_nonlin = de;

load('LS_500_all.mat')
de_lin2 = de;

a = cdfplot(de_lin); 
set(a, 'LineStyle', '-', 'Color', 'r','LineWidth',3);
hold on; grid on;
b = cdfplot(de_nonlin)
set(b, 'LineStyle', '-', 'Color', 'b','LineWidth',3);
c = cdfplot(de_lin2)
set(c, 'LineStyle', '-', 'Color', 'g','LineWidth',3);

title('Performance Compare', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("LLS", "LLS_{3points}", "LLS_{all}", FontSize=20);
