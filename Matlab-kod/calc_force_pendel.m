% Calculate Force and velocity graph

function F = calc_force_pendel(data,a,b)
    v = calc_velocity_pendel(data); 
    F = a.*v + b.*v.^2;
end
