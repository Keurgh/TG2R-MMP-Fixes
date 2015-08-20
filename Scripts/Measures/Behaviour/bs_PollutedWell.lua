function Run()
	
	local Difficulty = ScenarioGetDifficulty()
	
	if GetProperty("Actor", "PollutedWell") == 1 then
		-- mod by Fajeth: Poisoned Well makes sick! Illness based on Difficulty
			if IsType("","Sim") then
				if GetImpactValue("", "Sickness")==0 and GetItemCount("","Soap")==0 then
					local zuf = Rand(100) +1
					if Difficulty > 2 then
						if zuf>98 then
						diseases_Blackdeath("",true)
						SetState("",STATE_SICK,true)
						elseif zuf >90 then
						diseases_Pox("",true)
						SetState("",STATE_SICK,true)
						elseif zuf>75 then
						diseases_Influenza("",true)
						SetState("",STATE_SICK,true)

						else
						diseases_Cold("",true)
						SetState("",STATE_SICK,true)
						end
					else
						if zuf>90 then
						diseases_Influenza("",true)
						SetState("",STATE_SICK,true)
						else
						diseases_Cold("",true)
						end
					end
				end
			end
		-- Mod end
			
	end

	return ""
end

function CleanUp()
	
end
