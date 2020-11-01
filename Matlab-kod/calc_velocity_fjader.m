function v = calc_velocity_fjader(data)

y = data(:,4)/1000;
t = data(:,2);

for i = 1:size(t,1)-1
    vy(i) = (y(i+1)-y(i))/(t(i+1)-t(i));
end

v = abs(vy);

end