%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The first(Anchor), Every point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
load('l_DR.mat')

X_max = 300;                        % maximum x-domain offset from the origin [m]
Y_max = 300;                        % maximum y-domain offset from the origin [m]
Z_max = 50;

c = 299792458.0;                    % Speed of light in m/s
fc = 2400;                           % frequency (MHz)
Bc = 20e6;                          % Bandwidth (Hz)
P_Tx_dB = 33;                       % Transmission Power (dB)
G_t_dB = 0;                         % Antenna Gain (dBi)
N_0_dB = -174+10*log10(Bc) - 30;

de = [];
matSize = 122;

tot_num_localization = 1;
while tot_num_localization <= 1

    % Target Location
    l_xt = 200;
    l_yt = 200;
    l_zt = 0;
    l_TG = [l_xt l_yt l_zt]

    %% Measured Recevied Signal
    dist = sqrt(sum(abs([l_DR(:,1) l_DR(:,2) l_DR(:,3)] - l_TG).^2,2)) ;       % estimated distance
    PL_dB = 20*log10(fc) + 20*log10(dist) - 27.55;
    r_sig_dB = G_t_dB + P_Tx_dB - PL_dB; % received signal power in dB
    r_sig_lin = sqrt(10.^(r_sig_dB/10)) ;

    % measured value
    N_0 = sqrt(10^(N_0_dB/10)*randn(1,1))';
    r_sig_tot = r_sig_lin + N_0 ;
    r_sig_tot_pw_dB = 10*log10(abs(r_sig_tot).^2)*0.995 ;

    %% Distance Estimation
    dist_meas = 10.^((P_Tx_dB + G_t_dB - r_sig_tot_pw_dB + 27.55 - 20*log10(fc))/20) ; % estimate distance by inverse expressions
    meas_PL_dB = 20*log10(fc) + 20*log10(dist_meas) - 27.55;

    est_T = [];

    index = 3;
    d(1) = dist_meas(1);
    d(2) = dist_meas(2);

    A = [2*(l_DR(1,1) - l_DR(2,1)) 2*(l_DR(1,2) - l_DR(2,2)) 2*(l_DR(1,3) - l_DR(2,3))];
    B = [l_DR(1,1)^2 - l_DR(2,1)^2 + l_DR(1,2)^2 - l_DR(2,2)^2 + l_DR(1,3)^2 - l_DR(2,3)^2 - d(1)^2 + d(2)^2];

    while index < matSize
        d(index) = dist_meas(index);
        A = [A; 2*(l_DR(1,1) - l_DR(index,1)) 2*(l_DR(1,2) - l_DR(index,2)) 2*(l_DR(1,3) - l_DR(index,3))];
        B = [B; l_DR(1,1)^2 - l_DR(index,1)^2 + l_DR(1,2)^2 - l_DR(index,2)^2 + l_DR(1,3)^2 - l_DR(index,3)^2 - d(1)^2 + d(index)^2];
        [X,flag,relres] = lsqr(A,B)
        est_T = [est_T; X(1) X(2) X(3) relres];
        err_dist = sqrt(sum(est_T(size(est_T,1),1:3) - l_TG).^2);

        de = [de; index, err_dist];        % for mean value of error distance

        index = index + 1;
    end
    tot_num_localization = tot_num_localization + 1;
end

figure
plot(de(:,1), de(:,2), 'b:v'); grid on;