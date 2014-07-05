function [A] = GaussElim(A,B)

[n,m] = size(A);

A(:,m+1) = B;

C = A;

for i = 2 : n
    
    for j = 1 : n+1
        
        A(i,j) = 
        
        for k = 1 : n-1
            
            C(i,j) = A(i,j) - (A(i,k) * A(k,j) / A(k,k))
            
        end
        
    end
    
end

end