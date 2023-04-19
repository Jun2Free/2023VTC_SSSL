close all; clear all;

load rss_omni.mat
load rss_dipole.mat

x = 1:1:100;
x_axis = x'
y_axis_omni = rss_omni';
y_axis_dipole = rss_dipole';
f1=fit(y_axis_omni,x_axis,'poly2');
f2=fit(y_axis_dipole,x_axis,'poly2');

%%
%{
figure(1)
plot(f1,x_axis,y_axis_omni); grid on;
figure(2)
plot(f2,x_axis,y_axis_dipole); grid on;
%}

%%
plot(f1,y_axis_omni,x_axis); grid on;
figure(2)
plot(f2,y_axis_dipole,x_axis); grid on;