%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nonlinear Least Square Algorithm for 3D dimension
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
X_max = 100;                        % maximum x-domain offset from the origin [m]
Y_max = 100;                        % maximum y-domain offset from the origin [m]
Z_max = 50;

c = 299792458.0;                    % Speed of light in m/s
fc = 2400;                           % frequency (MHz)
Bc = 20e6;                          % Bandwidth (Hz)
P_Tx_dB = 33;                       % Transmission Power (dB)
G_t_dB = 0;                         % Antenna Gain (dBi)
N_0_dB = -174+10*log10(Bc) - 30;

de = [0];                 % distance error  vector

% variables for fmincon
lb = [0,0,0];
ub = [100,100,3];
A = [];
b = [];
Aeq = [];
beq = [];

%
step = 5;

tot_num_localization = 1;
while tot_num_localization <= 100

    est_T = [0 0 0 1000];        % estimated locatioin vector
    minima = 1000;

    % Target Location
    l_xt = randi([0, X_max],1,1);
    l_yt = randi([0, Y_max],1,1);
    l_zt = 2;
    l_TG = [l_xt l_yt l_zt]
    l_x = 0;
    l_y = 0;
    l_z = 5;
    l_DR = [l_x, l_y, l_z]
    x_add_cnt = 0;
    x_sub_cnt = 0;
    x_add = 0;
    x_sub = 0;
    y_add = 0;

    dr_move = 1;

    while l_y <= Y_max
        if (x_add == 1)
            l_x = l_x + step;
            dr_move = dr_move + 1;
            x_add_cnt = x_add_cnt + 1;
            if (x_add_cnt == X_max/step)
                x_add = 0;
                x_add_cnt = 0;
                y_add = 1;
            end
        elseif (x_sub == 1)
            l_x = l_x - step;
            dr_move = dr_move + 1;
            x_sub_cnt = x_sub_cnt + 1;
            if (x_sub_cnt == X_max/step)
                x_sub = 0;
                x_sub_cnt = 0;
                y_add = 1;
            end
        elseif (y_add == 1)
            if (l_y == Y_max)
                break;
            end
            l_y = l_y + step;
            dr_move = dr_move + 1;
            y_add = 0;
        end

        if (l_x == 0 && y_add == 0)
            x_add = 1;
        elseif (l_x == X_max && y_add == 0)
            x_sub = 1;
        end

        l_DR = [l_DR; l_x, l_y, l_z];
        %% Measured Recevied Signal
        dist = sqrt(sum(abs([l_DR(:,1) l_DR(:,2) l_DR(:,3)] - l_TG).^2,2)) ;       % estimated distance
        PL_dB = 20*log10(fc) + 20*log10(dist) - 27.55;
        r_sig_dB = G_t_dB + P_Tx_dB - PL_dB; % received signal power in dB
        r_sig_lin = sqrt(10.^(r_sig_dB/10)) ;

        % measured value
        N_0 = sqrt(10^(N_0_dB/10)*randn(1,1))';
        r_sig_tot = r_sig_lin + N_0 ;
        r_sig_tot_pw_dB = 10*log10(abs(r_sig_tot).^2)*0.9 ;

        %% Distance Estimation
        dist_meas = 10.^((P_Tx_dB + G_t_dB - r_sig_tot_pw_dB + 27.55 - 20*log10(fc))/20) ; % estimate distance by inverse expressions
        meas_PL_dB = 20*log10(fc) + 20*log10(dist_meas) - 27.55;

        %% Localization; RSSI based
        x0 = [l_x+0.01; l_y+0.02; l_z+0.03];
        % nonlinear
        fun = @(x)sum((20*log10(dist_meas) - 20*log10(sqrt(sum(abs([l_DR(:,1) l_DR(:,2) l_DR(:,3)] - [x(1) x(2) x(3)]).^2,2)))).^2)
        %[x, fval] = fminunc(fun, x0)
        [x, fval] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub)
        est_T = [est_T; x(1) x(2) x(3) fval];
        err_dist = sqrt(sum(est_T(size(est_T,1),1:3) - l_TG).^2);
    end
    de = [de; err_dist];        % for mean value of error distance
    tot_num_localization = tot_num_localization + 1;
end
c = newline
fprintf("Mean of Error distance");
mean(de(2:size(de)))

%% Plot
xlabel('X Position');
ylabel('Y Position');
plot3(l_DR(:,1), l_DR(:,2), l_DR(:,3), 'k-'); hold on;  % Drone Trajectory
plot3(est_T(2:size(est_T),1), est_T(2:size(est_T),2), est_T(2:size(est_T),3), 'b:o'); hold on;   % Estimated Location of the target
plot3(l_TG(1), l_TG(2), l_TG(3), 'r*');   % Target Location
legend('UAV Trajectory', 'Estimated Target Location', 'Target Location');