clear all; close all;
c = 299792458.0;                    % Speed of light in m/s
fc = 2.4e+09;                    % frequency (MHz)
lambda = c/fc;

% In two-ray propagation model
Tx = [0 0];       % Tx location
Rx = zeros(100,2);
Rx(:,1) = 1:1:100;
tss = 30;     % Transmit signal strength (dBm)
ht = 10;      % transmitter height
hr = 20;
d = [];

% rss
rss_omni = [];
rss_dipole = [];
rss_fspl = [];
% est_d
fspl_est_d = [];
tworayo_est_d = [];
tworayd_est_d = [];

idx = 1;
while idx < size(Rx,1) + 1
    d(idx) = sqrt((Tx(1) - Rx(idx,1)).^2 + (Tx(2) - Rx(idx,2)).^2);  % horizontal distance btw rx and tx
    alpa = atan((ht-hr) ./d(idx));
    Gt_d = (cos(pi .*(lambda./2) .*fc ./c) .*sin(alpa) - cos(pi .*fc .*(lambda./2))) ./cos(alpa);
    Gr_d = Gt_d;
    G_d = Gt_d + Gr_d;       % Combined Antenna gain (dBm),  additional equation needed
    Gt_o = 2;
    Gr_o = Gt_o;
    G_o = Gt_o + Gr_o;

    % Received signal strength is
    rss_dipole(idx) = tss + 10 .* log10(G_d .* (ht.^2) .* (hr.^2)) - 40 .* log10(d(idx));
    rss_omni(idx) = tss + 10 .* log10(G_o .* (ht.^2) .* (hr.^2)) - 40 .* log10(d(idx));
    pl_dipole(idx) = tss - rss_dipole(idx);  % pl = 40 .* log10(d) - 10 .* log10(G .* (ht.^2) .* (hr.^2))
    pl_omni(idx) = tss - rss_omni(idx);  % pl = 40 .* log10(d) - 10 .* log10(G .* (ht.^2) .* (hr.^2))

    % two ray propagation model: pl = tx - rx = 40.*log10(d) - 10.*log10(G.*(ht.^2).*(hr.^2))
    tworayo_est_d(idx) = 10.^((tss - rss_omni(idx) + 10.*log10(G_o.*(ht.^2).*(hr.^2)))./40);
    tworayd_est_d(idx) = 10.^((tss - rss_dipole(idx) + 10.*log10(G_d.*(ht.^2).*(hr.^2)))./40);

    idx = idx + 1;
end

figure(1)
plot(1:1:100, rss_omni, 'r-x', 'LineWidth',2);  hold on; grid on;
plot(1:1:100, rss_dipole, 'b-x', 'LineWidth',2);  
xlabel('Tx - Rx distance (meters)', FontSize=20)
ylabel('RSS', FontSize=20)
legend("Two-Ray & Omnidirectional", "Two-Ray & Dipole", FontSize=20);

figure(3)
plot(1:100, d(1:idx-1), 'x', 'LineWidth',2); hold on; grid on;
plot(1:100, tworayo_est_d(1:idx-1), 'o', 'LineWidth',2); 
xlabel('i th location index (i=1..100)', FontSize=20)
ylabel('Distance (meter)', FontSize=20)
legend("Real distance (meters)", "Estimated distance (meters)", FontSize=20);

figure(4)
plot(1:100, d(1:idx-1), 'x', 'LineWidth',2); hold on; grid on;
plot(1:100, tworayd_est_d(1:idx-1), 'o', 'LineWidth',2); 
xlabel('i th location index (i=1..100)', FontSize=20)
ylabel('Distance (meter)', FontSize=20)
legend("Real distance (meters)", "Estimated distance (meters)", FontSize=20);