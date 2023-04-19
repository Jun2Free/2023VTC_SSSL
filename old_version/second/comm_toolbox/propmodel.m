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

%%
pattern(tx)

%%
%coverage(tx)