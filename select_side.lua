function select_side(a, b)
	if a*b > 0 then
		if a-b < b-a then
			return 1, b-a;		-- против хода часовой стрелки
		else 
			return -1, a-b;
		end
	else
		local mod = 1;
		if a < 0 then	
			mod = -1;
		end
		if mod*a - mod*b < 180 then
			return -1*mod, mod*a - mod*b;
		else 
			return 1*mod, 360 - mod*a + mod*b;
		end 
	end
end

print "Input alpha and beta angles"
a = io.read()
a = tonumber(a)
b = io.read()
b = tonumber(b)

side, r = select_side(a, b)
print(side, r)
for i = 1, math.abs(r) do
	a = a + side;
	if a > 180 then
		a = -360 + a;
	elseif a < -180 then
		a = 360 + a;
	end
end
print(a)
