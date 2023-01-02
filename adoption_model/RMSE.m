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

plot(1:119, al1(:,1), 'b-.o', 'LineWidth',1); hold on; grid on;
plot(1:119, al2(:,1), 'm-.>', 'LineWidth',1); 
plot(1:119, al3(:,1), 'r-.^', 'LineWidth',1);
plot(1:119, al4(:,1), 'c-.square', 'LineWidth',1);
plot(1:119, al5(:,1), 'k-.v', 'LineWidth',1);

title('Performance Compare', FontSize=20)
xlabel('Number of Drone hops (30m per a hop)', FontSize=20)
ylabel('RMSE', FontSize=20)

legend("Consecutive", "All Points", "FML", "Convex Hull", "Closest", FontSize=20);