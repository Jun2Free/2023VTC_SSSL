clear all; close all;%
c = 299792458.0;                    % Speed of light in m/s
fc = 2.4e+09;                    % frequency (MHz)
lambda = c/fc;

% initial target location estimation
dist = [10 15 20 25];
est_dist = [10.5 16 18 29];

% TP and PLE estimation
p = [20 15 10 5]';
H = [
    1 -10*log10(est_dist(1));
    1 -10*log10(est_dist(2));
    1 -10*log10(est_dist(3));
    1 -10*log10(est_dist(4));
    ];

z = inv(H'*H)*H'*p

