%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm - 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('LS_100.mat')
de_100 = de;

load('LS_300.mat')
de_300 = de;

load('LS_500.mat')
de_500 = de;

load('NLS_100.mat')
de_100_nls = de;

load('NLS_300.mat')
de_300_nls = de;

load('NLS_500.mat')
de_500_nls = de;

a = cdfplot(de_100); 
set(a, 'LineStyle', '-', 'Color', 'r','LineWidth',3);
hold on; grid on;

b = cdfplot(de_300)
set(b, 'LineStyle', '--', 'Color', 'r','LineWidth',3);

c = cdfplot(de_500)
set(c, 'LineStyle', ':', 'Color', 'r','LineWidth',3);

d = cdfplot(de_100_nls); 
set(d, 'LineStyle', '-', 'Color', 'b','LineWidth',3);
hold on; grid on;

e = cdfplot(de_300_nls)
set(e, 'LineStyle', '--', 'Color', 'b','LineWidth',3);

f = cdfplot(de_500_nls)
set(f, 'LineStyle', ':', 'Color', 'b','LineWidth',3);

title('Map size & Performance(m)', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("100(m) - LLS", "300(m) - LLS", "500(m) - LLS", ...
    "100(m) - NLS", "300(m) - NLS", "500(m) - NLS", FontSize=20);
