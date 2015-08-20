-------------------------------------------------------------------------------
----
----	OVERVIEW "as_164_UseAboutTalents2"
----
----	with this artifact, the player can increase his craftsmanship skill by 2
----
-------------------------------------------------------------------------------

function Run()
	if (GetState("", STATE_CUTSCENE)) then
		as_164_useabouttalents2_Cutscene()
	else
		as_164_useabouttalents2_Normal()
	end
end

function Normal()

	if IsStateDriven() then
		local ItemName = "AboutTalents2"
		if GetItemCount("", ItemName, INVENTORY_STD)==0 then
			if not ai_BuyItem("", ItemName, 1, INVENTORY_STD) then
				return
			end
		end
	end
	 
	local MeasureID = GetCurrentMeasureID("")
	local duration = mdata_GetDuration(MeasureID)
	local TimeOut = mdata_GetTimeOut(MeasureID)
	
	local skillmodify = 2
		
	--take a book and read
	local Time = PlayAnimationNoWait("","use_book_standing") 
	Sleep(1)
	CarryObject("","Handheld_Device/ANIM_book.nif",false)
	PlaySound3D("","Locations/wear_clothes/wear_clothes+1.wav", 1.0)
	Sleep(Time-2)
	CarryObject("","",false)
	PlaySound3D("","Locations/wear_clothes/wear_clothes+1.wav", 1.0)
	
	--show particles
	if RemoveItems("","Abouttalents2",1) > 0 then
	if DynastyIsPlayer("") then
		GetPosition("Owner", "ParticleSpawnPos")
		StartSingleShotParticle("particles/sparkle_talents.nif", "ParticleSpawnPos",1,5)
		PlaySound3D("","Effects/mystic_gift+0.wav", 1.0)
		--show overhead text
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_rhetoric_ICON_+0", "@L_TALENTS_rhetoric_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_craftsmanship_ICON_+0", "@L_TALENTS_craftsmanship_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_dexterity_ICON_+0", "@L_TALENTS_dexterity_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_constitution_ICON_+0", "@L_TALENTS_constitution_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_charisma_ICON_+0", "@L_TALENTS_charisma_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_fighting_ICON_+0", "@L_TALENTS_fighting_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_empathy_ICON_+0", "@L_TALENTS_empathy_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_shadow_arts_ICON_+0", "@L_TALENTS_shadow_arts_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_bargaining_ICON_+0", "@L_TALENTS_bargaining_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_secret_knowledge_ICON_+0", "@L_TALENTS_secret_knowledge_NAME_+0", skillmodify)
	end
	--add the impacts and remove the artefact from inventory
	
		SetMeasureRepeat(duration)
		AddImpact("","abouttalents2",1,duration)
		AddImpact("","rhetoric",2,duration)
		AddImpact("","craftsmanship",2,duration)
		AddImpact("","charisma",2,duration)
		AddImpact("","constitution",2,duration)
		AddImpact("","dexterity",2,duration)
		AddImpact("","shadow_arts",2,duration)
		AddImpact("","fighting",2,duration)
		AddImpact("","secret_knowledge",2,duration)
		AddImpact("","bargaining",2,duration)
		AddImpact("","empathy",2,duration)
		AddImpact("","abouttalents1",2,duration)
		Sleep(1)
		chr_GainXP("",GetData("BaseXP"))
	end		
	
end

function Cutscene()
	 
	local MeasureID = GetCurrentMeasureID("")
	local duration = mdata_GetDuration(MeasureID)
	local TimeOut = mdata_GetTimeOut(MeasureID)
	
	local skillmodify = 2
		
	
	--show particles
	GetPosition("Owner", "ParticleSpawnPos")
	StartSingleShotParticle("particles/sparkle_talents.nif", "ParticleSpawnPos",1,5)
	
	--show overhead text
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_rhetoric_ICON_+0", "@L_TALENTS_rhetoric_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_craftsmanship_ICON_+0", "@L_TALENTS_craftsmanship_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_dexterity_ICON_+0", "@L_TALENTS_dexterity_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_constitution_ICON_+0", "@L_TALENTS_constitution_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_charisma_ICON_+0", "@L_TALENTS_charisma_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_fighting_ICON_+0", "@L_TALENTS_fighting_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_empathy_ICON_+0", "@L_TALENTS_empathy_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_shadow_arts_ICON_+0", "@L_TALENTS_shadow_arts_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_bargaining_ICON_+0", "@L_TALENTS_bargaining_NAME_+0", skillmodify)
			
		Sleep(1)
		
		feedback_OverheadSkill("", "@L_ARTEFACTS_OVERHEAD_+0", false,
			"@L_TALENTS_secret_knowledge_ICON_+0", "@L_TALENTS_secret_knowledge_NAME_+0", skillmodify)
	
	--add the impacts and remove the artefact from inventory
	
		SetMeasureRepeat(duration)
		AddImpact("","abouttalents2",1,duration)
		AddImpact("","rhetoric",2,duration)
		AddImpact("","craftsmanship",2,duration)
		AddImpact("","charisma",2,duration)
		AddImpact("","constitution",2,duration)
		AddImpact("","dexterity",2,duration)
		AddImpact("","shadow_arts",2,duration)
		AddImpact("","fighting",2,duration)
		AddImpact("","secret_knowledge",2,duration)
		AddImpact("","bargaining",2,duration)
		AddImpact("","empathy",2,duration)
		AddImpact("","abouttalents1",2,duration)
		Sleep(1)
		chr_GainXP("",GetData("BaseXP"))
	if SimGetCutscene("","cutscene") then
		CutsceneCallUnscheduled("cutscene", "UpdatePanel")
		Sleep(0.1)
	else
		return
	end						
	
end

function GetOSHData(MeasureID)
	--can be used again in:
	OSHSetMeasureRepeat("@L_ONSCREENHELP_7_MEASURES_TIMEINFOS_+2",Gametime2Total(mdata_GetTimeOut(MeasureID)))
	--active time:
	OSHSetMeasureRuntime("@L_ONSCREENHELP_7_MEASURES_TIMEINFOS_+0",Gametime2Total(mdata_GetDuration(MeasureID)))
end

