function gMatrix = makeGlobalKMatrix(elements, nodes, ids)
    nNodes = length(nodes);
    gMatrix = zeros(nNodes * 6, nNodes * 6);

    for i = 1:length(elements)
        lMatrix = elements(i).makeLocalKMatrix();

        pos1 = find(ids == elements(i).node1.id);
        pos2 = find(ids == elements(i).node2.id);
       
        gMatrix(((pos1-1)*6)+1:(pos1*6),((pos1-1)*6)+1:(pos1*6)) = gMatrix(((pos1-1)*6)+1:(pos1*6),((pos1-1)*6)+1:(pos1*6)) + lMatrix(1:6,1:6);
        gMatrix(((pos2-1)*6)+1:(pos2*6),((pos1-1)*6)+1:(pos1*6)) = gMatrix(((pos2-1)*6)+1:(pos2*6),((pos1-1)*6)+1:(pos1*6)) + lMatrix(7:12,1:6);
        gMatrix(((pos1-1)*6)+1:(pos1*6),((pos2-1)*6)+1:(pos2*6)) = gMatrix(((pos1-1)*6)+1:(pos1*6),((pos2-1)*6)+1:(pos2*6)) + lMatrix(1:6,7:12);
        gMatrix(((pos2-1)*6)+1:(pos2*6),((pos2-1)*6)+1:(pos2*6)) = gMatrix(((pos2-1)*6)+1:(pos2*6),((pos2-1)*6)+1:(pos2*6)) + lMatrix(7:12,7:12);
    end
end
