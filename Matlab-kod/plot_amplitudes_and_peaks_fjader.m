%% Plot amplitude and peaks fjader
clc
clear all
clf
p = 1;
table = importdata('Fjader1Vikt2.mat');
data = clear_zeros(str2double(table2array(table)));

t = data(:,2);
x = data(:,3)/1000;
y = data(:,4)/1000;
n = size(data,1);

k = [148.42 49.47]; % fjäderkonstant
vikt = [0.529 1.019 0.74];

equil_pos = (max(y)+min(y))/2;
y_amplitude = y-equil_pos;

[pks,locs] = findpeaks(y_amplitude(1:n),t(1:n),'MinPeakDistance',1.1);


plot(t(1:n),y_amplitude(1:n));
hold on 
plot(locs, pks, 'ro');

pks_10 = pks(1:2:size(pks)-mod(size(pks,1),10));
locs_10 = locs(1:2:size(locs)-mod(size(locs,1),10));

figure
amplitude = [locs_10,pks_10];
plot(amplitude(:,1),amplitude(:,2),'ro');