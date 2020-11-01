function A = find_zeros(data)
n = 1;
for i = 1:size(data,1)-1
    for j = 1:size(data,2)
        if(data(i,j) == 0)
            A(n,1) = i;
            A(n,2) = j;
            n = n +1;
        end
    end      
end