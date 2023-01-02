%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

a = 30*(1:119);
b = a';

load('al1.mat')
al1 = de_avg;
al1 = [b, al1];

load('al2.mat')
al2 = de_avg;
al2 = [b, al2];

load('al3.mat')
al3 = de_avg;
al3 = [b, al3];

load('al4.mat')
al4 = de_avg;
al4 = [b, al4];

load('al5.mat')
al5 = de_avg;
al5 = [b, al5];

p1 = plot(al1(:,1), al1(:,2), 'r-', 'LineWidth',2); hold on; grid on; grid minor;
p1.MarkerIndices = 1:5:length(al1);
p2 = plot(al2(:,1), al2(:,2), 'g-', 'LineWidth',2); 
p2.MarkerIndices = 1:5:length(al2);
p3 = plot(al3(:,1), al3(:,2), 'k-', 'LineWidth',2);
p3.MarkerIndices = 1:5:length(al3);
p4 = plot(al4(:,1), al4(:,2), 'b-', 'LineWidth',2);
p4.MarkerIndices = 1:5:length(al4);
p5 = plot(al5(:,1), al5(:,2), 'm-', 'LineWidth',2);
p5.MarkerIndices = 1:5:length(al5);
xlim([0 3600]);
ylim([0 180]);

xlabel('Drone Distance from Take Off (meters)', FontSize=20)
ylabel('RMSE', FontSize=20)

legend("CON", "CUM", "FML", "CHLM", "CLS", FontSize=20);