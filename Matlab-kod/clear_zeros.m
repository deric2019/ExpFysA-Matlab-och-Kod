function A = clear_zeros(data)
C = find_zeros(data);
[c1,ia1,ic1] = unique(C(:,1));
data(c1(2:end,1),:) = [];
A = data;
end