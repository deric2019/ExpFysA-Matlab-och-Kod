%% Plot amplitude and peaks for all 
clear all
clc
clf
[t1,x1,y1] = get_data_parameter_remove(clear_zeros(str2double(table2array(importdata('Fjader1Vikt3_240s.mat')))));
[t2,x2,y2] = get_data_parameter(clear_zeros(str2double(table2array(importdata( 'Fjader1Vikt2_240s.mat')))));
[t3,x3,y3] = get_data_parameter(clear_zeros(str2double(table2array(importdata('Fjader1Vikt1_240s.mat')))));

n1 = size(t1,1);
n2 = size(t2,1);
n3 = size(t3,1);
nte = 4;
equil_pos1 = (max(y1)+min(y1))/2; % Jämviktsläge
equil_pos2 = (max(y2)+min(y2))/2;
equil_pos3 = (max(y3)+min(y3))/2;

[pks1,locs1] = findpeaks(y1(1:n1),t1(1:n1),'MinPeakDistance',1.5);
[pks2,locs2] = findpeaks(y2(1:n2),t2(1:n2),'MinPeakDistance',1.5);
[pks3,locs3] = findpeaks(y3(1:n3),t3(1:n3),'MinPeakDistance',1.5);

[pks1,locs1] = same_start_value_fjader(pks1,locs1,equil_pos1);
[pks2,locs2] = same_start_value_fjader(pks2,locs2,equil_pos2);
[pks3,locs3] = same_start_value_fjader(pks3,locs3,equil_pos3);

pks1_10 = pks1(1:nte:size(pks1)-mod(size(pks1,1),10));
locs1_10 = locs1(1:nte:size(locs1)-mod(size(locs1,1),10));

pks2_10 = pks2(1:nte:size(pks2)-mod(size(pks2,1),10));
locs2_10 = locs2(1:nte:size(locs2)-mod(size(locs2,1),10));

pks3_10 = pks3(1:nte:size(pks3)-mod(size(pks3,1),10));
locs3_10 = locs3(1:nte:size(locs3)-mod(size(locs3,1),10));

amplitude1 = [locs1_10,pks1_10];
amplitude2 = [locs2_10,pks2_10];
amplitude3 = [locs3_10,pks3_10];

plot(amplitude1(:,1),amplitude1(:,2)-equil_pos1,'rx');
hold on
plot(amplitude2(:,1),amplitude2(:,2)-equil_pos2,'gx');
hold on
plot(amplitude3(:,1),amplitude3(:,2)-equil_pos3,'bx');

[Amax1,Imax1] = max(pks1);
[Amax2,Imax2] = max(pks2);
[Amax3,Imax3] = max(pks3);

A0_1 = Amax1;
A0_2 = Amax2;
A0_3 = Amax3;

fun1 = @(b,t) b(1).*A0_1.*exp(-b(1).*t)./(b(2).*A0_1.*(1-exp(-b(1).*t))+b(1));
fun2 = @(b,t) b(1).*A0_2.*exp(-b(1).*t)./(b(2).*A0_2.*(1-exp(-b(1).*t))+b(1));
fun3 = @(b,t) b(1).*A0_3.*exp(-b(1).*t)./(b(2).*A0_3.*(1-exp(-b(1).*t))+b(1));

x0 = [1e-04 1e-05]; % Initial guess (found by trial and error)
lb = [];
ub = [];
options = optimset('Display','off');

[sol1,resnorm1,~,~,~] = lsqcurvefit(fun1,[x0(1) x0(2)],locs1,pks1,lb,ub,options);
[sol2,resnorm2,~,~,~] = lsqcurvefit(fun2,[x0(1) x0(2)],locs2,pks2,lb,ub,options);
[sol3,resnorm3,~,~,~] = lsqcurvefit(fun3,[x0(1) x0(2)],locs3,pks3,lb,ub,options);

alpha1 = sol1(1);
beta1 = sol1(2);

alpha2 = sol2(1);
beta2 = sol2(2);

alpha3 = sol3(1);
beta3 = sol3(2);


hold on
times1 = linspace(locs1(1),locs1(end),200);
times2 = linspace(locs2(1),locs2(end) ,200);
times3 = linspace(locs3(1),locs3(end),170);

plot(fun1([alpha1 beta1],times1)-equil_pos1,'r','linewidth',1);
plot(fun2([alpha2 beta2],times2)-equil_pos2,'color',[0, 0.5, 0],'linewidth',1);
plot(fun3([alpha3 beta3],times3)-equil_pos3,'b','linewidth',1);

legend('m = 0,529 kg','m = 0,740 kg','m = 1,019 kg')
ax = gca;
ax.YAxis.Exponent =-3;

set(gca,'FontSize',16)
xlabel('Tid [s]')
ylabel('Största amplituden för var 5:de oscillation [mm]')

































