clear all; close all;
%% Parameter Setup
X_max = 100;                        % maximum x-domain offset from the origin [m]
Y_max = 100;                        % maximum y-domain offset from the origin [m]
Z_max = 50;

c = 299792458.0;                    % Speed of light in m/s
fc = 2400;                           % frequency (MHz)
Bc = 20e6;                          % Bandwidth (Hz)
P_Tx_dB = 33;                       % Transmission Power (dB)
G_t_dB = 3;                         % Antenna Gain (dBi)
N_0_dB = -174+10*log10(Bc) - 30;    % Thermal noise (dB): -174(dBm) + 10log10(bandwidth) -30

de = [0];                 % distance error  vector

tot_num_localization = 1;
while tot_num_localization <= 100

    resid = 1;

    est_T = [0 0 0];             % estimated locatioin vector

    % Target Location
    l_xt = randi([0, X_max],1,1);
    l_yt = randi([0, Y_max],1,1);
    l_zt = 2;
    l_TG = [l_xt l_yt l_zt];

    % Drone Location
    l_x = X_max / 2;
    l_y = Y_max / 2;
    l_z = 5;
    l_DR = [l_x l_y l_z];

    dr_move = 1;

    while dr_move < 441         % for boundary trajectory
        rt_cnt = 1;     % movement count in a loop
        if size(l_DR,1) == 1        % for the first loop, get two locations of drone
            while rt_cnt < 4
                if (dr_move >= 421) && (dr_move < 441)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 401) && (dr_move < 421) %20
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 381) && (dr_move < 401)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 362) && (dr_move < 381) %19
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 343) && (dr_move < 362)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 325) && (dr_move < 343) %18
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 307) && (dr_move < 325)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 290) && (dr_move < 307) %17
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 273) && (dr_move < 290)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 257) && (dr_move < 273) %16
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 241) && (dr_move < 257)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 226) && (dr_move < 241) %15
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 211) && (dr_move < 226)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 197) && (dr_move < 211) %14
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 183) && (dr_move < 197)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 170) && (dr_move < 183) %13
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 157) && (dr_move < 170)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 145) && (dr_move < 157) %12
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 133) && (dr_move < 145)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 122) && (dr_move < 133) %11
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 111) && (dr_move < 122)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 101) && (dr_move < 111) %10
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 91) && (dr_move < 101)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 82) && (dr_move < 91) %9
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 73) && (dr_move < 82)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 65) && (dr_move < 73) %8
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 57) && (dr_move < 65)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 50) && (dr_move < 57) %7
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 43) && (dr_move < 50)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 37) && (dr_move < 43) %6
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 31) && (dr_move < 37)
                    l_x = l_x + 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 26) && (dr_move < 31)
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 21) && (dr_move < 26)
                    l_x = l_x + 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 17) && (dr_move < 21)
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 13) && (dr_move < 17)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 10) && (dr_move < 13)
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 7) && (dr_move < 10)
                    l_x = l_x + 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 5) && (dr_move < 7)
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 3) && (dr_move < 5)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 2) && (dr_move < 3)
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move > 0) && (dr_move < 2)
                    l_x = l_x + 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                end

                rt_cnt = rt_cnt+1;
                dr_move = dr_move+1;
            end
        end
        if size(l_DR,1) >= 3 % from the second loop, get two locations of drone for each loop
            rt_cnt = 1;
            while rt_cnt <= 4
                if (dr_move >= 421) && (dr_move < 441)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 401) && (dr_move < 421) %20
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 381) && (dr_move < 401)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 362) && (dr_move < 381) %19
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 343) && (dr_move < 362)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 325) && (dr_move < 343) %18
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 307) && (dr_move < 325)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 290) && (dr_move < 307) %17
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 273) && (dr_move < 290)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 257) && (dr_move < 273) %16
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 241) && (dr_move < 257)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 226) && (dr_move < 241) %15
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 211) && (dr_move < 226)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 197) && (dr_move < 211) %14
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 183) && (dr_move < 197)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 170) && (dr_move < 183) %13
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 157) && (dr_move < 170)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 145) && (dr_move < 157) %12
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 133) && (dr_move < 145)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 122) && (dr_move < 133) %11
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 111) && (dr_move < 122)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 101) && (dr_move < 111) %10
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 91) && (dr_move < 101)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 82) && (dr_move < 91) %9
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 73) && (dr_move < 82)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 65) && (dr_move < 73) %8
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 57) && (dr_move < 65)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 50) && (dr_move < 57) %7
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 43) && (dr_move < 50)
                    l_x = l_x - 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 37) && (dr_move < 43) %6
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 31) && (dr_move < 37)
                    l_x = l_x + 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 26) && (dr_move < 31)
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 21) && (dr_move < 26)
                    l_x = l_x + 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 17) && (dr_move < 21)
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 13) && (dr_move < 17)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 10) && (dr_move < 13)
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 7) && (dr_move < 10)
                    l_x = l_x + 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 5) && (dr_move < 7)
                    l_x = l_x - 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 3) && (dr_move < 5)
                    l_x = l_x - 0;
                    l_y = l_y - 5;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move >= 2) && (dr_move < 3)
                    l_x = l_x + 5;
                    l_y = l_y + 0;
                    l_DR = [l_DR; l_x l_y l_z];
                elseif (dr_move > 0) && (dr_move < 2)
                    l_x = l_x + 0;
                    l_y = l_y + 5;
                    l_DR = [l_DR; l_x l_y l_z];
                end

                rt_cnt = rt_cnt+1;
                dr_move = dr_move+1;
            end
        end

        %% Recevied Signal
        dist = sqrt(sum(abs(l_DR - l_TG).^2,2)) ;
        PL_dB = 20*log10(fc) + 20*log10(dist) - 27.55 ; % free-space (measured)path loss
        r_sig_pw_dB = G_t_dB + P_Tx_dB - PL_dB ; % received signal power in dB
        r_sig_lin = sqrt(10.^(r_sig_pw_dB/10)) ; % received signal in linear
        N_0 = sqrt(10^(N_0_dB/10))*randn(size(r_sig_lin,1),1) ; % white Gaussian noise
        r_sig_tot = r_sig_lin + N_0 ; % receivd signal including noise
        r_sig_tot_dB = 10*log10(r_sig_tot);
        r_sig_tot_pw_dB = 10*log10(abs(r_sig_tot).^2)*0.9 ; % received signal power in dB

        %% Distance Estimation
        dist_meas = 10.^(-( r_sig_tot_pw_dB - G_t_dB - P_Tx_dB - 27.55 + 20*log10(fc) )/20) ; % estimate distance
        meas_PL_dB = 20*log10(fc) + 20*log10(dist_meas) - 27.55;dist_est = 10.^(-( r_sig_tot_pw_dB - G_t_dB - P_Tx_dB - 27.55 + 20*log10(fc) )/20) ; % estimate distance

        %% Localization; RSSI based

        % Algorithm 01: Linear Least Square
        % (algorithm by: Hyeon Jeong Jo and Seungku Kim, Indoor Smartphone Localization Based on LOS and NLOS Identificatio, Sensors, Nov. 2018.)
        [~,idx_DR] = sort(dist_est); % sort disance shorstest to longest
        idx_DR = idx_DR(1:4) ; % Only choose the closest 3 BS

        d_1 = dist_meas(idx_DR(1)) ; % distance
        d_2 = dist_meas(idx_DR(2)) ;
        d_3 = dist_meas(idx_DR(3)) ;
        d_4 = dist_meas(idx_DR(4)) ;

        x_1 = l_DR(idx_DR(1),1) ; % x-domain location
        x_2 = l_DR(idx_DR(2),1) ;
        x_3 = l_DR(idx_DR(3),1) ;
        x_4 = l_DR(idx_DR(4),1) ;

        y_1 = l_DR(idx_DR(1),2) ; % y-domain location
        y_2 = l_DR(idx_DR(2),2) ;
        y_3 = l_DR(idx_DR(3),2) ;
        y_4 = l_DR(idx_DR(4),2) ;

        z_1 = l_DR(idx_DR(1),3) ; % z-domain location
        z_2 = l_DR(idx_DR(2),3) ;
        z_3 = l_DR(idx_DR(3),3) ;
        z_4 = l_DR(idx_DR(4),3) ;

        A = [2*(x_1 - x_2) 2*(y_1 - y_2) 2*(z_1 - z_2); 2*(x_1 - x_3) 2*(y_1 - y_3) 2*(z_1 - z_3); 2*(x_1 - x_4) 2*(y_1 - y_4) 2*(z_1 - z_4)];
        B = [x_1^2 - x_2^2 + y_1^2 - y_2^2 + z_1^2 - z_2^2 - d_1^2 + d_2^2 ; x_1^2 - x_3^2 + y_1^2 - y_3^2 + z_1^2 - z_3^2 - d_1^2 + d_3^2; ...
            x_1^2 - x_4^2 + y_1^2 - y_4^2 + z_1^2 - z_4^2 - d_1^2 + d_4^2];

        %X = pinv(A)*B;    % estimated location
        [X,flag,relres] = lsqr(A,B);
        if relres < resid
            resid = relres;
            est_T = [est_T; X(1) X(2) X(3)];
            err_dist = sqrt(sum(abs(X - l_TG').^2)); % distance error [m]
        end
    end
    de = [de; err_dist];        % for mean value of error distance
    tot_num_localization = tot_num_localization + 1;
end

%% Performance data
% Mean of Total distance of Drone
newline

% Mean of Error Distance
fprintf("Mean of Error distance(m)");
mean(de(2:size(de)))

%% Plot
% UAV Trajectory
figure(1);
xlabel('X Position', FontSize = 14);
ylabel('Y Position', FontSize = 14);
plot3(l_DR(:,1), l_DR(:,2), l_DR(:,3), 'k-'); hold on;  % Drone Trajectory
plot3(est_T(2:size(est_T),1), est_T(2:size(est_T),2), est_T(2:size(est_T),3), 'b:o'); hold on;   % Estimated Location of the target
plot3(l_TG(1), l_TG(2), l_TG(3), 'r*');   % Target Location

legend('UAV Trajectory', 'Estimated Target Location', 'Target Location', FontSize = 14);

