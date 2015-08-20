function Weight()

	if GetMeasureRepeat("SIM", "AddPamphlet")>0 then
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
	
	return 25
	-- return 50
end

function Execute()
	MeasureRun("SIM","VICTIM","AddPamphlet")
end

