classdef Node
    properties
        id
        x
        y
        z
    end
    methods
        function n = Node(i,x ,y, z)
            n.id = i;
            n.x = x;
            n.y = y;
            n.z = z;
        end
        function [a,b,c,d] = getDistance(obj, otherNode)
            %return the x, y, z and total distances
            a = otherNode.x - obj.x;
            b = otherNode.y - obj.y;
            c = otherNode.z - obj.z;
            d = sqrt(a^2 + b^2 + c^2);
        end
    end
end
