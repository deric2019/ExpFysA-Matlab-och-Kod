function A = calc_amplitude(data,L,l)
x = data(:,3)/1000;
y = data(:,4)/1000;
t = data(:,2);

for i = 1:size(y,1)
    amplitude(i,1) = rad2deg(asin((x(i))/l));
end
A(:,1) = t;
A(:,2) = amplitude;

end