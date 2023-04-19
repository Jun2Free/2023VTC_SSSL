%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('/Users/jun/Documents/MATLAB/Localization/working/Working/Analysis/Comp_Traj/NLS_100_P.mat')
de_parall = de;

load('/Users/jun/Documents/MATLAB/Localization/working/Working/Analysis/Comp_Traj/NLS_100_S.mat')
de_squre = de;

b = cdfplot(de_parall)
set(b, 'LineStyle', '-', 'Color', 'b','LineWidth',3);
hold on; grid on;
c = cdfplot(de_squre)
set(c, 'LineStyle', '-', 'Color', 'r','LineWidth',3);

title('Trajectory Compare', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("Parallel Model", "Squre Model", FontSize=20);
