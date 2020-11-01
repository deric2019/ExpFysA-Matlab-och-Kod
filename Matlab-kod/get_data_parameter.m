function [t,x,y] = get_data_parameter(data)
x = data(:,3)/1000;
y = data(:,4)/1000;
t = data(:,2);
end