clear all; %close all;
load('l_DR.mat')

Z_max = 50;

c = 299792458.0;                    % Speed of light in m/s
fc = 2400;                           % frequency (MHz)
Bc = 20e6;                          % Bandwidth (Hz)
P_Tx_dB = 33;                       % Transmission Power (dB)
G_t_dB = 0;                         % Antenna Gain (dBi)
N_0_dB = -174+10*log10(Bc) - 30;

matSize = 122;

de_1 = [];
de_2 = [];
de_3 = [];
de_4 = [];

tot_num_localization = 1;
while tot_num_localization <= 80
    if tot_num_localization > 60    % 4
        X_min = 0; X_max = 150;
        Y_min = 151; Y_max = 300;
        de1_bit = 0; de2_bit = 0; de3_bit = 0; de4_bit = 1;
    elseif tot_num_localization > 40    % 3
        X_min = 151; X_max = 300;
        Y_min = 151; Y_max = 300;
        de1_bit = 0; de2_bit = 0; de3_bit = 1; de4_bit = 0;
    elseif tot_num_localization > 20    % 2
        X_min = 151; X_max = 300;
        Y_min = 0; Y_max = 150;
        de1_bit = 0; de2_bit = 1; de3_bit = 0; de4_bit = 0;
    elseif tot_num_localization <= 20   % 1
        X_min = 0; X_max = 150;
        Y_min = 0; Y_max = 150;
        de1_bit = 1; de2_bit = 0; de3_bit = 0; de4_bit = 0;
    end

    index_end = 3;

    conv_hull = [];
    left_idx = 0;
    right_idx = 0;
    index_4 = 1;
    index_5 = 1;
    de = [];

    % Target Location
    l_xt = randi([X_min, X_max],1,1);
    l_yt = randi([Y_min, Y_max],1,1);
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
    r_sig_tot_pw_dB = 10*log10(abs(r_sig_tot).^2)*0.99 ;

    %% Distance Estimation
    dist_meas = 10.^((P_Tx_dB + G_t_dB - r_sig_tot_pw_dB + 27.55 - 20*log10(fc))/20) ; % estimate distance by inverse expressions
    meas_PL_dB = 20*log10(fc) + 20*log10(dist_meas) - 27.55;

    est_T = [];

    while index_end < matSize
        % collinear
        if l_DR(index_end,2) == 0
            index_1 = 1;
            index_3 = index_end;
            index_2 = round(index_3/2);
        elseif (l_DR(index_end,1) == 300) && (l_DR(index_end-1,1) == 300)
            right_idx = right_idx + 1;
            index_1 = 1;
            index_2 = 12;
            index_3 = 13 + 22*(right_idx-1);
            index_5 = index_end;
        elseif (l_DR(index_end,1) == 0) && (l_DR(index_end-1,1) == 0)
            left_idx = left_idx + 1;
            index_1 = 1;
            index_2 = 12;
            index_4 = 24 + 22*(left_idx-1);
            index_5 = index_end;
        else
            index_5 = index_end;
        end
        conv_hull = [index_1 index_2 index_3 index_4 index_5];
        d(index_1) = dist_meas(index_1);
        d(index_2) = dist_meas(index_2);
        d(index_3) = dist_meas(index_3);
        d(index_4) = dist_meas(index_4);
        d(index_5) = dist_meas(index_5);

        d_m = [d(index_1), d(index_2), d(index_3), d(index_4), d(index_5)];
        d_m_s = sort(d_m);
        if d(index_1) == d_m_s(1)
            ref = index_1;
            bs1 = index_2;
            bs2 = index_3;
            bs3 = index_4;
            bs4 = index_5;
        elseif d(index_2) == d_m_s(1)
            ref = index_2;
            bs1 = index_1;
            bs2 = index_3;
            bs3 = index_4;
            bs4 = index_5;
        elseif d(index_3) == d_m_s(1)
            ref = index_3;
            bs1 = index_2;
            bs2 = index_1;
            bs3 = index_4;
            bs4 = index_5;
        elseif d(index_4) == d_m_s(1)
            ref = index_4;
            bs1 = index_2;
            bs2 = index_3;
            bs3 = index_1;
            bs4 = index_5;
        elseif d(index_5) == d_m_s(1)
            ref = index_4;
            bs1 = index_2;
            bs2 = index_3;
            bs3 = index_4;
            bs4 = index_1;
        end

        A = [2*(l_DR(ref,1) - l_DR(bs1,1)) 2*(l_DR(ref,2) - l_DR(bs1,2)) 2*(l_DR(ref,3) - l_DR(bs1,3));
            2*(l_DR(ref,1) - l_DR(bs2,1)) 2*(l_DR(ref,2) - l_DR(bs2,2)) 2*(l_DR(ref,3) - l_DR(bs2,3));
            2*(l_DR(ref,1) - l_DR(bs3,1)) 2*(l_DR(ref,2) - l_DR(bs3,2)) 2*(l_DR(ref,3) - l_DR(bs3,3));
            2*(l_DR(ref,1) - l_DR(bs4,1)) 2*(l_DR(ref,2) - l_DR(bs4,2)) 2*(l_DR(ref,3) - l_DR(bs4,3));];
        B = [l_DR(ref,1)^2 - l_DR(bs1,1)^2 + l_DR(ref,2)^2 - l_DR(bs1,2)^2 + l_DR(ref,3)^2 - l_DR(bs1,3)^2 - d(ref)^2 + d(bs1)^2;
            l_DR(ref,1)^2 - l_DR(bs2,1)^2 + l_DR(ref,2)^2 - l_DR(bs2,2)^2 + l_DR(ref,3)^2 - l_DR(bs2,3)^2 - d(ref)^2 + d(bs2)^2;
            l_DR(ref,1)^2 - l_DR(bs3,1)^2 + l_DR(ref,2)^2 - l_DR(bs3,2)^2 + l_DR(ref,3)^2 - l_DR(bs3,3)^2 - d(ref)^2 + d(bs3)^2;
            l_DR(ref,1)^2 - l_DR(bs4,1)^2 + l_DR(ref,2)^2 - l_DR(bs4,2)^2 + l_DR(ref,3)^2 - l_DR(bs4,3)^2 - d(ref)^2 + d(bs4)^2;];
        [X,flag,relres] = lsqr(A,B);
        est_T = [est_T; X(1) X(2) X(3) relres];
        err_dist = sqrt(sum(est_T(size(est_T,1),1:3) - l_TG).^2);

        de = [de; err_dist];        % for mean value of error distance
        index_end = index_end + 1;

        if index_end == 122
            if de1_bit == 1
                de_1 = horzcat(de_1, de);
            elseif de2_bit == 1
                de_2 = horzcat(de_2, de);
            elseif de3_bit == 1
                de_3 = horzcat(de_3, de);
            elseif de4_bit == 1
                de_4 = horzcat(de_4, de);
            end
        end
    end
    tot_num_localization = tot_num_localization + 1;
end

de_all = de_1 + de_2 + de_3 + de_4;
de_avg = sum(de_all,2)/80;

figure
plot(1:119, de_avg(:,1), 'r:^'); grid on;