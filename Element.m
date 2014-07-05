classdef Element
    properties
        identity
        node1
        node2
        outerDiameter
        thickness
        %beamShape and connectionType are integers that define the shape of the beam.
        % beamShape:
        % 		1 - Tube
        % 		2 - Square
        % 		3 - Rigid(No moments)
        beamShape
        % connectionType:
        % 		1 - Solid Connection
        % 		2 - Pin Connection
        connectionType
        density
        youngsModulus
        poisson
        axes
        axisLength
        stiffness
        forces
    end
    methods
        function e = Element(id,n1, n2, oD, t, bS, cT, D, yM, p)
            %Member constructor function
            e.identity = id;
            e.node1 = n1;
            e.node2 = n2;
            e.beamShape = bS;
            e.connectionType = cT;
            e.poisson = p;
            if (bS == 3)
                e.outerDiameter = 10;
                e.thickness = 2.5;
                e.youngsModulus = 100 * yM;
                e.density = 100 * D;
                e.poisson = 500;
            else
                e.youngsModulus = yM;
                e.density =  D;
                e.outerDiameter = 25.4 * oD;
                e.thickness = 25.4 * t;
            end
            
            [xx,xy,xz,~] = e.node1.getDistance(e.node2);
            e.axes(1,:) = [xx xy xz];
            counter = (0 == xx) + (0 == xy) + (0 == xz);
            if (counter < 2)
                yx = -xz;
                yy = xx;
                yz = 0;
            else
                if (xx ~= 0)
                    yx = 0;
                    yy = xx;
                    yz = 0;
                elseif (xy ~= 0)
                    yx = 0;
                    yy = 0;
                    yz = xy;
                else
                    yx = xz;
                    yy = 0;
                    yz = 0;
                end
            end
            e.axes(2,:) = [yx yy yz];
            e.axes(3,:) = cross(e.axes(1,:), e.axes(2,:));
            
            axisLength = zeros(3,1);
            for y = 1:3
                summer = 0;
                for z = 1:3
                    summer = summer + e.axes(y,z) ^ 2;
                end
                axisLength(y) = sqrt(summer);
            end
            e.axisLength = axisLength;
            
            e.stiffness = e.makeKMatrix();
        end
        function g = getMOR(e)
            % Modulus of Ridgidity
            g = e.youngsModulus / (2*(1 + e.poisson));
        end
        function T = makeTransformMatrix(e)
            lambda = zeros(3);
            for y = 1:3
                lambda(y,:) = e.axes(y,:) ./ e.axisLength(y);
            end
            
            T = zeros(12);
            for z = 0:3
                range = (1 + 3 * z):(3 + 3 * z);
                T(range, range) = lambda;
            end
        end
        function kMatrix = makeLocalKMatrix(e)
            kMatrix = e.stiffness;
        end
        function kMatrix = makeKMatrix(e)
            % Create the local stiffness matrix for the member
            % Were assuming a symmetric beam, therefore Iy and Iz are equal
            A = e.getArea();
            I = e.getAMOI();
            J = e.getPMOI();
            E = e.youngsModulus;
            G = e.getMOR();
            k = zeros(12);
            L = e.axisLength(1);
            
            % Very Manual way of doing this matrix
            % Top Left Quadrant
            k(1,1) = A * E / L;
            k(2,2) = 12 * E * I / L^3;
            k(2,6) = 6 * E * I / L^2;
            k(3,3) = k(2,2);
            k(3,5) = -k(2,6);
            k(4,4) = G * J / L;
            k(5,3) = k(3,5);
            k(5,5) = 4 * E * I / L;
            k(6,2) = k(2,6);
            k(6,6) = k(5,5);
            
            % Top Right Quadrant
            k(1,7) = -k(1,1);
            k(2,8) = -k(2,2);
            k(3,9) = -k(3,3);
            k(4,10) = -k(4,4);
            k(5,11) = 2 * E * I / L;
            k(6,12) = k(5,11);
            
            k(2,12) = k(2,6);
            k(3,11) = k(3,5);
            k(5,9) = -k(5,3);
            k(6,8) = -k(6,2);
            
            
            % Bottom Left Quadrant
            for x = 0:5
                k(7 + x, 1 + x) = k(1 + x, 7 + x);
            end
            k(8,6) = k(6,8);
            k(9,5) = k(5,9);
            k(11,3) = k(3,11);
            k(12,2) = k(2,12);
            % Bottom Right Quadrant
            for x = 0:5
                k(7 + x, 7 + x) = k(1 + x, 1 + x);
            end
            k(12,8) = k(6,8);
            k(11,9) = k(5,9);
            k(9,11) = -k(3,11);
            k(8,12) = -k(2,12);

            T = e.makeTransformMatrix();
            Tinv = transpose(T);
            kMatrix = Tinv * k * T;
        end
        function mMatrix = makeLocalMMatrix(e)
            % Create the local stiffness matrix for the member
            % Were assuming a symmetric beam, therefore Iy and Iz are equal
            rho = e.density;
            A = e.getArea();
            I = e.getAMOI();
            m = zeros(12);
            L = e.axisLength(1);
            
            % Top Right Quadrant
            m(1,1) = 1/3;
            m(2,2) = 13/35;
            m(3,3) = 13/35;
            m(4,4) = 2*I/3/A;
            m(5,5) = L^2 / 105;
            m(6,6) = m(5,5);
            
            m(2,6) = 11 * L / 210;
            m(3,5) = -m(2,6);
            m(5,3) = m(3,5);
            m(6,2) = m(2,6);
            
            % Top Left Quadrant
            m(1,7) = 1/6;
            m(2,8) = 9/70;
            m(3,9) = m(2,8);
            m(4,10) = 2 * I / 6 / A;
            m(5,11) = -L^2/140;
            m(6,12) = m(5,11);
            
            m(2,12) = -13 * L/420;
            m(3,11) = -m(2,12);
            m(5,9) = m(2,12);
            m(6,8) = m(3,11);
            
            % Bottom Left Quadrant
            for x = 0:5
                m(7 + x, 1 + x) = m(1 + x, 7 + x);
            end
            m(8,6) = m(6,8);
            m(9,5) = m(5,9);
            m(11,3) = m(3,11);
            m(12,2) = m(2,12);
            
            % Bottom Right Quadrant
            for x = 0:5
                m(7 + x, 7 + x) = m(1 + x, 1 + x);
            end
            m(12,8) = -m(6,2);
            m(11,9) = -m(5,3);
            m(9,11) = -m(3,5);
            m(8,12) = -m(2,6);
            
            T = e.makeTransformMatrix();
            Tinv = transpose(T);
            mMatrix = Tinv * rho * A * L * m * T;
        end
        function area = getArea(e)
            if(e.beamShape == 1 || e.beamShape == 3)
                area = pi*((e.outerDiameter/2)^2 - (e.outerDiameter/2-e.thickness)^2);
            elseif(e.beamShape == 2)
                area = (e.outerDiameter)^2 - (e.outerDiameter - 2*e.thickness)^2;
            end
        end
        function I = getAMOI(obj)
            if (obj.beamShape == 1 || obj.beamShape == 3)
                I = pi / 4 * ((obj.outerDiameter/2)^4 - ((obj.outerDiameter - 2*obj.thickness)/2)^4);
            elseif (obj.beamShape == 2)
                I = ((obj.outerDiameter^4) - (obj.outerDiameter - 2*obj.thickness)^4)/12;
            end
        end
        function J = getPMOI(obj)
            J = 2*obj.getAMOI();
        end
        
        function I = getMMOI(obj)
            [~,~,~,L] = obj.node1.getDistance(obj.node2);
            if (obj.beamShape == 1 || obj.beamShape ==3)
                I = pi / 2 * L * obj.density * ((obj.outerDiameter/2)^4 - ((obj.outerDiameter - 2*obj.thickness)/2)^4);
            elseif (obj.beamShape == 2)
                I = obj.density * obj.outerDiameter^2 * L / 12 * (2 * (obj.outerDiameter^2)) - obj.density * (obj.outerDiameter - 2*obj.thickness)^2 * L / 12 * (2*(obj.outerDiameter - 2*obj.thickness)^2);
            end
        end
        function m = getMass(e)
            m = e.getArea() * e.axisLength(1) * e.density;
        end
        function forces = getForces(e, u)
            forces = e.makeTransformMatrix() * e.stiffness * u;
        end
    end
end
