function m = getTotalMass (elements)
    m = 0;
    for element = elements
        m=m+element.getMass();
    end
end