%% Plot amplitude and peaks for all 
clear all
clc
[t1,x1,y1] = get_data_parameter(clear_zeros(str2double(table2array(importdata('Pendel180sKula2.mat')))));
[t2,x2,y2] = get_data_parameter(clear_zeros(str2double(table2array(importdata('Pendel180sKula3.mat')))));
[t3,x3,y3] = get_data_parameter(clear_zeros(str2double(table2array(importdata('Pendel180sKula4.mat')))));

n1 = size(t1,1);
n2 = size(t2,1);
n3 = size(t3,1);
nte = 4; % nte peak
L = 5.52e-01;
y0 = [2.85e-01 2.62e-01 2.73e-01];
l = [L-y0(1) L-y0(2) L-y0(3)];

for i = 1:size(y1,1)
    amplitude1(i,1) = rad2deg(x1(i)/l(1));
end

for i = 1:size(y2,1)
    amplitude2(i,1) = rad2deg(x2(i)/l(2));
end

for i = 1:size(y3,1)
    amplitude3(i,1) = rad2deg(x3(i)/l(3));
end

[pks1,locs1] = findpeaks(amplitude1(1:n1),t1(1:n1),'MinPeakDistance',1); % Hittar peaks
[pks2,locs2] = findpeaks(amplitude2(1:n2),t2(1:n2),'MinPeakDistance',1);
[pks3,locs3] = findpeaks(amplitude3(1:n3),t3(1:n3),'MinPeakDistance',1);

[pks1,locs1,i1] = same_start_value_pendel(pks1,locs1);
[pks2,locs2,i2] = same_start_value_pendel(pks2,locs2);
[pks3,locs3,i3] = same_start_value_pendel(pks3,locs3);


pks1_10 = pks1(1:nte:size(pks1)-mod(size(pks1,1),10)); % Var tionde peak
locs1_10 = locs1(1:nte:size(locs1)-mod(size(locs1,1),10));

pks2_10 = pks2(1:nte:size(pks2)-mod(size(pks2,1),10));
locs2_10 = locs2(1:nte:size(locs2)-mod(size(locs2,1),10));

pks3_10 = pks3(1:nte:size(pks3)-mod(size(pks3,1),10));
locs3_10 = locs3(1:nte:size(locs3)-mod(size(locs3,1),10));

amplitude1_10 = [locs1_10,pks1_10];
amplitude2_10 = [locs2_10,pks2_10];
amplitude3_10 = [locs3_10,pks3_10];

plot(amplitude1_10(:,1),amplitude1_10(:,2),'rx');
hold on
plot(amplitude2_10(:,1),amplitude2_10(:,2),'gx');
hold on
plot(amplitude3_10(:,1),amplitude3_10(:,2),'bx');

[M1,I1] = max(pks1);
[M2,I2] = max(pks2);
[M3,I3] = max(pks3);

thetamax1 = M1;
thetamax2 = M2;
thetamax3 = M3;


fun1 = @(b,t) b(1) .* thetamax1 .* exp(-b(1).*t) ./ (b(2) .* thetamax1 .* (1 - exp(-b(1).*t)) + b(1));
fun2 = @(b,t) b(1) .* thetamax2 .* exp(-b(1).*t) ./ (b(2) .* thetamax2 .* (1 - exp(-b(1).*t)) + b(1));
fun3 = @(b,t) b(1) .* thetamax3 .* exp(-b(1).*t) ./ (b(2) .* thetamax3 .* (1 - exp(-b(1).*t)) + b(1));

option = optimset('Display','off');
x0 = [1e-6 1e-8]; % Initial guess (found by trial and error)

[sol1,resnorm1,~,~,~] = lsqcurvefit(fun1,[x0(1) x0(2)],locs1_10,pks1_10,[],[],option);
[sol2,resnorm2,~,~,~] = lsqcurvefit(fun2,[x0(1) x0(2)],locs2_10,pks2_10,[],[],option);
[sol3,resnorm3,~,~,~] = lsqcurvefit(fun3,[x0(1) x0(2)],locs3_10,pks3_10,[],[],option);


alpha1 = sol1(1);
beta1 = sol1(2);

alpha2 = sol2(1);
beta2 = sol2(2);

alpha3 = sol3(1);
beta3 = sol3(2);

hold on
plot(fun1([alpha1 beta1],locs1),'r','linewidth',1);
hold on
plot(fun2([alpha2 beta2],locs2),'color',[0, 0.5, 0],'linewidth',1);
hold on
plot(fun3([alpha3 beta3],locs3),'b','linewidth',1);

legend('m = 0,012 kg' ,'m = 0,068 kg' , 'm = 0,125 kg ');
set(gca,'FontSize',16)
xlabel('Tid [s]')
ylabel('Största vinkeln för var 5:de oscillation [deg]')

