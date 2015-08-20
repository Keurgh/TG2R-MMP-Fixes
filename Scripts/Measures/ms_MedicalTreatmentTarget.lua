-------------------------------------------------------------------------------
----
----	OVERVIEW "ms_MedicalTreatmentTarget"
----
----	EN: with this measure, the player can assign a doctor (party member or employee) to treat a specific sick sim in hospital
----	 // DE: mit dieser Maßnahme kann der Spieler einen Doktor (Gruppenmitglied oder Angestellter) anweisen, eine bestimmte Person im Hospital zu behandeln
----
----	>> unofficial mod by Manc (yet unexperienced in modding, suggestions welcome)
----
----	Instructions // Anleitung:
----
----	save this code as a new file "ms_MedicalTreatmentTarget.lua" in the directory "Scripts/Measures"
----	 // diesen Code in einer neuen Datei "ms_MedicalTreatmentTarget.lua" im Verzeichnis "Scripts/Measures" speichern
----
----	requires a new line in DB/Measures.dbt // erfordert eine neue Zeile in DB/Measures.dbt :
----	12094   "ms_MedicalTreatmentTarget.lua"   ""   "MedicalTreatmentTarget"   41   "hud/buttons/btn_MedicalTreatment.tga"   0   5   0   ""   ""   39   1   0   "none"   0   0   |
----	where 12094 is only valid for a yet unmodified patch 4.15 installtion (replace by a free ID if necessary)
----	 // wobei 12094 nur bei einer noch unmodifizierten patch 4.15-installation gültig ist (ggf. durch eine freie ID ersetzen)
----
----	requires two new lines in DB/MeasureToObjects.dbt // erfordert zwei neue Zeilen in DB/MeasureToObjects.dbt :
----	2393   12094   0   0   406   1   "hud/cursors/Cursor_Attack.tga"   (1 6)   "MEASUREINIT_SELECTION"   0   0   |
----	2394   12094   0   0   407   6   "hud/cursors/Cursor_Attack.tga"   (1 6)   "MEASUREINIT_SELECTION"   0   0   |
----	where 12094 is the ID from above and 2393 / 2394 must be new free IDs as well
----	 // wobei 12094 die ID von oben ist und 2393 / 2394 ebenfalls neue freie IDs sein müssen
----
----	the icon of this new measure equals the icon of the measure "Medical Treatment"
----	 // das Symbol der Maßnahme gleicht dem Symbol der Maßnahme "Medizinische Behandlung durchführen"
----
----	the measure description when hovering over the icon in the game isn't covered and displays as something like "MedicalTreatmentTarget_NAME" (would need a new entry in DB/Text.dbt)
----	 // die Beschreibung der Maßnahme, wenn man im Spiel den Mauszeiger über das Icon hält ist nicht berücksichtigt und wird mit "MedicalTreatmentTarget_NAME" oder ähnlich angezeigt (würde einen neuen Eintrag in DB/Text.dbt erfordern)
----
-------------------------------------------------------------------------------

