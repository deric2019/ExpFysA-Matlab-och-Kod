function v = calc_velocity_pendel(data)

x = data(:,3)/1000; % SI units.
y = data(:,4)/1000;
t = data(:,2);

for i = 1:size(t,1)-1
    vx(i) = (x(i+1)-x(i))/(t(i+1)-t(i));
    vy(i) = (y(i+1)-y(i))/(t(i+1)-t(i));
end

v = sqrt(vx.^2 + vy.^2);

end