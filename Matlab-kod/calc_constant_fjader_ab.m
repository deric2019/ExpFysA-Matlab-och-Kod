function constants = calc_constant_fjader_ab(table,p)

data = clear_zeros(str2double(table2array(table)));
g = 9.82;

t = data(:,2);
x = data(:,3)/1000;
y = data(:,4)/1000;
n = size(t,1);

k = [148.42 49.47]; % fjäderkonstant
vikt = [0.529 1.019 0.74];

diameter = [4e-02 5e-02 4e-02];
omega0 = sqrt(k(1)/vikt(p));

amplitude(:,1) = y;

[pks,locs] = findpeaks(amplitude(1:n),t(1:n),'MinPeakDistance',0.7);
pks_10 = pks(1:5:size(pks)-mod(size(pks,1),10));
locs_10 = locs(1:5:size(locs)-mod(size(locs,1),10));


[A0,I] = max(y);

% fun = @(b,t) b(1).*A0.*exp(-b(1).*t)./(b(2).*A0.*(1-exp(-b(1).*t))+b(1));
fun = @(b,t) A0.*exp(-b(1).*t)./(1+b(2).*(1-exp(-b(1).*t)));

x0 = [1e-05 1e-08]; % Initial guess (found by trial and error)

option = optimset('Display','off');
[sol2,resnorm,~,~,~] = lsqcurvefit(fun,[x0(1) x0(2)],locs_10,pks_10,[],[],option);

alpha = sol2(1);
beta = sol2(2);

a= alpha * 2 * vikt(p);
b = beta *(3*pi*a)/(8*omega0/A0);

constants = [a b resnorm];
end