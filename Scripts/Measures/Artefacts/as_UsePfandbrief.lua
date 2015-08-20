-------------------------------------------------------------------------------
----
----	OVERVIEW "as_UsePfandbrief.lua"
----
-------------------------------------------------------------------------------

function Run()

	local Item = "Pfandbrief"
	local Object
	local Zufall = Rand(25)+1
	local ObjectLabel = ItemGetLabel(Item, true)
	local choice

	if AiDriven then
		choice = 0
	else
		choice = MsgBox("", "", "@P@B[0,@LJa_+0]"..
							"@B[1,@LNein_+0]",
							"@L_USE_PFANDBRIEF_HEAD_+0",
							"@L_USE_PFANDBRIEF_BODY_+0",
							ObjectLabel, GetID(""))
	end

	if Zufall ==1 then
		Object = "Shortsword"
	elseif Zufall ==2 then
		Object = "GemRing"
	elseif Zufall ==3 then
		Object = "BeltOfMetaphysic"
	elseif Zufall ==4 then
		Object = "GoldChain"
	elseif Zufall ==5 then
		Object = "Longsword"
	elseif Zufall ==6 then
		Object = "Chainmail"
	elseif Zufall ==7 then
		Object = "Platemail"
	elseif Zufall ==8 then
		Object = "CrossOfProtection"
	elseif Zufall ==9 then
		Object = "RubinStaff"
	elseif Zufall ==10 then
		Object = "Axe"
	elseif Zufall == 11 then
		Object = "CamouflageCloak"
	elseif Zufall == 12 then
		Object = "GlovesOfDexterity"
	elseif Zufall == 13 then
		Object = "DrFaustusElixir"
	elseif Zufall == 14 then
		Object = "FragranceOfHoliness"
	elseif Zufall == 15 then
		Object = "AboutTalents1"
	elseif Zufall == 16 then
		Object = "AboutTalents2"
	elseif Zufall == 17 then
		Object = "Gemstone"
	elseif Zufall == 18 then
		Object = "Amber"
	elseif Zufall == 19 then
		Object = "Porcelain"
	elseif Zufall == 20 then
		Object = "Spicery"
	elseif Zufall == 21 then
		Object = "Silk"
	elseif Zufall == 22 then
		Object = "Handwerksurkunde"
	elseif Zufall == 23 then
		Object = "statue"
	elseif Zufall == 24 then
		Object = "Empfehlung"
	else
		Object = "Bible"
	end
	
	if choice == 0 then
		RemoveItems("",Item,1)
		if GetRemainingInventorySpace("",Object) < 1 then
			MsgQuick("", "@L_UNPACK_RAWMATERIAL_FAILURE_+0", ObjectLabel)
			AddItems("",Item,1)
			StopMeasure()
		else
			AddItems("",Object,1)
		end
	end
end


function CleanUp()
end
