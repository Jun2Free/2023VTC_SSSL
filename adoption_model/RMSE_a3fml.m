%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

a = 30*(1:119);
b = a';

load('fmls.mat')
al1 = de;
al1 = [b, al1];

load('fmld.mat')
al2 = de;
al2 = [b, al2];

load('fmlms.mat')
al3 = de;
al3 = [b, al3];

load('fmlmd.mat')
al4 = de;
al4 = [b, al4];


p1=plot(al1(:,1), al1(:,2), 'b-.o', 'LineWidth',2, 'MarkerSize',10); hold on; grid on; %grid minor;
p2=plot(al2(:,1), al2(:,2), 'b->', 'LineWidth',2, 'MarkerSize',10,'MarkerEdgeColor','k'); hold on; grid on;
p3=plot(al3(:,1), al3(:,2), 'r-.o', 'LineWidth',2, 'MarkerSize',10); 
p4=plot(al4(:,1), al4(:,2), 'r->', 'LineWidth',2, 'MarkerSize',10,'MarkerEdgeColor','r'); 

p1.MarkerIndices = 1:3:length(al1);
p2.MarkerIndices = 1:3:length(al2);
p3.MarkerIndices = 1:3:length(al3);
p4.MarkerIndices = 1:3:length(al4);
xlim([0 3600]);
ylim([0 180]);

xlabel('Drone Distance from Take Off (meters)', FontSize=20)
ylabel('RMSE (meters)', FontSize=20)

legend("FML-SRL", "FML-DRL", "FMLM-SRL", "FMLM-DRL",FontSize=20);