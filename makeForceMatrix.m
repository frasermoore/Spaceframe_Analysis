function [FM] = makeForceMatrix(force, nodeID, idList)

n = length(idList)*6;
FM = zeros(n,1);

for i = 1 : length(force)

    id = find(idList == nodeID(i));

    FM((id-1)*6+3,1) = force(i);
    %FM((id-1)*6+1,1) = force
    
end

end