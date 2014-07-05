clear all;
clc;
addpath('..');

density = 7.85 / 10^3; % 7.85 g/cc to g/mm^3
modElasticity = 205; % 205 GPa
poissonRatio = 0.29;
[nodes1, elements1, ids1, bCList, dampers] = parseList('../chassisData.xls', density, modElasticity, poissonRatio);


g1 = makeGlobalKMatrix(elements1,nodes1,ids1);
g2 = makeGlobalCMatrix(dampers, nodes1, ids1);
g3 = makeGlobalMMatrix(elements1,nodes1,ids1);
