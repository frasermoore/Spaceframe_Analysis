function [newMatrix] = labelIDs(positionMatrix,idList)

newMatrix = zeros(length(idList),7);

positionMatrix

for i = 1 : length(idList)
    
    newMatrix(i,1) = idList(i);
    
    for j = 2 : 7
        
        newMatrix(i,j) = positionMatrix((i-1)*6 + j-1,1);
        
    end
    
end

end