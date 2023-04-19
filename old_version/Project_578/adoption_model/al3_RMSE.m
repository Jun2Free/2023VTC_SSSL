%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('al3.mat')
al1 = de;

load('al32.mat')
al2 = de;


plot(1:119, al1(:,1), 'b-.o', 'LineWidth',1); hold on; grid on;
plot(1:119, al2(:,1), 'm-.>', 'LineWidth',1); 

title('Algorithm 3', FontSize=20)
xlabel('Number of Drone hops (30m per a hop)', FontSize=20)
ylabel('RMSE', FontSize=20)

legend("Fixed", "Dynamic", FontSize=20);