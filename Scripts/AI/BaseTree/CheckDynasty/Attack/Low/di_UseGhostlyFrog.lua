function Weight()
	local	Item = "GhostlyFog"
	
	if GetMeasureRepeat("SIM", "Use"..Item)>0 then
		return 0
	end

	if gameplayformulas_CheckDistance("","Victim")==0 then
		return 0
	end
	
	if GetItemCount("", Item, INVENTORY_STD)>0 then
		return 100
	end

	local Price = ai_CanBuyItem("SIM", Item)
	local Round = GetRound()
	if not HasProperty("dynasty", "ItemBudget"..Round) then
		ai_CalcItemBudget("dynasty")
	end
	
	if GetProperty("dynasty", "ItemBudget"..Round) < Price then
		return 0
	end
	if Price<0 then
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
	
	if GetInsideBuilding("Victim","Inside") then
		return 0
	end

	return 20
end

function Execute()
	MeasureRun("SIM", "Victim", "UseGhostlyFog")
end
