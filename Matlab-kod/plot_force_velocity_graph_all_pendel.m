%% Plotta F-v graf för pendeln all
clear all
clc
format shortEng

scale = 10;
a=1e6;
b=1e-4;
table1 = importdata('Pendel180sKula2.mat');
table2 = importdata('Pendel180sKula3.mat');
table3 = importdata('Pendel180sKula4.mat');

data1 = clear_zeros(str2double(table2array(table1)));
data2 = clear_zeros(str2double(table2array(table2)));
data3 = clear_zeros(str2double(table2array(table3)));

v1 = calc_velocity_pendel(data1);
v2 = calc_velocity_pendel(data2);
v3 = calc_velocity_pendel(data3);

constants1 = calc_constant_pendel_ab(table1,1);
constants2 = calc_constant_pendel_ab(table2,2);
constants3 = calc_constant_pendel_ab(table3,3);

a1 = constants1(1)*a;
b1 = constants1(2)*b;

a2 = constants2(1)*a;
b2 = constants2(2)*b;

a3 = constants3(1)*a;
b3 = constants3(2)*b;


F1 = calc_force_pendel(data1,a1/a,b1/b);
F2 = calc_force_pendel(data2,a2/a,b2/b);
F3 = calc_force_pendel(data3,a3/a,b3/b);

v3F3(:,1) = v3';
v3F3(:,2) = F3';
vF = sortrows(v3F3,2);

hold on 
plot(scale*v1,scale*F1,'r');
plot(scale*v2,scale*F2,'color',[0, 0.5, 0]);
plot(scale*v3(1:1000),scale*F3(1:1000),'b');


legend('m = 0,012 kg' ,'m = 0,068 kg' , 'm = 0,125 kg ');
set(gca,'FontSize',16)
xlabel('v [m/s]')
ylabel('F_d(v) [N]')








