function Weight()	
	local time = math.mod(GetGametime(),24)
	-- Fajeth_Mod: default 18
	if time < 12 then
		return 0
	end
	
	-- Fajeth_Mod: default 21
	if SimGetAge("SIM")<18 then
		return 0
	end
	return 20 --1
end

function Execute()
	MeasureRun("SIM", "", "RPGSitAround")
	return
end

