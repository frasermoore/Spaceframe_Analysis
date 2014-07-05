function [positionMatrix] = unSparse(posMatrix, fixedList, idList)

[n,m] = size(posMatrix);
[a,b] = size(fixedList);

% for (i=1:length(F))
%    id = find(idList == fixedList(i,1));
%    if
%     
%     
% end





y = 1;
for i = 1 : a
    
    id = find(idList == fixedList(i,1));
    
    for j = 2 : b
        
        if(fixedList(i,j) == 1)
            
            index(y) = ((id-1)*6) + j - 1;
            y = y + 1;
            
        end
        
    end
    
end
    
positionMatrix = zeros(n+length(index),1);

index(y) = 0;

k = 1;
l = 1;

for z = 1 : length(positionMatrix)
    
    if(z == index(l))
    
        l = l + 1;
        
    else
        
        positionMatrix(z,1) = posMatrix(k,1);
    
        k = k + 1;
        
    end
    
end