clear all
clc
close all

[nodez, elementz] = parseList('chassisData.xls', 5, 20, 100);


plotElements(1, elementz);
plotNodes(1, nodez);