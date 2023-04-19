%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('LLS_100_P.mat')
de_parall = de;

load('LLS_100_S.mat')
de_squre = de;

load('NLS_100_P.mat')
de_parall_nls = de;

load('NLS_100_S.mat')
de_squre_nls = de;

a = cdfplot(de_parall)
set(a, 'LineStyle', '-', 'Color', 'b','LineWidth',3);
hold on; grid on;
b = cdfplot(de_squre)
set(b, 'LineStyle', '--', 'Color', 'b','LineWidth',3);
c = cdfplot(de_parall_nls)
set(c, 'LineStyle', '-', 'Color', 'r','LineWidth',3);
d = cdfplot(de_squre_nls)
set(d, 'LineStyle', '--', 'Color', 'r','LineWidth',3);

title('Trajectory Compare', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("Parallel - LLS", "Squre - LLS", "Parallel - NLS", "Squre - NLS",FontSize=20);
