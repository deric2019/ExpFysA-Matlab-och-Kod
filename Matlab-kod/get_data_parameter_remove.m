function [t,x,y] = get_data_parameter_remove(data)
x = data(5:end,3)/1000;
y = data(5:end,4)/1000;
t = data(5:end,2);
end