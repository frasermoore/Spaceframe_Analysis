function [displacements] = TimeIntegrateRange(timeStep, time, KM, CM, MassM, ForceM, Accuracy)
    [n,m] = size(ForceM);

    displacements = zeros(n, floor(time/timeStep));

    PrevPosM = zeros(n,1);
    CurrPosM = zeros(n,1);

    A = (MassM./timeStep^2) + (CM./(2*timeStep));
    G1 = KM - (2.*MassM./(timeStep^2));
    G2 = (MassM/(timeStep^2)) - (CM/(2*timeStep));

    for i = 1 : floor(time/timeStep)

        B = ForceM + G1*CurrPosM + G2*PrevPosM;

        PrevPosM = CurrPosM;
        CurrPosM = GaussSeidel(A,B,Accuracy,CurrPosM);
        displacements (:, i) = CurrPosM;

    end
end
