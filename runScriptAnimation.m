clear all;
clc;

%Node and Element Excel File
dataFile = 'chassisData.xls';

%Material Properties
density = 7850; %grams/cc
youngModulus = 205e-2; %GPa
poissonRatio = 0.29;

%Applied Force Details
forceMag = [-5000 ]; %Must be applied in the Z axis direction
forceNodeID = [513 ];

%roll hoop? 513
%98

%Time Integraiont Detalis
<<<<<<< Updated upstream
runTime = 5 ;
timeStep = 0.1;
=======
runTime = .2 ;
timeStep = 0.01;
>>>>>>> Stashed changes
accuracy = 0.1;


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

U = TimeIntegrateRange(timeStep, runTime, sparseK, sparseC, sparseM, sparseF, accuracy);
[n,m] = size (U);
for i = 1:m
    unsparsed(:,i) = unSparse(U(:,i), bcList, idList);
end
return
M = plotAnimation(3,elements,idList,unsparsed);

for i = 1:length(M)
    im = frame2im(M(i));
    [imind,cm] = rgb2ind(im,256);
    if i == 1;
    imwrite(imind,cm,'test.gif','gif', 'Loopcount',inf);
    else
    imwrite(imind,cm,'test.gif','gif','WriteMode','append');
    end
end
