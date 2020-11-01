% Plot curve fit pendel
clc
clear all
clf
table = importdata('PendelSondagKula4.mat');
data = clear_zeros(str2double(table2array(table)));
p = 2;
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
% plot(pks,locs,'ro');

pks_10 = pks(1:5:size(pks)-mod(size(pks,1),10));
locs_10 = locs(1:5:size(locs)-mod(size(locs,1),10));


amplitude_10 = [locs_10,pks_10];
plot(amplitude_10(:,1),amplitude_10(:,2),'ro');

[M,I] = max(amplitude);
thetamax = M;

fun = @(b,t) b(1) .* thetamax .* exp(-b(1).*t) ./ (b(2) .* thetamax .* (1 - exp(-b(1).*t)) + b(1));

option = optimset('Display','off');

x0 = [1e-6 1e-8]; % Initial guess (found by trial and error)

[sol2,resnorm,~,~,~] = lsqcurvefit(fun,[x0(1) x0(2)],locs_10,pks_10,[],[],option);

alpha = sol2(1);
beta = sol2(2);

hold on
plot(fun([alpha beta],locs));









