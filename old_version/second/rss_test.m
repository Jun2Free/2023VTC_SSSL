clear all; close all;%
c = 299792458.0;                    % Speed of light in m/s
fc = 2.4e+09;                    % frequency (MHz)
lambda = c/fc;
alpha = 10^-6;
beta = 2.5;
rss_arr = [];

idx = 1;
while idx < 100
    mu = normrnd(0, 3);
    dist = 1:0.05:10;
    rss = alpha.*(10.^(mu./10))*dist.^-beta;
    rss_arr = [rss_arr; rss];
    idx = idx + 1;
end

avg = alpha .* dist.^-beta;
%%
plot(dist, rss_arr, 'x'); hold on;
plot(dist, avg, '-');


