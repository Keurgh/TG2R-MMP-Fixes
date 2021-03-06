function Weight()
	local	Item = "Antidote"
	local Difficulty = ScenarioGetDifficulty()
	
if GetImpactValue("SIM","poisoned")>0 then
		
	if GetMeasureRepeat("SIM", "Use"..Item)>0 then
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
	
	if Difficulty <3 then
		return 0
	end
	
	return 100
end

	return 0
end

function Execute()
	MeasureRun("SIM", "Victim", "UseAntidote")
end
