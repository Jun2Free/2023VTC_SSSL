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

plot(al1(:,1), al1(:,2), 'b-.o', 'LineWidth',1); hold on; grid on; grid minor;
plot(al2(:,1), al2(:,2), 'm-.>', 'LineWidth',1); 
plot(al3(:,1), al3(:,2), 'r-.^', 'LineWidth',1);
plot(al4(:,1), al4(:,2), 'c-.square', 'LineWidth',1);
plot(al5(:,1), al5(:,2), 'k-.v', 'LineWidth',1);
xlim([0 3600]);
ylim([0 180]);

title('Performance Compare', FontSize=20)
xlabel('Drone Distance from Take Off (meters)', FontSize=20)
ylabel('RMSE', FontSize=20)

legend("Consecutive", "All Points", "FML", "Convex Hull", "Closest", FontSize=20);