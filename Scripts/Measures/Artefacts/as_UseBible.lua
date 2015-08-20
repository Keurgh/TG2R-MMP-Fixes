-------------------------------------------------------------------------------
----
----	OVERVIEW "as_UseBible"
----
----	with this artifact, the player can get some faith
----
----	author: Fajeth 
-------------------------------------------------------------------------------
function Run()

	if IsStateDriven() then
		local ItemName = "Bible"
		if GetItemCount("", ItemName, INVENTORY_STD)==0 then
			if not ai_BuyItem("", ItemName, 1, INVENTORY_STD) then
				return
			end
		end
	end
	
	local MeasureID = GetCurrentMeasureID("")
	local TimeOut = mdata_GetTimeOut(MeasureID)
	
	if SimGetReligion("")==0 then
	-- Error, wrong religion
	MsgQuick("","@L_MEASURE_UseBible_ERROR")
	StopMeasure()
	else
	
	--play anims, and show overhead text
	local Time = PlayAnimationNoWait("","use_book_standing") 
	Sleep(1)
	CarryObject("","Handheld_Device/ANIM_book.nif",false)
	PlaySound3D("","Locations/wear_clothes/wear_clothes+1.wav", 1.0)
	Sleep(Time-2)
	CarryObject("","",false)
	PlaySound3D("","Locations/wear_clothes/wear_clothes+1.wav", 1.0)
			
	--remove item, add impacts
	if RemoveItems("","Bible",1)>0 then
		--show particles
		GetPosition("Owner", "ParticleSpawnPos")
		StartSingleShotParticle("particles/sparkle_talents.nif", "ParticleSpawnPos",1,5)
		PlaySound3D("","Effects/mystic_gift+0.wav", 1.0)
				
		SetMeasureRepeat(TimeOut)
		chr_SimModifyFaith("",10,1)
		Sleep(0.5)
		chr_GainXP("",GetData("BaseXP"))
	end
	StopMeasure()
	end

end

function CleanUp()
	StopAnimation("")
	CarryObject("","",false)
end

function GetOSHData(MeasureID)
	--can be used again in:
	OSHSetMeasureRepeat("@L_ONSCREENHELP_7_MEASURES_TIMEINFOS_+2",Gametime2Total(mdata_GetTimeOut(MeasureID)))
end

