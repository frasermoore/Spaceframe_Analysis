clear all;
clc;
addpath('..');
nodes = [Node(1,1,1,2) Node(2,1,2,3) Node(3,1,4,9)];
ids = [1 2 3];
elements = [Element(1,nodes(1),nodes(2),1,0.1,1,1,1,1,1),...
            Element(2,nodes(2),nodes(3),1,0.1,1,1,1,1,1),...
            Element(3,nodes(3),nodes(1),1,0.1,1,1,1,1,1)];
        
k = elements(1).makeLocalKMatrix();
m = elements(1).makeLocalMMatrix();
g = makeGlobalKMatrix(elements,nodes,ids);
g2 = makeGlobalMMatrix(elements,nodes,ids);