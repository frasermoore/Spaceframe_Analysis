function [nodes, elements, idList, bCList, dampersList] = parseList (filename, density, youngsModulus, poisson)
    % Because of the matlab xlsread function, our xls files are stripped down
    % Only the data remains, in a known format
    nodesData = xlsread(filename, 'Nodes');
    nodesMap = containers.Map('KeyType','int32', 'ValueType','any');
    
    for i = 1:length(nodesData)
        id = nodesData(i,1);
        x = nodesData(i,2);
        y = nodesData(i,3);
        z = nodesData(i,4);
        nodesMap(id) = Node(id,x,y,z);
    end

    idList = [];
    elementsData = xlsread(filename, 'Elements');
    elements = Element.empty(0,length(elementsData));
    [n,~] = size(elementsData);
    for i = 1:n
        id = elementsData(i,1);
        node1 = nodesMap(elementsData(i,2));
        node2 = nodesMap(elementsData(i,3));
        idList = [idList, node1.id, node2.id];
        oD = elementsData(i,4);
        thickness = elementsData(i,5);
        beamShape = elementsData(i,6);
        connectionType = elementsData(i,7);
        elements(i) = Element(id,node1,node2,oD,thickness,beamShape,connectionType, density, youngsModulus, poisson);
    end
    
    dampersData = xlsread(filename, 'Dampers');
    dampersList = Damper.empty(0,length(dampersData));
    [n,~] = size(dampersData);
    for i = 1:n
        node = nodesMap(dampersData(i,1));
        xC = dampersData(i,2);
        yC = dampersData(i,3);
        zC = dampersData(i,4);
        dampersList(i) = Damper(node,xC,yC,zC);
    end
    
    idList = sort(unique(idList));
    nodes = Node.empty(0,length(idList));
    for i = 1:length(idList)
        nodes(i) = nodesMap(idList(i));
    end
    bCList = sortrows(xlsread(filename, 'BC'),1);
end
