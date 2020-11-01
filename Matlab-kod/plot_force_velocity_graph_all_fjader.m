% Plot F-v graph fjader all
clear all
clc

format shortEng;

table1 = importdata('Fjader1Vikt1_240s.mat');
table2 = importdata('Fjader1Vikt2_240s.mat');
table3 = importdata('Fjader1Vikt3_240s.mat');

data1 = clear_zeros(str2double(table2array(table1)));
data2 = clear_zeros(str2double(table2array(table2)));
data3 = clear_zeros(str2double(table2array(table3)));


v1 = calc_velocity_fjader(data1);
v2 = calc_velocity_fjader(data2);
v3 = calc_velocity_fjader(data3);

constants1 = abs(calc_constant_fjader_ab_mod(table1,1));
constants2 = abs(calc_constant_fjader_ab_mod(table2,2));
constants3 = abs(calc_constant_fjader_ab_mod(table3,3));

a1 = constants1(1);
b1 = constants1(2);

a2 = constants2(1);
b2 = constants2(2);

a3 = constants3(1);
b3 = constants3(2);

F1 = calc_force_fjader(data1,a1,b1);
F2 = calc_force_fjader(data2,a2,b2);
F3 = calc_force_fjader(data3,a3,b3);
scal = 10;
v3F3(:,1) = v3';
v3F3(:,2) = F3';
vF = sortrows(v3F3,2);
hold on
plot(v1*scal,F1,'r');
plot(v2*scal,F2, 'color',[0, 0.5, 0]);
plot(vF(1:23800,1)*scal,vF(1:23800,2),'b');

legend('m = 0,529 kg','m = 0,740 kg','m = 1,019 kg')
set(gca,'FontSize',16)
xlabel('v [m/s]')
ylabel('F_d(v) [N]')








