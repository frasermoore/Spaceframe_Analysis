function main
	axes = getAxes(192,72,29)
	for y = 1:3
		summer = 0;
		for z = 1:3
			summer = summer + axes(y,z) ^ 2;
		end
		axisLength(y) = sqrt(summer);
	end

	lambda = zeros(3);
	for y = 1:3
		lambda(y,:) = axes(y,:) / axisLength(y);
	end

	inv(lambda)
	transpose(lambda)
	det(lambda)

	T = zeros(12);
	for z = 0:4 
		range = (1 + 3 * z):(3 + 3 * z);
		T(range, range) = lambda;
	end
	Tt = transpose(T);
	T*Tt
end

function axisMatrix = getAxes(xx, xy, xz)
	axisMatrix(1,:) = [xx xy xz];
	counter = (0 == xx) + (0 == xy) + (0 == xz);
	if (counter < 2)
		yx = -xz;
		yy = 0;
		yz = xx; 
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
	axisMatrix(2,:) = [yx yy yz];
	axisMatrix(3,:) = cross(axisMatrix(1,:), axisMatrix(2,:));
end 
