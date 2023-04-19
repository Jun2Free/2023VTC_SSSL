%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RMSE - Flight distance graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load('al1.mat')
al1 = de;

load('al2.mat')
al2 = de;

load('al3.mat')
al3 = de;

load('al4.mat')
al4 = de;

load('al5.mat')
al5 = de;

load('al6.mat')
al6 = de;

plot(al1(:,1), al1(:,2), 'b:o', 'LineWidth',1); hold on; grid on;
plot(al2(:,1), al2(:,2), 'm-->', 'LineWidth',1); 
plot(al3(:,1), al3(:,2), 'r--^', 'LineWidth',1);
plot(al4(:,1), al4(:,2), 'c-.square', 'LineWidth',1);
plot(al5(:,1), al5(:,2), 'g-.v', 'LineWidth',1);
plot(al6(:,1), al6(:,2), 'k-.<', 'LineWidth',1);

title('Performance Compare', FontSize=20)
xlabel('Flight Distance(m)', FontSize=20)
ylabel('RMSE', FontSize=20)

legend("al1", "al2", "al3","al4", "al5", "al6",FontSize=20);