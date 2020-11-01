function [t,x,y] = get_data_parameter_same_amplitude_pendel(data,p)
x1 = data(:,3)/1000;
y1 = data(:,4)/1000;
t1 = data(:,2);
n1 = size(t1,1);
L = 5.52e-01;
y0 = [2.85e-01 2.62e-01 2.73e-01];
l = [L-y0(1) L-y0(2) L-y0(3)];

for i = 1:size(y1,1)
    amplitude1(i,1) = rad2deg(x1(i)/l(p));
end

[pks1,locs1] = findpeaks(amplitude1(1:n1),t1(1:n1),'MinPeakDistance',0.7); % Hittar peaks

[row,col] = find((abs(pks1) -7) < 0.2);
index = row(1);
dt = t1(row(1)+1);

x1(1:index)=[];
y1(1:index)=[];
t1(1:index)=[];

x = x1;
y = y1;
t = t1 -dt;

for i = 1:size(y,1)
    amplitude(i,1) = rad2deg(x(i)/l(p));
end

end