%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm - 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('al1.mat')
al1 = de;

load('al2.mat')
al2 = de;

load('al3.mat')
al3 = de;

load('al4.mat')
al4 = de;

load('al5.mat')
al5 = de;

%load('al6.mat')
%al6 = de;

a = cdfplot(al1); 
set(a, 'LineStyle', '-', 'Color', 'b','LineWidth',2);
hold on; grid on;
b = cdfplot(al2)
set(b, 'LineStyle', '-', 'Color', 'm','LineWidth',2);
c = cdfplot(al3)
set(c, 'LineStyle', '-', 'Color', 'r','LineWidth',2);
d = cdfplot(al4)
set(d, 'LineStyle', '-', 'Color', 'c','LineWidth',2);
e = cdfplot(al5)
set(e, 'LineStyle', '-', 'Color', 'g','LineWidth',2);
%f = cdfplot(al6)
%set(f, 'LineStyle', '-', 'Color', 'k','LineWidth',2);

title('Performance Compare', FontSize=20)
xlabel('Error Distance(m)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("Consecutive", "All Points", "FML", "Convex Hull", "Closest", FontSize=20);
