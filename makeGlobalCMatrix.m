function gMatrix = makeGlobalCMatrix(dampers, nodes, ids)
    nNodes = length(nodes);
    gMatrix = zeros(nNodes * 6, nNodes * 6);
    
    for i = 1:length(dampers)
        pos = find(ids == dampers(i).node.id);
        gMatrix((pos-1)*6+1,(pos-1)*6+1) = gMatrix((pos-1)*6+1,(pos-1)*6+1) + dampers(i).xC;
        gMatrix((pos-1)*6+2,(pos-1)*6+2) = gMatrix((pos-1)*6+2,(pos-1)*6+2) + dampers(i).yC;
        gMatrix((pos-1)*6+3,(pos-1)*6+3) = gMatrix((pos-1)*6+3,(pos-1)*6+3) + dampers(i).zC;
    end
end