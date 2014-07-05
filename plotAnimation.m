function movie = plotAnimation(figNum,elements, ids, data)

    [xSize, ySize] = size(data)

    figure(figNum);
    axis equal;
    
    
    for j = 1:ySize
        for i = 1:length(elements)
            %plot3(nodes(i).x + data(1 + 6*(i-1), m), nodes(i).y + data(2 + 6*(i-1), m), nodes(i).z + data(3 + 6*(i-1), m), 'ro', 'MarkerSize', 5);
            pos1 = find(ids == elements(i).node1.id);
            pos2 = find(ids == elements(i).node2.id);
            x = [elements(i).node1.x + data(1 + 6*(pos1-1), j), elements(i).node2.x + data(1 + 6*(pos2-1), j)];
            y = [elements(i).node1.y + data(2 + 6*(pos1-1), j), elements(i).node2.y + data(2 + 6*(pos2-1), j)];
            z = [elements(i).node1.z + data(2 + 6*(pos1-1), j), elements(i).node2.z + data(3 + 6*(pos2-1), j)];
            plot3(x, y, z, 'linewidth', 1);

            hold on;
        end
        axis([-1000 1000 -1000 1000 -1000 1000]);
        grid on;
        hold off;
        movie(j) = getframe;
    end
end
