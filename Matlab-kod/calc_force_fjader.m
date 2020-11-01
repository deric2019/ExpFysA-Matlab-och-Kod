function F = calc_force_fjader(data,a,b)
    v = calc_velocity_fjader(data); 
    F = abs(a.*v) + abs(b.*v.^2);
end