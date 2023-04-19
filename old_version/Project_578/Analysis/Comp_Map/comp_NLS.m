%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm - 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('NLS_100.mat')
de_100 = de;

load('NLS_300.mat')
de_300 = de;

load('NLS_500.mat')
de_500 = de;

a = cdfplot(de_100); 
set(a, 'LineStyle', '-', 'Color', 'r','LineWidth',3);
hold on; grid on;

b = cdfplot(de_300)
set(b, 'LineStyle', '-', 'Color', 'b','LineWidth',3);

c = cdfplot(de_500)
set(c, 'LineStyle', '-', 'Color', 'k','LineWidth',3);

title('Map size & Performance(m)', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("100x100(m)", "300x300(m)", "500x500(m)", FontSize=20);
