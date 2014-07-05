function [KM, CM, MM, FM] = sparceMatrix(fixedList,IDList,KM,CM,MM,FM)

[n,m] = size(fixedList);

for i = n : -1 : 1
    
    nodeID = find(IDList == fixedList(i,1));
    
    for j = m : -1 : 2
        
        if(fixedList(i,j) == 1)
            
            KM = sparce((nodeID-1)*6+j-1,KM);
            CM = sparce((nodeID-1)*6+j-1,CM);
            MM = sparce((nodeID-1)*6+j-1,MM);
            FM = sparce((nodeID-1)*6+j-1,FM);
            
        end
        
    end
    
end

end