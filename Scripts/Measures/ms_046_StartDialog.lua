-------------------------------------------------------------------------------
----
----	OVERVIEW "ms_046_StartDialog"
----
----	with this measure the player can start a dialog with another sim
----
-------------------------------------------------------------------------------

-- -----------------------
-- Run
-- -----------------------

function Run()
	
	-- Fajeth_timeout fix
	local MeasureID = GetCurrentMeasureID("")
	local TimeOut = mdata_GetTimeOut(MeasureID)
	
	-- the action number for the courting

	local CourtingActionNumber = 0

	-- case for talk need

	if not(AliasExists("Destination")) then
		StopMeasure()
	end

	if not ai_StartInteraction("", "Destination", 350, 100) then
		StopMeasure()
		return
	end

	-- Only a player should be able to start a quests
	if IsGUIDriven() and DynastyIsPlayer("") then
		if (QuestTalk("","Destination")) then
			StopMeasure()
			return
		end
	elseif GetState("Destination", STATE_NPC) then
		StopMeasure()
		return
	end


	local owntitle = GetNobilityTitle("")
	local desttile = GetNobilityTitle("Destination")
    local TitleDiffMod = owntitle - 1
    local Age = SimGetAge("Destination")

    SetProperty("Owner","InTalk",1)
	SetProperty("Destination","InTalk",1)


	local Favor = GetFavorToSim("Destination", "")

    if SimGetGender("Destination")==GL_GENDER_MALE then

	if Age < 17 then
	MsgSay("","@L_STARTDIALOG_START_YOUNG_MALE")
	else
	MsgSay("","@L_STARTDIALOG_START_ADULT_MALE")
	end

	else

	if Age < 17 then
	MsgSay("","@L_STARTDIALOG_START_YOUNG_FEMALE")
	else
	MsgSay("","@L_STARTDIALOG_START_ADULT_FEMALE")
	end
	end

	-- Niemand will etwas mit dem Char zu tun haben

    if (GetFavorToSim("Destination", "") < 25) or ((owntitle + 1 < desttile) and GetFavorToSim("Destination", "") < 65) then
		-- prevent cheating timeout moved by Fajeth
		SetMeasureRepeat(TimeOut)

		MsgSay("Destination","@L_STARTDIALOG_NO")

		local favormodify = (Rand(5) + desttile)

		chr_ModifyFavor("Destination","",-favormodify)
		Sleep(0.4)


		MsgSay("","@L_STARTDIALOG_SORRY")


        StopMeasure()
	end

	SetAvoidanceGroup("", "Destination")
	feedback_OverheadActionName("Owner")
	feedback_OverheadActionName("Destination")
	AlignTo("Owner", "Destination")
	AlignTo("Destination", "Owner")
	Sleep(1)

	if SimGetGender("")==GL_GENDER_MALE then
		if(Favor >= 65) then
			PlaySound3DVariation("", "CharacterFX/male_friendly", 0.5)
		else
			PlaySound3DVariation("", "CharacterFX/male_neutral", 0.5)
		end
	else
		if(Favor >= 65)	then
			PlaySound3DVariation("", "CharacterFX/female_friendly",0.5)
		else
			PlaySound3DVariation("", "CharacterFX/female_neutral", 0.5)
		end
	end
	 if SimGetGender("Destination")==GL_GENDER_MALE then
  		if(Favor >= 65) then
			PlaySound3DVariation("Destination", "CharacterFX/male_friendly", 0.5)
		else
			PlaySound3DVariation("Destination", "CharacterFX/male_neutral", 0.5)
		end
	else
  		if(Favor >= 65)	then
			PlaySound3DVariation("Destination", "CharacterFX/female_friendly",0.5)
		else
			PlaySound3DVariation("Destination", "CharacterFX/female_neutral", 0.5)
		end
	end

	time1 = PlayAnimationNoWait("Owner", "talk")
	Sleep(0.7)
	time2 = PlayAnimationNoWait("Destination", "talk")
	time1 = math.max(time1, time2)
	Sleep(time1)


	if(Favor >= 65) then
		Talk("", "Destination",true)
	end

	-------------------------
	------ Court Lover ------
	-------------------------

	if SimGetCourtLover("", "CourtLover") then
		if GetID("CourtLover")==GetID("Destination") then

			MoveSetActivity("", "converse")
			MoveSetActivity("Destination", "converse")

			camera_CutscenePlayerLock("cutscene", "Destination")

			EnoughVariation, CourtingProgress = SimDoCourtingAction("", CourtingActionNumber)
			if (EnoughVariation == false) then
				-- prevent cheating timeout moved by Fajeth
		SetMeasureRepeat(TimeOut)
				feedback_OverheadCourtProgress("Destination", CourtingProgress)
				MsgSay("Destination", chr_AnswerMissingVariation(SimGetGender("Destination"), GetSkillValue("Destination", RHETORIC)));
			else
				-- prevent cheating timeout moved by Fajeth
		SetMeasureRepeat(TimeOut)
				feedback_OverheadCourtProgress("Destination", CourtingProgress)
				MsgSay("Destination", chr_AnswerCourtingMeasure("TALK", GetSkillValue("Destination", RHETORIC), SimGetGender("Destination"), CourtingProgress));
			end

			Sleep(3.0)


			-- Add the archieved progress
			SimAddCourtingProgress("")
		end

	StopMeasure()
	end

	if (TitleDiffMod < 0) then
		TitleDiffMod = 0
	end

    -- Postiv, Gunst steigt

	if ((GetSkillValue("", RHETORIC)) + TitleDiffMod >= (GetSkillValue("Destination", RHETORIC) + desttile)) then
		local favormodify = ((GetSkillValue("", RHETORIC) / 10) * 15)
		SetMeasureRepeat(TimeOut)
		chr_ModifyFavor("Destination","",favormodify)



        	if Age < 16 then
        	MsgSay("Destination", "@L_STARTDIALOG_FAVOR_POS_YOUNG")
			else
			MsgSay("Destination","@L_STARTDIALOG_FAVOR_POS_ADULT")
			end




	-- Zufällige Person aus der Umgebung auswählen

		local NumOfObjects = Find("","__F((Object.GetObjectsByRadius(Sim)==5000)AND(Object.IsDynastySim())","Sims",-1)

		if NumOfObjects > 0 then
		local DestAlias = "Sims"..Rand(NumOfObjects)
		local Check = true

			if IsDynastySim(DestAlias) and DynastyIsPlayer(DestAlias) then
				Check = false
			end

			if GetState("DestAlias", STATE_NPC) then
		     	Check = false
		    end

		    if GetState("DestAlias", STATE_DEAD) then
		     	Check = false
		    end

			if HasProperty(DestAlias,"QuestActive") then
				Check = false
			end

	-- Gesprächspartner mag die zufällige Person nicht und übergibt einen (gefälschten!) Beweis

			if Check then

				if GetFavorToSim("Destination", DestAlias) < 40
				or GetFavorToSim("", DestAlias) < 25
				or (GetFavorToSim("Destination", "") > 85 and Rand(100) > 80)
				or (GetFavorToSim("Destination", "") > 80 and SimGetProfession("Destination") == 18 and Rand(100) > 55)

				then


				MsgSay("Destination", "@L_STARTDIALOG_EVIDENCE")



				local Random = Rand(11)
				if Random == 0 then
				Evidence = 1
				elseif Random == 1 then
				Evidence = 4
				elseif Random == 2 then
				Evidence = 7
				elseif Random == 3 then
				Evidence = 10
				elseif Random == 4 then
				Evidence = 11
				elseif Random == 5 then
				Evidence = 12
				elseif Random == 6 then
				Evidence = 13
				elseif Random == 7 then
				Evidence = 14
				elseif Random == 8 then
				Evidence = 15
    			else
				Evidence = 18
				end

				-- zufällige Dynastie auswählen
				while true do
				ScenarioGetRandomObject("cl_Sim","CurrentRandomSim")
				if not GetDynasty("CurrentRandomSim","CDynasty") then
				CopyAlias("CurrentRandomSim","EvidenceVictim")
				break
				end
				end

				if Rand(100) > 50 then
				-- KI-/Schattendynastei ist das Opfer
				AddEvidence("", DestAlias, "EvidenceVictim", Evidence)
				else
				-- Spieler ist das Opfer
				AddEvidence("", DestAlias, "", Evidence)
				end

                MsgSay("", "@L_STARTDIALOG_THX")



			end
		end
	end

	else

	  -- Negativ, Gunst sinkt

		if Rand(100)>((GetSkillValue("", RHETORIC) * 10)) then
			local favormodify = (Rand(2) + desttile)
			SetMeasureRepeat(TimeOut)
			chr_ModifyFavor("Destination","",-favormodify)



			if Age < 16 then
        	MsgSay("Destination", "@L_STARTDIALOG_FAVOR_NEG_YOUNG")
			else
 			MsgSay("Destination","@L_STARTDIALOG_FAVOR_NEG_ADULT")
			end

    end
	end

	SatisfyNeed("", 3, 1.0)
	SatisfyNeed("Destination", 3, 1.0)
	-- SetMeasureRepeat(TimeOut)
	StopMeasure()
end

-- -----------------------
-- CleanUp
-- -----------------------
function CleanUp()
	ReleaseAvoidanceGroup("")
	if(AliasExists("Destination")) then
		RemoveProperty("Destination","InTalk")
	end
	RemoveProperty("", "InTalk")
	-- mod by Fajeth
	RemoveImpact("","Blocked")

end

function GetOSHData(MeasureID)
	--can be used again in:
	OSHSetMeasureRepeat("@L_ONSCREENHELP_7_MEASURES_TIMEINFOS_+2",Gametime2Total(mdata_GetTimeOut(MeasureID)))
end
