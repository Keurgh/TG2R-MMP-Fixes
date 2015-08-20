function Weight()
	local	Item = "ToadExcrements"
	
	if GetMeasureRepeat("SIM", "Use"..Item)>0 then
		return 0
	end
	
	if GetItemCount("", Item, INVENTORY_STD)>0 then
		return 100
	end
	
	if not DynastyGetRandomBuilding("VictimDynasty", GL_BUILDING_CLASS_WORKSHOP, -1, "VicBuilding") then
		return 0
	end
	
	if GetImpactValue("VicBuilding","toadslime")>0 then
		return 0
	end
	
	if GetImpactValue("VicBuilding","toadexcrements")>0 then
		return 0
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
	
	if GetImpactValue("Victim","BadDay")>0 then
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

	return 10
end

function Execute()
	MeasureRun("SIM", "diute_Target", "UseToadExcrements")
end
