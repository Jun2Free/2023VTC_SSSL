%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The first, the mid, and the last. Anchor keeps changing.
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
G_t_dB = 2;                         % Antenna Gain (dBi)
N_0_dB = -174+10*log10(Bc) - 30;

matSize = 122;

de = []; 

tot_num_localization = 1;
while tot_num_localization <= 1
    index_end = 3;

    % Target Location
    %l_xt = randi([0, X_max],1,1);
    %l_yt = randi([0, Y_max],1,1);
    l_xt = 150;
    l_yt = 150;
    l_zt = 0;
    l_TG = [l_xt l_yt l_zt]

    %% Measured Recevied Signal
    dist = sqrt(sum(abs([l_DR(:,1) l_DR(:,2) l_DR(:,3)] - l_TG).^2,2)) ;       % estimated distance
    PL_dB = 20*log10(fc) + 20*log10(dist) - 27.55;
    r_sig_dB = G_t_dB + P_Tx_dB - PL_dB; % received signal power in dB
    r_sig_lin = sqrt(10.^(r_sig_dB/10)) ;

    % measured value
    N_0 = sqrt(10^(N_0_dB/10)*randn(1,1))';
    r_sig_tot = r_sig_lin + N_0;
    r_sig_tot_pw_dB = 10*log10(abs(r_sig_tot).^2)*0.99;
   %% Distance Estimation
    dist_meas = 10.^((P_Tx_dB + G_t_dB - r_sig_tot_pw_dB + 27.55 - 20*log10(fc))/20) ; % estimate distance by inverse expressions
    meas_PL_dB = 20*log10(fc) + 20*log10(dist_meas) - 27.55;

    est_T = [];

    while index_end < matSize
        d_m = dist_meas(1:index_end,:);
        [~,idx] = sort(d_m);  % closest three points
        index_1 = idx(1);
        index_2 = idx(2);
        index_3 = idx(3);

        ref = index_1;
        bs_1 = index_2;
        bs_2 =index_3;
        d(1) = dist_meas(ref);
        d(2) = dist_meas(index_2);
        d(3) = dist_meas(index_3);

        A = [2*(l_DR(ref,1) - l_DR(bs_1,1)) 2*(l_DR(ref,2) - l_DR(bs_1,2)) 2*(l_DR(ref,3) - l_DR(bs_1,3));
            2*(l_DR(ref,1) - l_DR(bs_2,1)) 2*(l_DR(ref,2) - l_DR(bs_2,2)) 2*(l_DR(ref,3) - l_DR(bs_2,3))];
        B = [l_DR(ref,1)^2 - l_DR(bs_1,1)^2 + l_DR(ref,2)^2 - l_DR(bs_1,2)^2 + l_DR(ref,3)^2 - l_DR(bs_1,3)^2 - d(1)^2 + d(2)^2;
            l_DR(ref,1)^2 - l_DR(bs_2,1)^2 + l_DR(ref,2)^2 - l_DR(bs_2,2)^2 + l_DR(ref,3)^2 - l_DR(bs_2,3)^2 - d(1)^2 + d(3)^2];

        [X,flag,relres] = lsqr(A,B)
        est_T = [est_T; X(1) X(2) X(3) relres];
        err_dist = sqrt(sum(est_T(size(est_T,1),1:3) - l_TG).^2);

        index_end = index_end + 1;
        de = [de; index_end, err_dist];        % for mean value of error distance
    end
    tot_num_localization = tot_num_localization + 1;
end


plot3(est_T(:,1), est_T(:,2), est_T(:,3), 'b:o'); hold on;
plot3(l_TG(1), l_TG(2), l_TG(3), 'r*');


figure
plot(de(:,1), de(:,2), 'b-o'); grid on;