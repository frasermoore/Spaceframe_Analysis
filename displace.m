function [nodes, elements] = displace(nodes, elements, positionMatrix)

for i = 1 : length(nodes)
    
    nodes(i).x = nodes(i).x + positionMatrix((i-1)*6+1,1);
    nodes(i).y = nodes(i).y + positionMatrix((i-1)*6+2,1);
    nodes(i).z = nodes(i).z + positionMatrix((i-1)*6+3,1);
    
end

for i = 1:length(elements)
    id1 = elements(i).node1.id;
    id2 = elements(i).node2.id;
    for j = 1:length(nodes)
        if (nodes(j).id == id1)
            elements(i).node1 = nodes(j);
        end
        if (nodes(j).id == id2)
            elements(i).node2 = nodes(j);
        end
    end
end

end