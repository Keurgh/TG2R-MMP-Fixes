function Weight()

	local Difficulty = ScenarioGetDifficulty() 

	if GetMoney("dynasty") < 750 then
		return 0
	end
	
	if not GetHomeBuilding("SIM", "myrm_home") then
		return 0
	end
		
	if not BuildingCanHireNewWorker("myrm_home") then
		return 0
	end
	
	-- Fajeth_Mod: AI will always hire max count on high settings
	if Difficulty <3 then
		local Value	= DynastyGetRanking("dynasty")
		local	Wanted= 1 + (Value / 25000)
		local Have	= DynastyGetWorkerCount("dynasty", GL_PROFESSION_MYRMIDON)
		if Have >= Wanted then
			return 0
		end
	end
	-- Mod end
	
	return 100
end

function Execute()
	HireWorker("myrm_home")
end

