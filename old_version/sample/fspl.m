close all; clear all;

load rss.mat
Pt_dBm = Pr_Friss;
i = 2;
N = length(Pt_dBm);

up = log10(1/1) * (Pt_dBm(1) - Pt_dBm(1));
down = (log10(1/1)).^2;
while i <= N
    up = up + log10(i/1) * abs((Pt_dBm(i) - Pt_dBm(1)));
    down = down + (log10(i/1)).^2;
    i = i+1;
end

estimated_n = up / (10*down)

ii = 2;
sig = (Pt_dBm(1)-Pt_dBm(1)-10*estimated_n*log10(1/1)).^2;
while ii <= N
    sig = sig + (Pt_dBm(ii)-Pt_dBm(1)-10*estimated_n*log10(ii/1)).^2;
    ii = ii+1;
end

estimated_sigma = 1/N * sig

estimated_d = 10.^((Pt_dBm(1) - Pt_dBm(496))./(10*estimated_n))




