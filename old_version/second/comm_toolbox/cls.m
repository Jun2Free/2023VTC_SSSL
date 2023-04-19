clear all; close all;
%%
fc = 1.9000e+09;
c = 299792458.0;

%% Transmitter Setup
% Transmitter location
% Antenna pattern: isotopic
% transmit power: 33 dB (63 dBm)
tx = txsite("Name","Transmitter", "Latitude",35.727152,"Longitude",-78.700470, ...
    "AntennaHeight",20,"Antenna",'isotropic','TransmitterPower',63)

%% Receiver Setup
% Reciever location
rx_ref = rxsite("Latitude",35.727162, "Longitude",-78.700470, "AntennaHeight",20);
rx1 = rxsite("Latitude",35.727713, "Longitude",-78.696729, "AntennaHeight",50);
rx2 = rxsite("Latitude",35.727608, "Longitude",-78.698499, "AntennaHeight",50);
rx3 = rxsite("Latitude",35.727573, "Longitude",-78.700226, "AntennaHeight",50);
rx4 = rxsite("Latitude",35.728278, "Longitude",-78.700462, "AntennaHeight",50);
rx5 = rxsite("Latitude",35.728374, "Longitude",-78.698499, "AntennaHeight",50);
rx6 = rxsite("Latitude",35.728548, "Longitude",-78.696900, "AntennaHeight",50);
rx7 = rxsite("Latitude",35.729410, "Longitude",-78.697061, "AntennaHeight",50);
rx8 = rxsite("Latitude",35.729469, "Longitude",-78.698637, "AntennaHeight",50);
rx9 = rxsite("Latitude",35.729573, "Longitude",-78.700141, "AntennaHeight",50);
rx10 = rxsite("Latitude",35.730444, "Longitude",-78.699733, "AntennaHeight",50);
rx11 = rxsite("Latitude",35.730400, "Longitude",-78.698467, "AntennaHeight",50);
rx12 = rxsite("Latitude",35.730396, "Longitude",-78.696986, "AntennaHeight",50);

%% Propagation Model Setup: Raytracing
% Propagation Model: raytracing 
pm = propagationModel("raytracing");
recSS_ref = sigstrength(rx_ref,tx,pm); % Received Signal Strength at the reference point

recSS = [];  % received signal strength at each waypoint
recSS(1) = sigstrength(rx1, tx, pm);
recSS(2) = sigstrength(rx2, tx, pm);
recSS(3) = sigstrength(rx3, tx, pm);
recSS(4) = sigstrength(rx4, tx, pm);
recSS(5) = sigstrength(rx5, tx, pm);
recSS(6) = sigstrength(rx6, tx, pm);
recSS(7) = sigstrength(rx7, tx, pm);
recSS(8) = sigstrength(rx8, tx, pm);
recSS(9) = sigstrength(rx9, tx, pm);
recSS(10) = sigstrength(rx10, tx, pm);
recSS(11) = sigstrength(rx11, tx, pm);
recSS(12) = sigstrength(rx12, tx, pm);

%% Path loss
lambda = physconst('LightSpeed')/fc;
d0 = distance(tx,rx_ref);  % distance to reference point
d = [];
d(1) = distance(tx,rx1);
d(2) = distance(tx,rx2);
d(3) = distance(tx,rx3);
d(4) = distance(tx,rx4);
d(5) = distance(tx,rx5);
d(6) = distance(tx,rx6);
d(7) = distance(tx,rx7);
d(8) = distance(tx,rx8);
d(9) = distance(tx,rx9);
d(10) = distance(tx,rx10);
d(11) = distance(tx,rx11);
d(12) = distance(tx,rx12);

%pl = pathloss(pm, rx1, tx)


%% Distance Estimation
est_d = [];
est_d(1) = d0 .* 10.^((recSS_ref-recSS(1))./20);
est_d(2) = d0 .* 10.^((recSS_ref-recSS(2))./20);
est_d(3) = d0 .* 10.^((recSS_ref-recSS(3))./20);
est_d(4) = d0 .* 10.^((recSS_ref-recSS(4))./20);
est_d(5) = d0 .* 10.^((recSS_ref-recSS(5))./20);
est_d(6) = d0 .* 10.^((recSS_ref-recSS(6))./20);
est_d(7) = d0 .* 10.^((recSS_ref-recSS(7))./20);
est_d(8) = d0 .* 10.^((recSS_ref-recSS(8))./20);
est_d(9) = d0 .* 10.^((recSS_ref-recSS(9))./20);
est_d(10) = d0 .* 10.^((recSS_ref-recSS(10))./20);
est_d(11) = d0 .* 10.^((recSS_ref-recSS(11))./20);
est_d(12) = d0 .* 10.^((recSS_ref-recSS(12))./20);


