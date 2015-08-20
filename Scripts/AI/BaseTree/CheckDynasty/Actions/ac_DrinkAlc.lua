function Weight()
	
	local Item = "SmallBeer"
	if SimGetRank("SIM")==3 then
	Item = "WheatBeer"
	elseif SimGetRank("SIM")>3 then
	Item = "Wine"
	end
	
	local Money = GetMoney("SIM")*0.20 
	local Difficulty = ScenarioGetDifficulty()
	
	if ItemGetBasePrice(Item) > Money then
		return 0
	end
	
	if DynastyIsShadow("SIM") then
		if SimGetOfficeLevel("SIM")<1 then
			return 0
		end
	end
	
	if Difficulty <3 then
		return 0
	end
	
	if GetMeasureRepeat("SIM", "Dri"..Item)>0 then
		return 0
	end
	
	
	if GetItemCount("", Item,INVENTORY_STD)>0 then
		return 100
	end
	
	if SimGetOfficeLevel("SIM")>-1 then
		
		if GetImpactValue("SIM","alc")>0 then
			return 0
		end
	end
	
	local Price = ai_CanBuyItem("SIM", Item)
	local money = GetMoney("SIM") / 4
	
	if Price<0 then
		return 0
	elseif Price>money then
		return 0
	end
	
	return 5
end

function Execute()

	if SimGetRank("SIM")<3 then
		MeasureRun("SIM", nil, "DriSmallBeer")
	elseif SimGetRank("SIM")==3 then
		MeasureRun("SIM", nil, "DriWheatBeer")
	elseif SimGetRank("SIM")>3 then
		MeasureRun("SIM", nil, "DriWine")
	end
end
