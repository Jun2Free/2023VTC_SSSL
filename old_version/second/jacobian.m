clear all; close all;%

trc_location = [1 1];
node_location = [5 5];
L0 = 0 %dBm
v = [normrnd(0,1)];

dist_1 = sqrt((node_location(1,1) - trc_location(1)).^2 + (node_location(1,2) - trc_location(2)).^2);



syms x y alpha
F1 = (x^2)*y;
F2 = (5*x) + sin(y);

F = [F1; F2]
J = jacobian(F, [x,y])