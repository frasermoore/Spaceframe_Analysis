function Stress = findStress(element, U)

F = element.getForces(U);

S1 = F(1)/element.getArea();
S2 = F(2)/element.getArea();
S3 = F(3)/element.getArea();
S4 = F(4)/element.getPMOI()*cos(pi) - F(4)/element.getPMOI()*sin(pi);
S5 = F(5)*element.outerDiameter/2/element.getAMOI();
S6 = F(6)*element.outerDiameter/2/element.getAMOI();


Stress1 = [(-S6 - S1) (-S4 - S3)];
Stress2 = [(-S5 -S1) (S4+S2)];
Stress3 = [(S6 - S1) (S4 - S3)];
Stress4 = [(S5 -S1) (S4-S2)];

SQ1 = sqrt(Stress1(1)^2 + Stress1(2)^2);
SQ2 = sqrt(Stress2(1)^2 + Stress2(2)^2);
SQ3 = sqrt(Stress3(1)^2 + Stress3(2)^2);
SQ4 = sqrt(Stress4(1)^2 + Stress4(2)^2);

max = 0;
if (SQ2 > SQ1)
    max = Stress2;
end
if (SQ3 > SQ2)
    max = Stress3;
end
if (SQ4 > SQ3)
    max = Stress4;
end
if (max == 0)
   max = Stress1;
end
    StressX = max(1);
    StressY = 0;
    StressZ = 0;
    
    Shear = max(2);
    
    Sigma1 = (StressX + StressY)/2 + sqrt(((StressX - StressY)/2)^2+Shear^2);
    Sigma2 = (StressX + StressY)/2 - sqrt(((StressX - StressY)/2)^2+Shear^2);
    Stress = sqrt(Sigma1^2 +Sigma2^2 -Sigma1*Sigma2);
end
