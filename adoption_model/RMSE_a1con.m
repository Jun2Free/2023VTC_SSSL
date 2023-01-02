%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

a = 30*(1:119);
b = a';

load('al1.mat')
al1 = de;
al1 = [b, al1];

load('al12.mat')
al2 = de;
al2 = [b, al2];

load('con1s.mat')
al3 = de;
al3 = [b, al3];

load('con1d.mat')
al4 = de;
al4 = [b, al4];

load('con2s.mat')
al5 = de;
al5 = [b, al5];

load('con2d.mat')
al6 = de;
al6 = [b, al6];

p1=plot(al1(:,1), al1(:,2), 'k-.', 'LineWidth',2, 'MarkerSize',10); hold on; grid on; %grid minor;
p2=plot(al2(:,1), al2(:,2), 'k-x', 'LineWidth',2, 'MarkerSize',10, 'MarkerEdgeColor','k'); 
p3=plot(al3(:,1), al3(:,2), 'b-.', 'LineWidth',2, 'MarkerSize',10); 
p4=plot(al4(:,1), al4(:,2), 'b-^', 'LineWidth',2, 'MarkerSize',10,'MarkerEdgeColor','b'); 
p5=plot(al5(:,1), al5(:,2), 'r-.', 'LineWidth',2, 'MarkerSize',10); 
p6=plot(al6(:,1), al6(:,2), 'r-pentagram', 'LineWidth',2, 'MarkerSize',10,'MarkerEdgeColor','g'); 
p1.MarkerIndices = 1:5:length(al1);
p2.MarkerIndices = 1:5:length(al2);
p3.MarkerIndices = 1:5:length(al3);
p4.MarkerIndices = 1:5:length(al4);
p5.MarkerIndices = 1:5:length(al5);
p6.MarkerIndices = 1:5:length(al6);
xlim([0 3600]);
ylim([0 180]);

xlabel('Drone Distance from Take Off (meters)', FontSize=20)
ylabel('RMSE (meters)', FontSize=20)

legend("CON-SRL", "CON-DRL", "CON-I-SRL", "CON-I-DRL", "CON-II-SRL", "CON-II-DRL",FontSize=20);