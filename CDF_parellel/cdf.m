%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cdf for the linear and nonlinear algorithm - 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('con.mat')
al1 = de;
load('con1.mat')
al12 = de;
load('con2.mat')
al13 = de;

load('al2.mat')
al2 = de;

load('al3.mat')
al3 = de;
load('al32.mat')
al31 = de;


load('al4.mat')
al4 = de;

load('al5.mat')
al5 = de;

a = cdfplot(al1); 
set(a, 'LineStyle', '-.', 'Color', 'r','LineWidth',2);
hold on; grid on;
a1 = cdfplot(al12); 
set(a1, 'LineStyle', '-', 'Color', 'b','LineWidth',2);
a2 = cdfplot(al13); 
set(a2, 'LineStyle', '-', 'Color', 'k','LineWidth',2);

b = cdfplot(al2)
set(b, 'LineStyle', '-', 'Color', 'g','LineWidth',2);

c = cdfplot(al3)
set(c, 'LineStyle', '-', 'Color', 'k','LineWidth',2);
c1 = cdfplot(al31)
set(c1, 'LineStyle', '-', 'Color', 'g','LineWidth',2);

d = cdfplot(al4)
set(d, 'LineStyle', '-', 'Color', 'b','LineWidth',2);

e = cdfplot(al5)
set(e, 'LineStyle', '-', 'Color', 'm','LineWidth',2);

xlabel('Long Term RMSE (meters)', FontSize=20)
ylabel('CDF', FontSize=20)

legend("CON","CON-I","CON-II", "CUM", "FML", "FMLM", "CHLM", "CLS", FontSize=20);
%%
var(al1)
var(al2)
var(al3)
var(al4)
var(al5)
