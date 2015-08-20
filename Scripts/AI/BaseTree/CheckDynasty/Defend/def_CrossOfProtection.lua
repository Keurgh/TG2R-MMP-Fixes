function Weight()

	local	Item = "CrossOfProtection"
	local Money = GetMoney("SIM")*0.20
	local Difficulty = ScenarioGetDifficulty()
	
	if ItemGetBasePrice(Item) > Money then
		return 0
	end
	
	if Difficulty <3 then
		return 0
	end
	
	if DynastyIsShadow("SIM") then
		if SimGetOfficeLevel("SIM")<1 then
			return 0
		end
	end
	
	if GetMeasureRepeat("SIM", "Use"..Item)>0 then
		return 0
	end
	
	if GetItemCount("", Item,INVENTORY_STD)>0 then
		return 100
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
	MeasureRun("SIM", nil, "UseCrossOfProtection")
end
