function [matrix] = sparce(id,matrix)

[n,m] = size(matrix);

    matrix(id,:) = [];
    
    if(m ~= 1)
    
        matrix(:,id) = [];
        
    end
end