%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('al1.mat')
al1 = de_avg;

load('al2.mat')
al2 = de_avg;

load('al3.mat')
al3 = de_avg;

load('al4.mat')
al4 = de_avg;

load('al5.mat')
al5 = de_avg;

figure(1)
plot(1:119, al1(:,1), 'b:o', 'LineWidth',1); legend("Consecutive", FontSize=20); grid on;
figure(2)
plot(1:119, al2(:,1), 'm-->', 'LineWidth',1); legend("All Points", FontSize=20); grid on;
figure(3)
plot(1:119, al3(:,1), 'r--^', 'LineWidth',1);legend("FML", FontSize=20); grid on;
figure(4) 
plot(1:119, al4(:,1), 'c-.square', 'LineWidth',1); legend("Convex Hull", FontSize=20); grid on;
figure(5) 
plot(1:119, al5(:,1), 'k-.v', 'LineWidth',1); legend("Closest", FontSize=20); grid on;

