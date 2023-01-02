%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;
a = 30*(1:119);
b = a';

load('al1.mat')
al1 = de_avg;
al1 = [b, al1];
load('al111.mat')
al11 = de_avg;
al11 = [b, al11];
load('al11.mat')
al111 = de_avg;
al111 = [b, al111];

load('al2.mat')
al2 = de_avg;
al2 = [b, al2];

load('al3.mat')
al3 = de_avg;
al3 = [b, al3];
load('al32.mat')
al32 = de_avg;
al32 = [b, al32];

load('al4.mat')
al4 = de_avg;
al4 = [b, al4];

load('al5.mat')
al5 = de_avg;
al5 = [b, al5];

figure(1)
yl = yline(20,'r-','LineWidth',2); hold on;
p1=plot(al1(:,1), al1(:,2), 'k-.o', 'LineWidth',2, 'MarkerSize',10); 
p2=plot(al11(:,1), al11(:,2), 'b-.>', 'LineWidth',2, 'MarkerSize',10); 
p3=plot(al111(:,1), al111(:,2), 'g-.^', 'LineWidth',2, 'MarkerSize',10); legend("Threshold", "CON", "CON-I", "CON-II", FontSize=20); grid on; xlim([0 3600]); ylim([0 180]);
p1.MarkerIndices = 1:5:length(al1);
p2.MarkerIndices = 1:5:length(al1);
p3.MarkerIndices = 1:5:length(al1);
xlabel('Drone Distance from Take Off (meters)', FontSize=20); ylabel('RMSE (meters)', FontSize=20);

figure(2)
yl = yline(20,'-','LineWidth',2, 'Color','r'); hold on;
p2=plot(al1(:,1), al2(:,2), 'b-.>', 'LineWidth',2, 'MarkerSize',10); legend("Threshold", "CUM", FontSize=20); grid on; xlim([0 3600]); ylim([0 180]);
p2.MarkerIndices = 1:5:length(al2);
xlabel('Drone Distance from Take Off (meters)', FontSize=20); ylabel('RMSE (meters)', FontSize=20);

figure(3)
yl = yline(20,'-','LineWidth',2, 'Color','r'); hold on;
p3=plot(al1(:,1), al3(:,2), 'g-.>', 'LineWidth',2, 'MarkerSize',10);
p32=plot(al1(:,1), al32(:,2), 'b-.>', 'LineWidth',2, 'MarkerSize',10);legend("Threshold", "FML", "FMLM", FontSize=20); grid on; xlim([0 3600]); ylim([0 180]);
p3.MarkerIndices = 1:5:length(al3);
p32.MarkerIndices = 1:5:length(al3);
xlabel('Drone Distance from Take Off (meters)', FontSize=20); ylabel('RMSE (meters)', FontSize=20);

figure(4) 
yl = yline(20,'-','LineWidth',2, 'Color','r'); hold on;
p4=plot(al1(:,1), al4(:,2), 'b-.>', 'LineWidth',2, 'MarkerSize',10); legend("Threshold", "CHLM", FontSize=20); grid on; xlim([0 3600]); ylim([0 180]);
p4.MarkerIndices = 1:5:length(al4);
xlabel('Drone Distance from Take Off (meters)', FontSize=20); ylabel('RMSE (meters)', FontSize=20);

figure(5) 
yl = yline(20,'-','LineWidth',2, 'Color','r'); hold on;
p5=plot(al1(:,1), al5(:,2), 'b-.>', 'LineWidth',2, 'MarkerSize',10); legend("Threshold", "CLS", FontSize=20); grid on; xlim([0 3600]); ylim([0 180]);
p5.MarkerIndices = 1:5:length(al5);
xlabel('Drone Distance from Take Off (meters)', FontSize=20); ylabel('RMSE (meters)', FontSize=20);
