function Weight()

	if GetMeasureRepeat("SIM", "InsultCharacter")>0 then
		return 0
	end
	
	if GetNobilityTitle("SIM")<6 then
		return 0
	end
	
	if SimGetClass("SIM")~=GL_CLASS_CHISELER then
		return 0
	end
	
	if SimGetClass("VICTIM")==GL_CLASS_CHISELER then
		return 0
	end
	
	if DynastyIsShadow("SIM") then
		if SimGetOfficeLevel("SIM")<1 then
			return 0
		end
	end
	
	if DynastyIsShadow("Victim") then
		return 0
	end
	
	if GetImpactValue("VICTIM","BadDay")>0 then
		return 0
	end
	
	if GetInsideBuilding("Victim","Inside") then
		return 0
	end

	return 20
end

function Execute()
	MeasureRun("SIM","VICTIM","InsultCharacter")
end

