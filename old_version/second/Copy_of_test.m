clear all; close all;%
c = 299792458.0;                    % Speed of light in m/s
fc = 2.4e+09;                    % frequency (MHz)
lambda = c/fc;

% In two-ray propagation model
Tx = [0 0];       % Tx location
Rx = zeros(100,2);
Rx(:,1) = 1:1:100;
tss = 30;     % Transmit signal strength (dBm)
ht = 10;      % transmitter height
hr = 50;
d = [];
% PLE range
beta1 = 1;
beta2 = 6;
sigma = sqrt((beta2-beta1).^2 / 12);

% rss
rss_omni = [];
rss_dipole = [];
rss_fspl = [];
% est_d
fspl_est_d = [];
tworayo_est_d = [];
tworayd_est_d = [];
%
y_omni = [];

idx = 1;
while idx < size(Rx,1) + 1
    %% Variable define
    d(idx) = sqrt((Tx(1) - Rx(idx,1)).^2 + (Tx(2) - Rx(idx,2)).^2);  % horizontal distance btw rx and tx
    los_d = sqrt((ht-hr).^2 + d(idx).^2);                            % line of sight distance
    ref_d = sqrt((ht+hr).^2 + d(idx).^2);                            % reflected distance
    los_ang = atan((ht-hr) ./d(idx));                                % line of sight angle
    ref_ang = atan((ht+hr) ./d(idx));                                % reflected angle
    Gt_o = 2; % omni
    Gt_d = (cos(pi .*(lambda./2) .*fc ./c .*sin(los_ang)) - cos(pi .*(lambda./2) .*fc ./c)) ./cos(los_ang); % dipole
    Gr_o = Gt_o;
    Gr_d = Gt_d;
    G_o = Gt_o .* Gr_o;       % Combined Antenna gain (dBm)
    G_d = Gt_d .* Gr_d;       % Combined Antenna gain (dBm)
    ep = 15;
    sig = 0.005;
    ep0 = ep - 1i.*60.*sig.*lambda;
    gama = (ep0.*sin(ref_ang) - sqrt(ep0 - cos(ref_ang).^2)) ./ (ep0.*sin(ref_ang) + sqrt(ep0 - cos(ref_ang).^2));
    diff = ref_d - los_d;
    phi = 2 .*pi .*diff ./lambda;
    
    %% Received Signal
    r = normrnd(0, sigma);
    two_ss_o = 10*log10(r) + tss + 20.*log10(lambda./(4.*pi)) + 20.*log(abs(((sqrt(G_o) ./los_d) + (gama .*sqrt(G_o) .*exp(-1i.*phi)./ref_d))));  % omni
    two_ss_d = 10*log10(r) + tss + 20.*log10(lambda./(4.*pi)) + 20.*log(abs(((sqrt(G_d) ./los_d) + (gama .*sqrt(G_d) .*exp(-1i.*phi)./ref_d))));  % dipole
    fspl_ss_o = tss + G_o + 20.*log10(lambda./(4.*pi.*d(idx)));       % free space path loss model signal strength
    rss_fspl(idx) = fspl_ss_o;
    rss_omni(idx) = two_ss_o;
    rss_dipole(idx) = two_ss_d;

    y_omni(idx) = rss_omni(idx) - rss_omni(1);


    %% Distance estimation (two-ray omnidirectional model)
    % two ray propagation model (approximation): pl = tx - tx = 40.*log10(d) - 10.*log10(G.*(ht.^2).*(hr.^2))
    v(idx) = (-(beta1-beta2).*y_omni(idx) + sqrt((beta1-beta2).^2 .*y_omni(idx).^2 - (beta1.^2-beta2.^2).*(2.*sigma.^2.*log(beta2./beta1))))./(beta1.^2-beta2.^2);
    tworayo_est_d(idx) = exp(v(idx));

    idx = idx + 1;
end

figure(3)
plot(1:100, d(1:idx-1), 'x', 'LineWidth',2); hold on; grid on;
plot(1:100, tworayo_est_d(1:idx-1), 'o', 'LineWidth',2); 
xlabel('i th location index (i=1..100)', FontSize=20)
ylabel('Distance (meter)', FontSize=20)
legend("Real distance (meters)", "Estimated distance (meters)", FontSize=20);


