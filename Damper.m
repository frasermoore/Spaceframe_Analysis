classdef Damper
    properties
        node
        xC
        yC
        zC
    end
    methods
        function obj = Damper(node,xC,yC,zC)
            obj.node = node;
            obj.xC = xC;
            obj.yC = yC;
            obj.zC = zC;
        end
    end
end