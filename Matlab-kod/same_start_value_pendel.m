function [pks,locs,i] = same_start_value_pendel(pks1,locs1)
[row,col] = find((abs(pks1) -3.6) < 0.2);
index = row(1);
dt = locs1(row(1));
pks1(1:index-1) = [];
locs1(1:index-1) = [];

pks=pks1;
locs = locs1 - dt;
i = index;

end