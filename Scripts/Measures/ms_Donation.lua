-- Raise your favor by making a donation to the poor people.

function Init()

local Money = GetMoney("")
local rank = GetNobilityTitle("")
local alignment = SimGetAlignment("")

if rank <3 then
	MsgQuick("","@L_MEASURES_DONATION_FAIL_+0")
	StopMeasure()
end

local Titlemoney
if rank ==3 then
	Titlemoney = 5000
elseif rank ==4 then
	Titlemoney = 7500
elseif rank ==5 then 
	Titlemoney = 10000
elseif rank ==6 then
	Titlemoney = 15000
elseif rank ==7 then
	Titlemoney = 20000
elseif rank ==8 then
	Titlemoney = 30000
elseif rank ==9 then
	Titlemoney = 50000
else
	Titlemoney = 100000
end


if Money <Titlemoney then
	MsgQuick("","@L_MEASURES_DONATION_FAIL_+1")
	StopMeasure()
end
	
	local Choice1 = (0.10 * Money)*(1+(alignment/100))
	local Choice2 = (0.25 * Money)*(1+(alignment/100))
	local Choice3 = (0.50 * Money)*(1+(alignment/100))
	
	local Button1 = "@B[1,@L%1t,@L_MEASURES_DONATION_SCREENPLAY_ACTOR_CHOICE_+0,Hud/Buttons/btn_Money_Small.tga]"
	local Button2 = "@B[2,@L%2t,@L_MEASURES_DONATION_SCREENPLAY_ACTOR_CHOICE_+1,Hud/Buttons/btn_Money_Medium.tga]"
	local Button3 = "@B[3,@L%3t,@L_MEASURES_DONATION_SCREENPLAY_ACTOR_CHOICE_+2,Hud/Buttons/btn_Money_Large.tga]"

	MsgMeasure("","")
	local result = InitData("@P"..
	Button1..
	Button2..
	Button3,
	ms_donation_InitDonation,
	"@L_MEASURES_DONATION_HEAD_+0","@L_MEASURES_DONATION_BODY_+0",Choice1,Choice2,Choice3)
	
	if result==1 then
		SetData("DMoney", Choice1)
		SetData("DFavor", 2)
	elseif result==2 then
		SetData("DMoney", Choice2)
		SetData("DFavor", 4)
	elseif result==3 then
		SetData("DMoney", Choice3)
		SetData("DFavor", 8)
	end

end

function InitDonation()
	return "1"
end

function Run()

	local MeasureID = GetCurrentMeasureID("")
	local TimeOut	= mdata_GetTimeOut(MeasureID)

	if not HasData("DMoney") then
		StopMeasure()
	end

	local Donation = 0 + GetData("DMoney")

	if GetMoney("") < Donation then
		MsgQuick("","@L_MEASURES_DONATION_FAIL_+1")
		return
	end	
	
	if(SpendMoney("",Donation,"misc")) then
	
		local ModifyFavor = 0 + GetData("DFavor")
		
		MeasureSetNotRestartable()
--		SetMeasureRepeat(TimeOut)

		GetDynasty("", "dynasty")
		local iCount = ScenarioGetObjects("Dynasty", 99, "Dynasties")
		
		if iCount==0 then
			return
		end
	
		for dyn=0, iCount-1 do
			Alias = "Dynasties"..dyn
			if not (GetID(Alias)==GetID("dynasty")) then
				if GetFavorToDynasty("dynasty",Alias)>20 and GetFavorToDynasty("dynasty",Alias)<75 then
					ModifyFavorToDynasty("dynasty",Alias,ModifyFavor)
				end
			end
		end
	
	MsgNewsNoWait("","","","default",-1,
	"@L_MEASURES_Donation_MSG_HEAD_+0",
	"@L_MEASURES_Donation_MSG_BODY_+0",Donation)
	
	chr_GainXP("",GetData("BaseXP"))
	end

end

function CleanUp()
	StopMeasure()
end
	
function GetOSHData(MeasureID)
	--can be used again in:
	OSHSetMeasureRepeat("@L_ONSCREENHELP_7_MEASURES_TIMEINFOS_+2",Gametime2Total(mdata_GetTimeOut(MeasureID)))
end