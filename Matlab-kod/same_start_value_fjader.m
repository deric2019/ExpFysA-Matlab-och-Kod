function [pks,locs] = same_start_value_fjader(pks1,locs1,eq)
[row,col] = find((abs(pks1-eq) < 0.022));
index = row(1);
dt = locs1(row(1));
pks1(1:index-1) = [];
locs1(1:index-1) = [];

pks=pks1;
locs = locs1 - dt;
i = index;

end