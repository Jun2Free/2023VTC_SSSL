%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('al12.mat')
al1 = de;

load('al22.mat')
al2 = de;

load('al32.mat')
al3 = de;

load('al42.mat')
al4 = de;

load('al5.mat')
al5 = de;
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

