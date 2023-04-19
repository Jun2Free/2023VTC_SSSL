%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm - 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('LS_300.mat')
de_lin = de;

load('LS_300_all.mat')
de_all = de;

load('LS_300_3points.mat')
de_fml = de;

load('LS_300_3points2.mat')
de_bd = de;

load('LS_300_3points3.mat')
de_fur = de;

a = cdfplot(de_lin); 
set(a, 'LineStyle', '-', 'Color', 'r','LineWidth',3);
hold on; grid on;
b = cdfplot(de_all)
set(b, 'LineStyle', '-', 'Color', 'b','LineWidth',3);
c = cdfplot(de_fml)
set(c, 'LineStyle', '-', 'Color', 'g','LineWidth',3);
d = cdfplot(de_bd)
set(d, 'LineStyle', '-', 'Color', 'k','LineWidth',3);
e = cdfplot(de_fur)
set(e, 'LineStyle', '-', 'Color', 'y','LineWidth',3);

title('Performance Compare', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("Consecutive", "Accumulative", "First-Mid-Last", "Border", "Furthest", FontSize=20);
