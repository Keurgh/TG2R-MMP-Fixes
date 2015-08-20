function Weight()

	local Difficulty = ScenarioGetDifficulty()
	local maxFav     = Difficulty * 7
	local roundMod   = 0

	if Difficulty == 0 then
		-- Fajeth Mod: No Shadow-Action on low settings
		if DynastyIsShadow("SIM") then
			return 0
		end
		
		roundMod = 8
	elseif Difficulty == 1 then
		-- Fajeth Mod: No Shadow-Action on low settings
		if DynastyIsShadow("SIM") then
			return 0
		end

		roundMod = 6
	elseif Difficulty == 2 then
		-- Fajeth_Mod: Allow Shadows to be aggressive if they have an office
		if DynastyIsShadow("SIM") then
			if SimGetOfficeLevel("SIM")<1 then
				return 0
			end
		end
		roundMod = 4
	elseif Difficulty == 3 then
		roundMod = 3
			-- Fajeth_Mod: Allow Shadows to be aggressive if they have an office
		if DynastyIsShadow("SIM") then
			if SimGetOfficeLevel("SIM")<1 then
				return 0
			end
		end
	else	
		-- Fajeth: Allow Shadows to be aggressive in round 1
		roundMod = 1
	if DynastyIsShadow("SIM") then
			if SimGetOfficeLevel("SIM")<1 then
				return 0
			end
		end
	end

	if GetRound() >= roundMod then

		if not DynastyGetRandomVictim("SIM", maxFav, "VictimDynasty") then
			return 0
		end
		
		if DynastyIsShadow("VictimDynasty") then
			return 0
		end
	
		local Count = DynastyGetMemberCount("VictimDynasty")
		local Value = Count
		if not DynastyIsAI("VictimDynasty") then
			Value = Value + (Difficulty * 2)
		end
		
		local VictimNo = Rand(Count)
		if not (DynastyGetMember("VictimDynasty", VictimNo, "Victim")) then
			return 0
		end		
	
		-- if gameplayformulas_CheckDistance("","Victim")==0 then
			-- return 0
		-- end
		if Value > 60 then
			Value = 60
		end
	
		if ai_AICheckAction()==true then
			return 10*Value
		else
			return 0
		end

	else
		return 0
	end

end

function Execute()
end