function Run()
	if not AliasExists("Destination") then
		return
	end

	if not ai_GetWorkBuilding("", GL_BUILDING_TYPE_HOSPITAL, "Hospital") then
		StopMeasure()
		return
	end
	
	if GetInsideBuildingID("") ~= GetID("Hospital") then
		StopMeasure()
		return
	end
	
	if not GetInsideBuilding("Destination","Place") then
		StopMeasure()
	end

	-- The distance between both sims to interact with each other
	local InteractionDistance=90

	if not ai_StartInteraction("", "Destination", 500, InteractionDistance) then
		StopMeasure()
		return
	end

	MsgSay("Destination","@L_MEDICUS_TREATMENT_PATIENT")
	MsgSay("","@L_MEDICUS_TREATMENT_DOC_INTRO")
	PlayAnimation("","manipulate_middle_twohand")

			local Costs = 50
			local Cured = false
			
			--SPRAIN
			if GetImpactValue("Destination","Sprain")==1 then
				Costs = diseases_GetTreatmentCost("Sprain")
				if RemoveItems("Hospital","Bandage",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Bandage",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_SPRAIN")
						diseases_Sprain("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif GetImpactValue("Destination","Cold")==1 then
				Costs = diseases_GetTreatmentCost("Cold")
				if RemoveItems("Hospital","Bandage",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Bandage",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_COLD")
						diseases_Cold("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif GetImpactValue("Destination","Influenza")==1 then
				Costs = diseases_GetTreatmentCost("Influenza")
				if RemoveItems("Hospital","Medicine",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Medicine",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_INFLUENZA")
						diseases_Influenza("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif GetImpactValue("Destination","BurnWound")==1 then
				Costs = diseases_GetTreatmentCost("BurnWound")
				if RemoveItems("Hospital","Medicine",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Medicine",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_BURNWOUND")
						diseases_BurnWound("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif GetImpactValue("Destination","Pox")==1 then
				Costs = diseases_GetTreatmentCost("Pox")
				if RemoveItems("Hospital","Medicine",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Medicine",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_POX")
						diseases_Pox("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif GetImpactValue("Destination","Pneumonia")==1 then
				Costs = diseases_GetTreatmentCost("Pneumonia")
				if RemoveItems("Hospital","PainKiller",1,INVENTORY_STD)>0 or RemoveItems("Hospital","PainKiller",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_PNEUMONIA")
						diseases_Pneumonia("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif GetImpactValue("Destination","Blackdeath")==1 then
				Costs = diseases_GetTreatmentCost("Blackdeath")
				if RemoveItems("Hospital","PainKiller",1,INVENTORY_STD)>0 or RemoveItems("Hospital","PainKiller",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_BLACKDEATH")
						diseases_Blackdeath("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif GetImpactValue("Destination","Fracture")==1 then
				Costs = diseases_GetTreatmentCost("Fracture")
				if RemoveItems("Hospital","PainKiller",1,INVENTORY_STD)>0 or RemoveItems("Hospital","PainKiller",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_FRACTURE")
						diseases_Fracture("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif GetImpactValue("Destination","Caries")==1 then
				Costs = diseases_GetTreatmentCost("Caries")
				if RemoveItems("Hospital","PainKiller",1,INVENTORY_STD)>0 or RemoveItems("Hospital","PainKiller",1,INVENTORY_SELL)>0 then
					if IsPartyMember("Destination")==false or SpendMoney("Destination",Costs,"Offering") then
						CreditMoney("Hospital",Costs,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_CARIES")
						diseases_Caries("Destination",false)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			elseif (GetHP("Destination") < GetMaxHP("Destination")) then
				if RemoveItems("Hospital","Bandage",1,INVENTORY_STD)>0 or RemoveItems("Hospital","Bandage",1,INVENTORY_SELL)>0 then
					local ToHeal = GetMaxHP("Destination") - GetHP("Destination")
					if IsPartyMember("Destination")==false or SpendMoney("Destination",ToHeal,"Offering") then
						CreditMoney("Hospital",ToHeal,"Offering")
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_HPLOSS")
						ModifyHP("Destination",ToHeal,true)
						--favor mod by Fajeth
								chr_ModifyFavor("Destination","",5)
						Cured = true
					else
						MsgSay("","@L_MEDICUS_TREATMENT_DOC_NOMONEY")
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
			end

			if not Cured then
			 	-- search for another hospital
			 	SetProperty("Destination", "IgnoreHospital", GetID("Hospital"))
			 	SetProperty("Destination", "IgnoreHospitalTime", GetGametime()+12)
			else
			
			MoveSetActivity("Destination","")
			AddImpact("Destination","Resist",1,4) -- def 6
				-- Fajeth Mod: Try to sell soap
				if GetItemCount("Hospital","Soap",INVENTORY_SELL)>0 and GetMoney("Destination")>200 then
					MsgSay("","@L_MEDICUS_TREATMENT_DOC_BUYSOAP")
					local Skill = GetSkillValue("",7) -- Rhetoric
					local RandomFactor1 = Rand(3)
					local RandomFactor2 = Rand(3)
					local SkillPatient = GetSkillValue("Destination",8) -- Empathy
					
					if (Skill+RandomFactor1)>=(SkillPatient+RandomFactor2) then
						RemoveItems("Hospital","Soap",1, INVENTORY_STD)
						CreditMoney("Hospital",200,"misc")
						AddImpact("SickSim0","Resist",1,6)
						AddImpact("SickSim0","Soap",1,6)
						PlayAnimationNoWait("Destination","nod")
						MsgSay("Destination","@L_MEDICUS_TREATMENT_PATIENT_BUYSOAP")
					else
						PlayAnimationNoWait("Destination","shake_head")
						MsgSay("Destination","@L_MEDICUS_TREATMENT_PATIENT_NOSOAP")
					end
				end
				
				if HasProperty("Destination","WaitingForTreatment") then
					RemoveProperty("Destination","WaitingForTreatment")
				end
				f_ExitCurrentBuilding("Destination")
				if DynastyIsAI("Destination") then
					SimSetBehavior("Destination","idle")
				end	
			end
end

function CleanUp()

end