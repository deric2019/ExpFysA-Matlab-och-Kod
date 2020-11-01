function constants = calc_constant_pendel_ab(measurements,p)

data = clear_zeros(str2double(table2array(measurements)));
g = 9.82;

t = data(:,2);
x = data(:,3)/1000;
y = data(:,4)/1000;
n = size(t,1);

vikt = [0.012 0.068 0.125];
L = 5.52e-01;
y0 = [2.85e-01 2.62e-01 2.73e-01];
l = [L-y0(1) L-y0(2) L-y0(3)];
diameter = [3.06e-02 6.80e-02 6.79e-02];
omega0 = sqrt(g/l(p));

for i = 1:size(y,1)
    amplitude(i,1) = rad2deg(x(i)/l(p));
end

[pks,locs] = findpeaks(amplitude(1:n),t(1:n),'MinPeakDistance',1);

pks_10 = pks(1:5:size(pks)-mod(size(pks,1),10));
locs_10 = locs(1:5:size(locs)-mod(size(locs,1),10));

amplitude_10 = [locs_10,pks_10];
[M,I] = max(pks);
thetamax = M;

fun = @(b,t) b(1) .* thetamax .* exp(-b(1).*t) ./ (b(2) .* thetamax .* (1 - exp(-b(1).*t)) + b(1));

option = optimset('Display','off','TolX',1e-8);
%option = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt');

x0 = [1e-5 1e-8]; % Initial guess (found by trial and error)
[sol2,resnorm,~,~,~] = lsqcurvefit(fun,[x0(1) x0(2)],locs,pks,[0 0],[],option);

alpha = sol2(1);
beta = sol2(2);

a= alpha * 2 * vikt(p);
b = (beta * 3 * vikt(p) * pi)/(4 * omega0 * l(p));

constants = [a b resnorm];
end





