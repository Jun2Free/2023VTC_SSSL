clear all; close all;
%%
fc = 1.9000e+09;
c = 299792458.0;
%d = isoperic

%% Transmitter Setup
% Transmitter location
% Antenna pattern: isotopic
% transmit power: 33 dB (63 dBm)
tx = txsite("Name","Transmitter", "Latitude",35.727152,"Longitude",-78.700470, ...
    "AntennaHeight",20,"Antenna",'isotropic','TransmitterPower',63)
tx.CoordinateSystem = 'cartesian'
%% Receiver Setup
% Reciever location

rx1 = rxsite("Latitude",35.727713, "Longitude",-78.696729, "AntennaHeight",50,"Antenna",d);


%% Propagation Model Setup: Raytracing
% Propagation Model: raytracing 
pm = propagationModel("raytracing");
recSS = [];  % received signal strength at each waypoint
recSS(1) = sigstrength(rx1, tx, pm);


%% Path loss
lambda = physconst('LightSpeed')/fc;
d0 = distance(tx,rx_ref);  % distance to reference point
d = [];
d(1) = distance(tx,rx1);


%pl = pathloss(pm, rx1, tx)


%% Distance Estimation
est_d = [];
est_d(1) = d0 .* 10.^((recSS_ref-recSS(1))./20);


%% Visualize

raytrace(tx,rx1,pm) 

%% Antenna pattern: isotopic
pattern(tx)