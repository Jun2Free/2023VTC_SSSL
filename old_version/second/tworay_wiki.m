clear all; close all;%
c = 299792458.0;                    % Speed of light in m/s
fc = 1.9000e+09;                           % frequency (MHz)
Bc = 20e6;                          % Bandwidth (Hz)
lambda = c/fc;

% In two-ray propagation model
Tx = [0 0 20];       % Tx location
Rx = [
    1 0 50;
    10 0 50;
    30 0 50;
    50 0 50;
    100 0 50;
    ]; 

tss = 63;     % Transmit signal strength (dBm)
ht = Tx(3);      % transmitter height
idx = 1;
rss = [];
rss_dB = [];

while idx < size(Rx,1) + 1
    hr = Rx(idx,3);      % receiver height
    d = sqrt((Tx(1) - Rx(idx,1)).^2 + (Tx(2) - Rx(idx,2)).^2);  % horizontal distance btw rx and tx
    los_d = sqrt((hr-ht).^2 + d.^2);  % 5
    ref_d = sqrt((ht+hr).^2 + d.^2);  % 6
    los_ang = atan((hr-ht) ./d);
    ref_ang = atan((ht+hr) ./d);
    Gt = 6;
    % Gt = (cos(pi .*(lambda./2) .*fc ./c) .*sin(los_ang) - cos(pi .*fc .*(lambda./2))) ./cos(los_ang); % dipole
    Gr = Gt;
    G = Gt * Gr;       % Combined Antenna gain (dBm) (dipole)
    ep = 15;
    sig = 0.005;
    ep0 = ep - 1i.*60.*sig.*lambda;
    gama = (sin(ref_ang) - sqrt(ep - cos(ref_ang).^2)) ./ (sin(ref_ang) + sqrt(ep - cos(ref_ang).^2));
    diff = ref_d - los_d;
    %tau = (ref_d-los_d) ./c;
    phi = 2 .*pi .*diff ./lambda;
    %los_ss = real(lambda .*sqrt(G) ./(4*pi) .*(tss .*exp(-sqrt(-1).*2.*pi.*los_dist./lambda)) ./los_dist)
    %ref_ss = real(lambda .* gama .*sqrt(G) ./(4*pi) .*(tss .*exp(-sqrt(-1).*2.*pi.*ref_dist./lambda)) ./ref_dist)
    %two_ss = tss .*(lambda./(4.*pi)).^2 .*abs(((sqrt(G) ./los_d) + (gama .*sqrt(G) .*exp(-1i.*phi./ref_d)))).^2
    two_ss = tss + 20.*log10(lambda./(4.*pi)) + 20.*log(abs(((sqrt(G) ./los_d) + (gama .*sqrt(G) .*exp(-1i.*phi./ref_d)))));
    rss(idx) = two_ss;
    idx = idx + 1;
end
rss
%{
plot(1, 63, 'o'); hold on;
plot(1, two_ss, 'x');
%}