%% Visualize
%{
raytrace(tx,rx1,pm) 
raytrace(tx,rx2,pm) 
raytrace(tx,rx3,pm) 
raytrace(tx,rx4,pm) 
raytrace(tx,rx5,pm) 
raytrace(tx,rx6,pm) 
raytrace(tx,rx7,pm) 
raytrace(tx,rx8,pm) 
raytrace(tx,rx9,pm) 
raytrace(tx,rx10,pm) 
raytrace(tx,rx11,pm)
raytrace(tx,rx12,pm) 

%% Plot
figure
plot(1:12, d(1:12), 'o'); grid on; hold on;
plot(1:12, est_d(1:12), 'x'); grid on; hold on;
xlabel('Waypoint', FontSize = 14);
ylabel('Distance (meters)', FontSize = 14);
legend('Real distance (meters)', 'Estimated distance (meters)', FontSize = 14);

%% Antenna pattern: isotopic
pattern(tx)
%}
%% Localization
l_DR_sph = [
    rx1.Latitude rx1.Longitude;
    rx2.Latitude rx2.Longitude;
    rx3.Latitude rx3.Longitude;
    rx4.Latitude rx4.Longitude;
    rx5.Latitude rx5.Longitude;
    rx6.Latitude rx6.Longitude;
    rx7.Latitude rx7.Longitude;
    rx8.Latitude rx8.Longitude;
    rx9.Latitude rx9.Longitude;
    rx10.Latitude rx10.Longitude;
    rx11.Latitude rx11.Longitude;
    rx12.Latitude rx12.Longitude;
    ];

l_DR = [];
l_DR(:,1) = 6371 .* cos(l_DR_sph(:,1)) .* cos(l_DR_sph(:,2));
l_DR(:,2) = 6371 .* cos(l_DR_sph(:,1)) .* sin(l_DR_sph(:,2));
l_DR(:,3) = 6371 .* sin(l_DR_sph(:,1));


l_TG = [];
l_TG(1) = 6371 .* cos(35.727152) .* cos(-78.700470);
l_TG(2) = 6371 .* cos(35.727152) .* sin(-78.700470);
l_TG(3) = 6371 .* sin(35.727152);

dataSet = [
    rx1.Latitude rx1.Longitude rx1.AntennaHeight recSS(1) est_d(1);
    rx2.Latitude rx2.Longitude rx2.AntennaHeight recSS(2) est_d(2);
    rx3.Latitude rx3.Longitude rx3.AntennaHeight recSS(3) est_d(3);
    rx4.Latitude rx4.Longitude rx4.AntennaHeight recSS(4) est_d(4);
    rx5.Latitude rx5.Longitude rx5.AntennaHeight recSS(5) est_d(5);
    rx6.Latitude rx6.Longitude rx6.AntennaHeight recSS(6) est_d(6);
    rx7.Latitude rx7.Longitude rx7.AntennaHeight recSS(7) est_d(7);
    rx8.Latitude rx8.Longitude rx8.AntennaHeight recSS(8) est_d(8);
    rx9.Latitude rx9.Longitude rx9.AntennaHeight recSS(9) est_d(9);
    rx10.Latitude rx10.Longitude rx10.AntennaHeight recSS(10) est_d(10);
    rx11.Latitude rx11.Longitude rx11.AntennaHeight recSS(11) est_d(11);
    rx12.Latitude rx12.Longitude rx12.AntennaHeight recSS(12) est_d(12);
    ];

index_end = 3;    
resid = 1;
est_T = [];

%% Localization
while index_end < 12
    d_m = est_d(1:index_end);
    [~,idx] = sort(d_m);
    index_1 = idx(1);
    index_2 = idx(2);
    index_3 = idx(3);

    d(index_1) = est_d(index_1);
    d(index_2) = est_d(index_2);
    d(index_3) = est_d(index_3);

    ref = index_1;
    bs1 = index_2;
    bs2 = index_3;

    A = [2*(l_DR(ref,1) - l_DR(bs1,1)) 2*(l_DR(ref,2) - l_DR(bs1,2)) 2*(l_DR(ref,3) - l_DR(bs1,3));
        2*(l_DR(ref,1) - l_DR(bs2,1)) 2*(l_DR(ref,2) - l_DR(bs2,2)) 2*(l_DR(ref,3) - l_DR(bs2,3))];
    B = [l_DR(ref,1)^2 - l_DR(bs1,1)^2 + l_DR(ref,2)^2 - l_DR(bs1,2)^2 + l_DR(ref,3)^2 - l_DR(bs1,3)^2 - d(ref)^2 + d(bs1)^2;
        l_DR(ref,1)^2 - l_DR(bs2,1)^2 + l_DR(ref,2)^2 - l_DR(bs2,2)^2 + l_DR(ref,3)^2 - l_DR(bs2,3)^2 - d(ref)^2 + d(bs2)^2];

    [X,flag,relres] = lsqr(A,B)

    if relres <= resid
        resid = relres;
        est_T = [est_T; X(1) X(2) X(3)];
    end

    index_end = index_end + 1;
end

%%
l_TG
est_T(size(est_T,1),:)

%%
plot(l_TG(1), l_TG(2), 'o'); hold on;
plot(l_DR(:,1), l_DR(:,2), 'x');
plot(est_T(size(est_T,1),1), est_T(size(est_T,1),2), 'square')
