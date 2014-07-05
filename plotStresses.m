function plotStresses(figNum,elements,stresses)
    colors = jet(128);
    figure(figNum);
    axis equal;
    grid on;
    axis([-1500 1500 -1500 1500 -1500 1500])
    minStress = min(stresses);
    maxStress = max(stresses);
    rangeStress = maxStress - minStress;
    for i =1:length(elements)
        x = [elements(i).node1.x, elements(i).node2.x];
        y = [elements(i).node1.y, elements(i).node2.y];
        z = [elements(i).node1.z, elements(i).node2.z];
        stress = stresses(i);
        color = colors(floor(127*(stress-minStress)/rangeStress) + 1,:)
        
        plot3(x, y, z, 'linewidth', 2, 'Color', color);
        hold on;
    end
end