-------------------------------------------------------------------------------
----
----	OVERVIEW "ms_MedicalTreatment"
----
----	with this measure, the player can assign a sim to treat sick sims in hospital
----
-------------------------------------------------------------------------------
function Run()

	if not ai_GetWorkBuilding("", GL_BUILDING_TYPE_HOSPITAL, "Hospital") then
		StopMeasure()
		return
	end
	
	if GetInsideBuildingID("") ~= GetID("Hospital") then
		if not f_MoveTo("", "Hospital", GL_MOVESPEED_RUN) then
			StopMeasure()
		end
	end
	
	SetData("IsProductionMeasure", 0)
	SimSetProduceItemID("", -GetCurrentMeasureID(""), -1)
	SetData("IsProductionMeasure", 1)
	
	local BedFree = false
	local BedNumber = 0
	for i=1,5 do
		if LocatorStatus("Hospital","Bed"..i)==1 then
			BedNumber = i
			GetLocatorByName("Hospital","Treatment"..BedNumber,"TreatmentPos")
			if BlockLocator("","TreatmentPos") then
				BedFree = true
				break
			end
		end
	end
	
	if not BedFree then
		StopMeasure()
	end
	
	while true do
		local SickSimFilter = "__F((Object.GetObjectsByRadius(Sim) == 10000) AND (Object.Property.WaitingForTreatment==1))"
		local NumSickSims = Find("", SickSimFilter,"SickSim", -1)
		if NumSickSims <= 0 then
			if BuildingGetAISetting("Hospital", "BuySell_Selection")>=0 then
				StopMeasure()
			end
			
			SetProperty("","Bored",1)
				-- Fajeth Mod_Bored Docs getting friends
			if Rand(100)>74 then
			-- Mod end
				local BoredDocFilter = "__F((Object.GetObjectsByRadius(Sim) == 5000) AND (Object.Property.Bored==1))"
				local NumBoredDocs = Find("", BoredDocFilter,"BoredDoc", -1)
				if NumBoredDocs > 0 then
					f_MoveTo("","BoredDoc",GL_MOVESPEED_WALK,100)
					AlignTo("","BoredDoc")
					AlignTo("BoredDoc","")
					Sleep(1.5)
					local AnimTime = PlayAnimationNoWait("","talk")
					if SimGetGender("")==GL_GENDER_MALE then
						PlaySound3DVariation("","CharacterFX/male_neutral",1)
					else
						PlaySound3DVariation("","CharacterFX/female_neutral",1)
					end
					Sleep(3)
				-- Fajeth Mod_Bored Docs getting friends
					if Rand(100)>34 then
						PlayAnimationNoWait("BoredDoc","nod")
						chr_ModifyFavor("BoredDoc","",3)
					else
						PlayAnimationNoWait("BoredDoc","shake_head")
						chr_ModifyFavor("BoredDoc","",-1)
					end
					-- Mod end
					Sleep(AnimTime-3)
				end
			else
				MoveStop("")
				PlayAnimation("","cogitate")
			end
		else
			if HasProperty("","Bored") then
				RemoveProperty("","Bored")
			end
			SetData("Blocked", 0)
			if not SendCommandNoWait("SickSim0", "BlockMe") then
				break
			end
			
			--all beds full
	--		if BedNumber == 0 then
	--			return	
	--		end
			
			GetLocatorByName("Hospital","Treatment"..BedNumber,"TreatmentPos")
			if not f_BeginUseLocator("","TreatmentPos",GL_STANCE_STAND,true) then
				return
			end
			Sleep(1)
			if not f_MoveTo("SickSim0","Owner",GL_MOVESPEED_WALK,128) then
				return
			end
			AlignTo("SickSim0","")
			AlignTo("","SickSim0")
			Sleep(2)
			StopAllAnimations("")
			MoveStop("")
			MeasureSetNotRestartable()
			
			
			MsgSay("SickSim0","@L_MEDICUS_TREATMENT_PATIENT")
			MsgSay("","@L_MEDICUS_TREATMENT_DOC_INTRO")
			PlayAnimation("","manipulate_middle_twohand")
			local Costs = 50
			local Cured = false
			
			--SPRAIN
			if GetImpactValue("SickSim0","Sprain")==1 then
				Costs = diseases_GetTreatmentCost("Sprain")
				if RemoveItems("Hospital","Bandage",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Bandage",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_SPRAIN")
						diseases_Sprain("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","Bandage",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("Bandage",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("Bandage",false))
					end
				end
			
			--COLD	
			elseif GetImpactValue("SickSim0","Cold")==1 then
				Costs = diseases_GetTreatmentCost("Cold")
				if RemoveItems("Hospital","Bandage",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Bandage",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_COLD")
						diseases_Cold("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","Bandage",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("Bandage",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("Bandage",false))
					end
				end
				
			--INFLUENZA
			elseif GetImpactValue("SickSim0","Influenza")==1 then
				Costs = diseases_GetTreatmentCost("Influenza")
				if RemoveItems("Hospital","Medicine",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Medicine",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_INFLUENZA")
						diseases_Influenza("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","Medicine",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("Medicine",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("Medicine",false))
					end
				end
				
			--BURNWOUND	
			elseif GetImpactValue("SickSim0","BurnWound")==1 then
				Costs = diseases_GetTreatmentCost("BurnWound")
				if RemoveItems("Hospital","Medicine",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Medicine",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						ms_medicaltreatment_LayToBed("","SickSim0",BedNumber)
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_BURNWOUND")
						diseases_BurnWound("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						RemoveData("LayStill")
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","Medicine",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("Medicine",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("Medicine",false))
					end
				end
				
			--POX	
			elseif GetImpactValue("SickSim0","Pox")==1 then
				Costs = diseases_GetTreatmentCost("Pox")
				if RemoveItems("Hospital","Medicine",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Medicine",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_POX")
						diseases_Pox("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","Medicine",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("Medicine",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("Medicine",false))
					end
				end	
			
			--PNEUMONA
			elseif GetImpactValue("SickSim0","Pneumonia")==1 then
				Costs = diseases_GetTreatmentCost("Pneumonia")
				if RemoveItems("Hospital","PainKiller",1,INVENTORY_STD)>0 or RemoveItems("Hospital","PainKiller",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_PNEUMONIA")
						diseases_Pneumonia("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","PainKiller",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("PainKiller",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("PainKiller",false))
					end
				end	
					
			--BLACKDEATH
			elseif GetImpactValue("SickSim0","Blackdeath")==1 then
				Costs = diseases_GetTreatmentCost("Blackdeath")
				if RemoveItems("Hospital","PainKiller",1,INVENTORY_STD)>0 or RemoveItems("Hospital","PainKiller",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						ms_medicaltreatment_LayToBed("","SickSim0",BedNumber)
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_BLACKDEATH")
						diseases_Blackdeath("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						RemoveData("LayStill")
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","PainKiller",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("PainKiller",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("PainKiller",false))
					end
				end
				
			--FRACTURE
			elseif GetImpactValue("SickSim0","Fracture")==1 then
				Costs = diseases_GetTreatmentCost("Fracture")
				if RemoveItems("Hospital","PainKiller",1,INVENTORY_STD)>0 or RemoveItems("Hospital","PainKiller",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						ms_medicaltreatment_LayToBed("","SickSim0",BedNumber)
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_FRACTURE")
						diseases_Fracture("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						RemoveData("LayStill")
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","PainKiller",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("PainKiller",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("PainKiller",false))
					end
				end	
					
			--CARIES					
			elseif GetImpactValue("SickSim0","Caries")==1 then
				Costs = diseases_GetTreatmentCost("Caries")
				if RemoveItems("Hospital","PainKiller",1,INVENTORY_STD)>0 or RemoveItems("Hospital","PainKiller",1,INVENTORY_SELL)>0 then
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_CARIES")
						diseases_Caries("SickSim0",false)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","PainKiller",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("PainKiller",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("PainKiller",false))
					end
				end
				
			--ELSE	(HP LOSS)
			elseif (GetHP("SickSim0") < GetMaxHP("SickSim0")) then
				if RemoveItems("Hospital","Bandage",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Bandage",1,INVENTORY_SELL)>0 then
					local ToHeal = GetMaxHP("SickSim0") - GetHP("SickSim0")
					if IsPartyMember("SickSim0")==false or SpendMoney("SickSim0",ToHeal,"Offering") then
						CreditMoney("Hospital",ToHeal,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_HPLOSS")
						ModifyHP("SickSim0",ToHeal,true)
						--favor mod by Fajeth
						chr_ModifyFavor("SickSim0","",5)
						-- Mod end
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
						AddItems("SickSim0","Bandage",1,INVENTORY_STD)
					end
				else
					--not enough mats
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMATS",ItemGetLabel("Bandage",false))
					if GetImpactValue("Hospital","hospitalmessagesent")==0 then
						AddImpact("Hospital","hospitalmessagesent",1,4)
						feedback_MessageWorkshop("Hospital","@L_MEDICUS_TREATMENT_MSG_NOMATS_HEAD_+0",
										"@L_MEDICUS_TREATMENT_MSG_NOMATS_BODY_+0",
										GetID("Hospital"),ItemGetLabel("Bandage",false))
					end
				end
			else
				MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOTHING")
				Cured = true
				if DynastyIsAI("SickSim0") then
					SimSetBehavior("SickSim0","idle")
				end
				RemoveProperty("SickSim0","WaitingForTreatment")
			end


			if not Cured then
			 	-- search for another hospital
			 	SetProperty("SickSim0", "IgnoreHospital", GetID("Hospital"))
			 	SetProperty("SickSim0", "IgnoreHospitalTime", GetGametime()+12)
			else
				MoveSetActivity("SickSim0","")
				AddImpact("SickSim0","Resist",1,4) -- def 6
				-- Fajeth Mod: Try to sell soap
				if GetItemCount("Hospital","Soap", INVENTORY_STD)>0 then
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_BUYSOAP")
					local Skill = GetSkillValue("",7) -- Rhetoric
					local RandomFactor1 = Rand(3)
					local RandomFactor2 = Rand(3)
					local SkillPatient = GetSkillValue("SickSim0",8) -- Empathy
					
					if (Skill+RandomFactor1)>=(SkillPatient+RandomFactor2) then
						RemoveItems("Hospital","Soap",1, INVENTORY_STD)
						CreditMoney("Hospital",200,"misc")
						AddImpact("SickSim0","Resist",1,6)
						AddImpact("SickSim0","Soap",1,6)
						Sleep(1)
						PlayAnimationNoWait("SickSim0","nod")
						MsgSay("SickSim0","@L_MEDICUS_TREATMENT_PATIENT_BUYSOAP")
					else
						Sleep(1)
						PlayAnimationNoWait("SickSim0","shake_head")
						MsgSay("SickSim0","@L_MEDICUS_TREATMENT_PATIENT_NOSOAP")
					end
				end
				if HasProperty("SickSim0","WaitingForTreatment") then
					RemoveProperty("SickSim0","WaitingForTreatment")
				end
			end
			SetData("Blocked", 1)
			Sleep(10)
		end
	end
end

function BlockMe()
	while GetData("Blocked")~=1 do
		Sleep(0.8)
	end
	if HasProperty("","WaitingForTreatment") then
		RemoveProperty("","WaitingForTreatment")
	end
	Sleep(3)
	f_ExitCurrentBuilding("")
	if DynastyIsAI("") then
		SimSetBehavior("","idle")
	end
end

function LayToBed(Doc,SickSim,BedNumber)
	GetLocatorByName("Hospital","Bed"..BedNumber,"BedPos")
	if not f_BeginUseLocator(SickSim,"BedPos",GL_STANCE_LAY,true) then
		return
	end
	
	if not f_BeginUseLocator(Doc,"TreatmentPos",GL_STANCE_STAND,true) then
		return
	end
	Sleep(1)
	SetData("LayStill",1)
	
	if not SendCommandNoWait(SickSim,"LayBack") then
		return
	end

	AlignTo(Doc,SickSim)
	Sleep(1)
	PlayAnimation(Doc,"treatpatientinbed_01")
	f_EndUseLocator(Doc,"TreatmentPos",GL_STANCE_STAND)
	f_EndUseLocator(SickSim,"BedPos",GL_STANCE_LAY)
	
end

function LayBack()
	PlayAnimation("","sickinbed_idle_in")
	while HasData("LayStill") do
		LoopAnimation("","sickinbed_idle_01",2)
	end
	PlayAnimation("","sickinbed_idle_out")
	f_EndUseLocator("","BedPos",GL_STANCE_STAND)
end

function CleanUp()
	RemoveData("LayStill")
	StopAnimation("")
	if HasProperty("","Bored") then
		RemoveProperty("","Bored")
	end
	if HasProperty("", "BigBrother") then
		RemoveProperty("","BigBrother")
	end
end

