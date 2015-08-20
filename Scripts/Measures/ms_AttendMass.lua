function Run()
	if IsGUIDriven() then
		GetInsideBuilding("","Destination")
	end

	if not AliasExists("Destination") then
		return 
	end
	
	if GetInsideBuildingID("")~=GetID("Destination") then
		-- sim is not in building - first move to church
		if not GetOutdoorMovePosition("", "Destination", "MovePos") then
			return
		end
		
		if not f_MoveTo("", "MovePos") then
			return
		end
	end
	
	
	
	local	TimeOut

	if GetImpactValue("Destination","MassInProgress")~=1 then
	
		TimeOut = Gametime2Realtime(1)
		while GetImpactValue("Destination","MassInProgress")~=1 and TimeOut>0 do
			Sleep(2)
			TimeOut = TimeOut - 2
		end
		
		if GetImpactValue("Destination","MassInProgress")~=1 then
			return
		end

	end

	SetAvoidanceRange("",15)
	local success = false
	local	Value
	
	for trys=0,10 do
		Value = Rand(29)+1
		if GetFreeLocatorByName("Destination","Sit",Value,Value,"SitPos") then
			success = f_BeginUseLocator("","SitPos",GL_STANCE_SITBENCH,true)
			if success then
				break
			end
		end
	end
	
	if not success then
		if GetFreeLocatorByName("Destination","Sit",1,30,"SitPos") then
			success = f_BeginUseLocator("","SitPos",GL_STANCE_SITBENCH,true)
		end
	end
	
--	if not success then
--		LocIndex = 1 + Rand(5)
--		GetLocatorByName("Destination","Stroll"..LocIndex,"MovePos")
--		SetAvoidanceRange("",15)
--		success = f_MoveToNoWait("", "MovePos",GL_MOVESPEED_WALK,300)
--	end
	
	if not success then
		-- sim was unable to get to it's position, so the church is closed ?
		return
	end
	
	local WaitStep = Gametime2Realtime(0.25)
	local	Attr		= GetImpactValue("Destination", "Attractivity")	-- 0 - 0.75
	local Money		= math.floor(1.5*(7+(1+Attr*10)*SimGetRank(""))) 
	SetData("MessMoney",Money)
	local Transfered
	local HouselTaken = false
	local HasKerzen = GetItemCount("", "Kerzen")
	SetData("Endtime",math.mod(GetGametime(),24)+2)
	BuildingGetOwner("Destination","Boss")
	
	
	local	Progress = 0.5 - 0.3*0.01*SimGetFaith("")
	
	while (math.mod(GetGametime(),24)<GetData("Endtime")) do

	
		Sleep(WaitStep)

		if not HouselTaken then
			if GetItemCount("Destination", "Housel", INVENTORY_SELL)>0 then
				Transfer(nil, nil, INVENTORY_STD, "Destination", INVENTORY_SELL, "Housel", 1)
				SatisfyNeed("", 4, -0.25)
				HouselTaken = true
			end
		end
		
	-- Fajeth Mod
	if HasKerzen>0 then
		RemoveItems("", "Kerzen", 1)
		
		if (SimGetReligion("")==0) then
				chr_SimModifyFaith("",1,0)
			else
				chr_SimModifyFaith("",1,1)
			end
				Sleep(0.5)
				chr_GainXP("",20)
	end
	-- Mod end

		SatisfyNeed("", 4, Progress)
		if GetDynastyID("Destination") ~= GetDynastyID("") then
			CreditMoney("Destination", Money, "Offering")
		end
		if GetImpactValue("Destination","MassInProgress")~=1 then
			break
		end
		
		if Rand(20) == 1 then
			MsgSayNoWait("","@L_CHURCH_091_PREPAREWORSHIP_WORSHIPPING_COMMENT")
		end
		Sleep(10)
	end
	
	if GetDynastyID("Destination") ~= GetDynastyID("") then
			if GetImpactValue("Destination","gargoyle") == 1 then
				chr_ModifyFavor("","Boss",5)
			end
	end
	ms_attendmass_AffectFaith()
end

function CleanUp()
	SetAvoidanceRange("",-1)
	AddImpact("","WasInChurch",1,4)
	if SimIsInside("") and IsGUIDriven() then
		SetState("", STATE_EXPEL, true)
	end
end

function AffectFaith()
	-- eigener Glauben steigt
	SimSetFaith("",SimGetFaith("")+5)
	local MyFaith = SimGetFaith("")
	
	if(SpendMoney("",GetData("MessMoney"),"MessMoney")) then
		-- gunst steigt bei allen Dynastien deren Anf�hrer die gleiche Religion hat 
		GetDynasty("", "dynasty")
		local iCount = ScenarioGetObjects("Dynasty", 99, "Dynasties")
		
		if iCount==0 then
			return
		end
	
		for dyn=0, iCount-1 do
			Alias = "Dynasties"..dyn
			if not (GetID(Alias)==GetID("dynasty")) then
				if DynastyGetMember(Alias,0,"char") then
					if SimGetReligion("")==SimGetReligion("char") then
						ModifyFavorToDynasty("",Alias,MyFaith*SimGetFaith("char")/1000) -- 0..10
					end
				end
			end
		end	
		
		-- gunst steigt bei anwesenden dynastielosen sims gleichen glaubens
		if GetInsideBuilding("","church") then
			BuildingGetInsideSimList("church","sim_list")
			for i=0,ListSize("sim_list")-1 do
				ListGetElement("sim_list",i,"sim")
				if GetDynastyID("sim")<1 and SimGetReligion("")==SimGetReligion("sim") then
					chr_ModifyFavor("","sim",MyFaith*SimGetFaith("sim")/1000)	-- 0..10
				end
			end
		end
	end
end
