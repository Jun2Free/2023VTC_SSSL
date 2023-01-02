%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

a = 30*(1:119);
b = a';

load('al5.mat')
al1 = de;
al1 = [b, al1];

load('al52.mat')
al2 = de;
al2 = [b, al2];


p1=plot(al1(:,1), al1(:,2), 'b-.o', 'LineWidth',2, 'MarkerSize',10); hold on; grid on; %grid minor;
p2=plot(al2(:,1), al2(:,2), 'r-.>', 'LineWidth',2, 'MarkerSize',10); 
p1.MarkerIndices = 1:5:length(al1);
p2.MarkerIndices = 1:5:length(al2);
xlim([0 3600]);
ylim([0 180]);

xlabel('Drone Distance from Take Off (meters)', FontSize=20)
ylabel('RMSE (meters)', FontSize=20)

legend("CLS-SRL", "CLS-DRL", FontSize=20);