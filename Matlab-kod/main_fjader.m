% Main fjader

%% Calc a and b
clear all
clc
table = importdata('Fjader1Vikt3.mat');
constants = calc_constant_fjader_ab(table,3)





%% Plotta F-v graf för fjadern
clear all
clc
table = importdata('Fjader1Vikt1.mat');
data = clear_zeros(str2double(table2array(table)));

v = calc_velocity_fjader(data);
constants = calc_constant_fjader_ab(table,1);
a = constants(1);
b = constants(2);

F = calc_force_fjader(data,a,b);
plot(v,F)




