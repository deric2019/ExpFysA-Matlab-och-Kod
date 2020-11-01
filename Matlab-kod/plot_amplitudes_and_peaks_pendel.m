%% Plot amplitude and peaks pendel
clc
clear all
clf
table = importdata('PendelSondagKula2.mat');
data = clear_zeros(str2double(table2array(table)));
p = 4;
g = 9.82;

t = data(:,2);
x = data(:,3)/1000;
y = data(:,4)/1000;
n = 8000;

vikt = [0 0.012 0.068 0.125];
L = 5.52e-01;
y0 = [0 2.85e-01 2.62e-01 2.73e-01];
l = [0 L-y0(2) L-y0(3) L-y0(4)];
diameter = [3.06e-02 6.80e-02 6.79e-02];
omega0 = sqrt(g/l(p));


for i = 1:size(y,1)
    amplitude(i,1) = rad2deg(x(i)/l(p));
end

[pks,locs] = findpeaks(amplitude(1:n),t(1:n),'MinPeakDistance',0.7);

plot(t(1:n),amplitude(1:n)); % Ritar ut amplituden och peaks
hold on 
plot(locs, pks, 'ro');

pks_10 = pks(1:5:size(pks)-mod(size(pks,1),10));
locs_10 = locs(1:5:size(locs)-mod(size(locs,1),10));

figure
amplitude_10 = [locs_10,pks_10];
plot(amplitude_10(:,1),amplitude_10(:,2),'ro');







