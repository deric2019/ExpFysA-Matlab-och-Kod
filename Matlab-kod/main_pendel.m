% Main pendel

%% Calc a and b
clear all
clc
table = importdata('PendelSondagKula3.mat');
constants = calc_constant_pendel_ab(table,2)

%% Plotta F-v graf för pendeln
clear all
clc
table = importdata('PendelSondagKula2Vers2.mat');
data = clear_zeros(str2double(table2array(table)));

v = calc_velocity_pendel(data);
constants = calc_constant_pendel_ab(table,1);
a = constants(1);
b = constants(2);

F = calc_force_pendel(data,a,b);

plot(10*v,10*F)