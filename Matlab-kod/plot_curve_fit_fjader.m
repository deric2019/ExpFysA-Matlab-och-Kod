% Plot curve fit fjader
clc
clear all
clf
p = 1;
table = importdata('Fjader1Vikt1.mat');
data = clear_zeros(str2double(table2array(table)));


t = data(:,2);
x = data(:,3)/1000;
y = data(:,4)/1000;
n = size(data);

k = [148.42 49.47]; % fjäderkonstant
vikt = [0.529 1.019 0.74];

[pks,locs] = findpeaks(y(1:n),t(1:n),'MinPeakDistance',1);
plot(locs,pks,'bo');

pks_10 = pks(1:1:size(pks)-mod(size(pks,1),10));
locs_10 = locs(1:1:size(locs)-mod(size(locs,1),10));

amplitude = [locs_10,pks_10];
% plot(amplitude(:,1),amplitude(:,2),'ro');

[Amax,Imax] = max(y(1:70));
[Amin,Imin] = min(y(1:70));

A0 = Amax;

fun = @(b,t) A0 .* exp(-b(1).*t) ./ (b(2) .* (1 - exp(-b(1).*t)) + 1);

x0 = [1e-04 1e-05]; % Initial guess (found by trial and error)
lb = [];
ub = [];
options = optimset('Display','off');

[sol2,resnorm,~,~,~] = lsqcurvefit(fun,[x0(1) x0(2)],locs,pks,lb,ub,options);

alpha = sol2(1);
beta = sol2(2);

hold on
times = linspace(0,locs(end),150);
plot(fun([alpha beta],locs),'r');


