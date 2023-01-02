%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The first, the mid, and the last. Anchor keeps changing.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
load('l_DR.mat')

Z_max = 50;

c = 299792458.0;                    % Speed of light in m/s
fc = 2400;                           % frequency (MHz)
Bc = 20e6;                          % Bandwidth (Hz)
P_Tx_dB = 33;                       % Transmission Power (dB)
G_t_dB = 2;                         % Antenna Gain (dBi)
N_0_dB = -174+10*log10(Bc) - 30;

matSize = 122;

de_sum = [];

tot_num_localization = 1;
while tot_num_localization <= 121

    index_end = 3;
    de = [];

    % Target Location
    l_xt = l_DR(tot_num_localization,1);
    l_yt = l_DR(tot_num_localization,2);
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

        de = [de; err_dist];        % for mean value of error distance
        index_end = index_end + 1;

        if index_end == 122
            de_sum = horzcat(de_sum, de);
        end
    end
    tot_num_localization = tot_num_localization + 1;
end

%%
de_avg = sum(de_sum,2)/121;

figure
plot(1:119, de_avg(:,1), 'r:^'); grid on;