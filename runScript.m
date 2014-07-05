clear all;
clc;
format shortE;

%Node and Element Excel File
dataFile = 'chassisData.xls';

%Material Properties
density = 7.850; %grams/cc
youngModulus = 205; %GPa
poissonRatio = 0.29;



for k=1:5
%Applied Force Details
forceMag = [-200*k 200*k]; %Must be applied in the Z axis direction
forceNodeID = [127 18877];
%forceNodeID = [6 19002];

%roll hoop? 513
%98

%Time Integraiont Detalis
runTime = .5 ;
timeStep = 0.01;
accuracy =.1;


%runTime = .01 ;
%timeStep = 0.01;
%accuracy = 0.1;
%Force -5000 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Run Analysis
[nodes, elements, idList, bcList, dampers] = parseList(dataFile, density, youngModulus, poissonRatio);

K = makeGlobalKMatrix(elements, nodes, idList);
C = makeGlobalCMatrix(dampers, nodes, idList);
M = makeGlobalMMatrix(elements, nodes, idList);
F = makeForceMatrix(forceMag, forceNodeID,idList);

[sparseK, sparseC, sparseM, sparseF] = sparceMatrix(bcList, idList, K, C, M, F);

U = GaussSeidel(sparseK,sparseF,accuracy,zeros(size(sparseF)));
U = unSparse(U, bcList, idList);

[newNodes, newElements] = displace(nodes,elements,U);

%Force = K*U
stresses = zeros(1,length(newElements));

for i=1 :length(newElements)

    pos1 = find(idList == newElements(i).node1.id);
    pos2 = find(idList == newElements(i).node2.id);
    range = [(pos1-1)*6+1:(pos1-1)*6+6 (pos2-1)*6+1:(pos2-1)*6+6];
    stresses(i) = findStress(newElements(i), U(range));

end

plotStresses(k, newElements,stresses);

end