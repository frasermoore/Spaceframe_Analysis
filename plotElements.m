function plotElements(figNum, Elements)
figure(figNum);
grid on;
axis([-1500 1500 -1500 1500 -1500 1500])
for i =1:length(Elements)
    x = [Elements(i).node1.x, Elements(i).node2.x];
    y = [Elements(i).node1.y, Elements(i).node2.y];
    z = [Elements(i).node1.z, Elements(i).node2.z];
    plot3(x, y, z, 'linewidth', 4);
    hold on;
end
end