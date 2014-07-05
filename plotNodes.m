function plotNodes(figNum, nodes)
figure(figNum);
grid on;
axis([-1500 1500 -1500 1500 -1500 1500])
for i = 1:length(nodes)
    h = plot3(nodes(i).x, nodes(i).y, nodes(i).z, 'ro', 'MarkerSize', 5);
    hold on;
end
end