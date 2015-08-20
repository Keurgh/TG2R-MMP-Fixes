
function GameStart()

	if not GetSettlement("", "City") then
		return 0
	end
	
	if CityIsKontor("City") then
		return 0
	end
	
	local Level = CityGetLevel("City")
	-- Food (2)
	marketpinghour_CheckItem(Level, "WheatFlour", 1, 10)
	marketpinghour_CheckItem(Level, "CakeBatter", 1, 5)
	marketpinghour_CheckItem(Level, "Housel", 1, 2)
	marketpinghour_CheckItem(Level, "Cookie", 1, 2)
	marketpinghour_CheckItem(Level, "Wheatbread", 1, 2)
	marketpinghour_CheckItem(Level, "BreadRoll", 1, 2)
	marketpinghour_CheckItem(Level, "Wurst", 1, 2)
	marketpinghour_CheckItem(Level, "Cheese", 1, 2)
	marketpinghour_CheckItem(Level, "Cake", 1, 2)
	marketpinghour_CheckItem(Level, "CreamPie", 1, 2)
	marketpinghour_CheckItem(Level, "Candy", 1, 2)
	marketpinghour_CheckItem(Level, "GrainPap", 1, 2)
	marketpinghour_CheckItem(Level, "Salat", 1, 2)
	marketpinghour_CheckItem(Level, "Shellsoup", 1, 2)
	marketpinghour_CheckItem(Level, "FriedHerring", 1, 2)
	marketpinghour_CheckItem(Level, "SalmonFilet", 1, 2)
	marketpinghour_CheckItem(Level, "SmokedSalmon", 1, 2)
	marketpinghour_CheckItem(Level, "RoastBeef", 1, 2)
	marketpinghour_CheckItem(Level, "Alcohol", 1, 5)
	marketpinghour_CheckItem(Level, "Weingeist", 1, 5)
	marketpinghour_CheckItem(Level, "Oil", 1, 2)
	marketpinghour_CheckItem(Level, "Saft", 1, 2)
	marketpinghour_CheckItem(Level, "Milch", 1, 2)
	marketpinghour_CheckItem(Level, "HerbTea", 1, 2)
	marketpinghour_CheckItem(Level, "SmallBeer", 1, 2)
	marketpinghour_CheckItem(Level, "WheatBeer", 1, 2)
	marketpinghour_CheckItem(Level, "Wine", 1, 2)
	marketpinghour_CheckItem(Level, "Mead", 1, 1)
	marketpinghour_CheckItem(Level, "BoozyBreathBeer", 1, 1)
	-- Handcraft (3)
	marketpinghour_CheckItem(Level, "Cloth", 1, 10)
	marketpinghour_CheckItem(Level, "OakwoodRing", 1, 2)
	marketpinghour_CheckItem(Level, "Torch", 1, 2)
	marketpinghour_CheckItem(Level, "WalkingStick", 1, 2)
	marketpinghour_CheckItem(Level, "CrossOfProtection", 1, 1)
	marketpinghour_CheckItem(Level, "RubinStaff", 1, 1)
	marketpinghour_CheckItem(Level, "Schnitzi", 1, 2)
	marketpinghour_CheckItem(Level, "MoneyBag", 1, 2)
	marketpinghour_CheckItem(Level, "LeatherGloves", 1, 2)
	marketpinghour_CheckItem(Level, "Blanket", 1, 2)
	marketpinghour_CheckItem(Level, "FarmersClothes", 1, 2)
	marketpinghour_CheckItem(Level, "CitizensClothes", 1, 2)
	marketpinghour_CheckItem(Level, "NoblesClothes", 1, 2)
	marketpinghour_CheckItem(Level, "LeatherArmor", 1, 2)
	marketpinghour_CheckItem(Level, "GlovesOfDexterity", 1, 1)
	marketpinghour_CheckItem(Level, "CamouflageCloak", 1, 1)
	marketpinghour_CheckItem(Level, "vase", 1, 2)
	marketpinghour_CheckItem(Level, "Stonerotary", 1, 2)
	marketpinghour_CheckItem(Level, "Blissstone", 1, 1)
	marketpinghour_CheckItem(Level, "bust", 1, 2)	
	marketpinghour_CheckItem(Level, "statue", 1, 1)
	marketpinghour_CheckItem(Level, "Gargoyle", 1, 1)
	marketpinghour_CheckItem(Level, "Shellchain", 1, 2)
	marketpinghour_CheckItem(Level, "PearlChain", 1, 2)
	marketpinghour_CheckItem(Level, "Chaplet", 1, 2)
	marketpinghour_CheckItem(Level, "StaffOfAesculap", 1, 1)
	marketpinghour_CheckItem(Level, "flote", 1, 2)
	marketpinghour_CheckItem(Level, "Pendel", 1, 1)
	marketpinghour_CheckItem(Level, "Spindel", 1, 1)
	marketpinghour_CheckItem(Level, "Voodo", 1, 1)
	marketpinghour_CheckItem(Level, "Amulet", 1, 2)
	marketpinghour_CheckItem(Level, "Knochenarmreif", 1, 2)
	marketpinghour_CheckItem(Level, "Robe", 1, 2)
	marketpinghour_CheckItem(Level, "Pddv", 1, 1)
	marketpinghour_CheckItem(Level, "Kamm", 1, 2)
	-- Documents (4)
	marketpinghour_CheckItem(Level, "Parchment", 1, 10)
	marketpinghour_CheckItem(Level, "Pergament", 1, 10)
	marketpinghour_CheckItem(Level, "Ink", 1, 10)
	marketpinghour_CheckItem(Level, "Kerzen", 1, 2)
	marketpinghour_CheckItem(Level, "Poem", 1, 2)
	marketpinghour_CheckItem(Level, "LetterOfIndulgence", 1, 1)
	marketpinghour_CheckItem(Level, "LetterFromRome", 1, 1)
	marketpinghour_CheckItem(Level, "ThesisPaper", 1, 1)
	marketpinghour_CheckItem(Level, "AboutTalents1", 1, 2)
	marketpinghour_CheckItem(Level, "AboutTalents2", 1, 2)
	marketpinghour_CheckItem(Level, "Bible", 1, 1)
	marketpinghour_CheckItem(Level, "Siegel", 1, 10)
	marketpinghour_CheckItem(Level, "Pfandbrief", 1, 1)
	marketpinghour_CheckItem(Level, "Optieisen", 1, 2)
	marketpinghour_CheckItem(Level, "Optisilber", 1, 2)
	marketpinghour_CheckItem(Level, "Optigold", 1, 2)
	marketpinghour_CheckItem(Level, "Urkunde", 1, 1)
	marketpinghour_CheckItem(Level, "Schuldenbrief", 1, 2)
	marketpinghour_CheckItem(Level, "Empfehlung", 1, 1)
	marketpinghour_CheckItem(Level, "Handwerksurkunde", 1, 2)
	marketpinghour_CheckItem(Level, "HexerdokumentI", 1, 2)
	marketpinghour_CheckItem(Level, "HexerdokumentII", 1, 1)
	marketpinghour_CheckItem(Level, "Hasstirade", 1, 1)
	marketpinghour_CheckItem(Level, "TarotCards", 1, 1)
	-- Fragrance & Herb (5)
	marketpinghour_CheckItem(Level, "Lavender", 1, 2)
	marketpinghour_CheckItem(Level, "Moonflower", 1, 2)
	marketpinghour_CheckItem(Level, "Blackberry", 1, 2)
	marketpinghour_CheckItem(Level, "Stonelily", 1, 2)
	marketpinghour_CheckItem(Level, "Swamproot", 1, 10)
	marketpinghour_CheckItem(Level, "Kraut", 1, 2)
	marketpinghour_CheckItem(Level, "Perfume", 1, 2)
	marketpinghour_CheckItem(Level, "Phiole", 1, 2)
	marketpinghour_CheckItem(Level, "FlowerOfDiscord", 1, 1)
	marketpinghour_CheckItem(Level, "DartagnansFragrance", 1, 1)
	marketpinghour_CheckItem(Level, "FragranceOfHoliness", 1, 1)
	marketpinghour_CheckItem(Level, "DrFaustusElixir", 1, 1)
	marketpinghour_CheckItem(Level, "GhostlyFog", 1, 1)
	marketpinghour_CheckItem(Level, "StinkBomb", 1, 1)
	marketpinghour_CheckItem(Level, "Soap", 1, 2)
	marketpinghour_CheckItem(Level, "Bandage", 1, 2)
	marketpinghour_CheckItem(Level, "MiracleCure", 1, 2)
	marketpinghour_CheckItem(Level, "Salve", 1, 2)
	marketpinghour_CheckItem(Level, "Medicine", 1, 2)
	marketpinghour_CheckItem(Level, "Medipack", 1, 2)
	marketpinghour_CheckItem(Level, "PainKiller", 1, 2)
	marketpinghour_CheckItem(Level, "Mixture", 1, 2)
	marketpinghour_CheckItem(Level, "Antidote", 1, 2)
	marketpinghour_CheckItem(Level, "InvisiblePotion", 1, 2)
	marketpinghour_CheckItem(Level, "ToadExcrements", 1, 1)
	marketpinghour_CheckItem(Level, "ToadSlime", 1, 1)
	marketpinghour_CheckItem(Level, "WeaponPoison", 1, 1)
	marketpinghour_CheckItem(Level, "ParalysisPoison", 1, 1)
	marketpinghour_CheckItem(Level, "BlackWidowPoison", 1, 1)
	marketpinghour_CheckItem(Level, "CartBooster", 1, 2)
	-- Ironstuff (6)
	marketpinghour_CheckItem(Level, "Steel", 1, 10)
	marketpinghour_CheckItem(Level, "Beschlag", 1, 10)
	marketpinghour_CheckItem(Level, "Holzzapfen", 1, 10)
	marketpinghour_CheckItem(Level, "Tool", 1, 2)
	marketpinghour_CheckItem(Level, "Dagger", 1, 5)
	marketpinghour_CheckItem(Level, "Shortsword", 1, 5)
	marketpinghour_CheckItem(Level, "IronBrachelet", 1, 2)
	marketpinghour_CheckItem(Level, "SilverRing", 1, 2)
	marketpinghour_CheckItem(Level, "Siegelring", 1, 2)
	marketpinghour_CheckItem(Level, "GoldChain", 1, 2)
	marketpinghour_CheckItem(Level, "GemRing", 1, 2)
	marketpinghour_CheckItem(Level, "Diamond", 1, 1)
	marketpinghour_CheckItem(Level, "LongSword", 1, 5)
	marketpinghour_CheckItem(Level, "IronCap", 1, 2)
	marketpinghour_CheckItem(Level, "ChainMail", 1, 5)
	marketpinghour_CheckItem(Level, "FullHelmet", 1, 2)
	marketpinghour_CheckItem(Level, "Platemail", 1, 5)
	marketpinghour_CheckItem(Level, "Mace", 1, 5)
	marketpinghour_CheckItem(Level, "Axe", 1, 5)
	marketpinghour_CheckItem(Level, "BeltOfMetaphysic",1, 2)
	marketpinghour_CheckItem(Level, "BoobyTrap", 1, 2)
	-- Ressources (1)
	marketpinghour_CheckItem(Level, "Wheat", 1, 10)
	marketpinghour_CheckItem(Level, "Sugar", 1, 10)
	marketpinghour_CheckItem(Level, "SugarBeet", 1, 10)
	marketpinghour_CheckItem(Level, "Beef", 1, 10)
	marketpinghour_CheckItem(Level, "Leather", 1, 10)
	marketpinghour_CheckItem(Level, "Fat", 1, 10)
	marketpinghour_CheckItem(Level, "Wool", 1, 10)
	marketpinghour_CheckItem(Level, "Herring", 1, 10)
	marketpinghour_CheckItem(Level, "Salmon", 1, 10)
	marketpinghour_CheckItem(Level, "Shell", 1, 10)
	marketpinghour_CheckItem(Level, "Perle", 1, 10)
	marketpinghour_CheckItem(Level, "Fungi", 1, 10)
	marketpinghour_CheckItem(Level, "Fruit", 1, 10)
	marketpinghour_CheckItem(Level, "Honey", 1, 10)
	marketpinghour_CheckItem(Level, "Wachs", 1, 10)
	marketpinghour_CheckItem(Level, "Pinewood", 1, 10)
	marketpinghour_CheckItem(Level, "Oakwood", 1, 10)
	marketpinghour_CheckItem(Level, "Charcoal", 1, 10)
	marketpinghour_CheckItem(Level, "Pech", 1, 10)
	marketpinghour_CheckItem(Level, "Clay", 1, 10)
	marketpinghour_CheckItem(Level, "Granite", 1, 10)
	marketpinghour_CheckItem(Level, "Iron", 1, 10)
	marketpinghour_CheckItem(Level, "Silver", 1, 10)
	marketpinghour_CheckItem(Level, "Gold", 1, 10)
	marketpinghour_CheckItem(Level, "Gemstone", 1, 10)
	marketpinghour_CheckItem(Level, "Spiderleg", 1, 10)
	marketpinghour_CheckItem(Level, "Frogeye", 1, 10)
	marketpinghour_CheckItem(Level, "Dye", 1, 10)
	marketpinghour_CheckItem(Level, "BuildMaterial", 1, 10)
	marketpinghour_CheckItem(Level, "Grindingbrick", 1, 10)
	
end

function PingHour()
	
if not GetSettlement("", "City") then
		return 0
	end
	
	if CityIsKontor("City") then
		return 0
	end
	
	local Level = CityGetLevel("City")
	
	marketpinghour_CheckItem(Level, "Wheat", 1, 5)
	marketpinghour_CheckItem(Level, "Sugar", 1, 5)
	marketpinghour_CheckItem(Level, "SugarBeet", 1, 5)
	marketpinghour_CheckItem(Level, "Beef", 1, 5)
	marketpinghour_CheckItem(Level, "Leather", 1, 5)
	marketpinghour_CheckItem(Level, "Fat", 1, 5)
	marketpinghour_CheckItem(Level, "Wool", 1, 5)
	marketpinghour_CheckItem(Level, "Herring", 1, 5)
	marketpinghour_CheckItem(Level, "Salmon", 1, 5)
	marketpinghour_CheckItem(Level, "Shell", 1, 5)
	marketpinghour_CheckItem(Level, "Perle", 1, 5)
	marketpinghour_CheckItem(Level, "Fungi", 1, 5)
	marketpinghour_CheckItem(Level, "Fruit", 1, 5)
	marketpinghour_CheckItem(Level, "Honey", 1, 5)
	marketpinghour_CheckItem(Level, "Wachs", 1, 5)
	marketpinghour_CheckItem(Level, "Pinewood", 1, 5)
	marketpinghour_CheckItem(Level, "Oakwood", 1, 5)
	marketpinghour_CheckItem(Level, "Charcoal", 1, 5)
	marketpinghour_CheckItem(Level, "Pech", 1, 5)
	marketpinghour_CheckItem(Level, "Clay", 1, 5)
	marketpinghour_CheckItem(Level, "Granite", 1, 5)
	marketpinghour_CheckItem(Level, "Iron", 1, 5)
	marketpinghour_CheckItem(Level, "Silver", 1, 5)
	marketpinghour_CheckItem(Level, "Gold", 1, 5)
	marketpinghour_CheckItem(Level, "Gemstone", 1, 5)
	marketpinghour_CheckItem(Level, "Spiderleg", 1, 5)
	marketpinghour_CheckItem(Level, "Frogeye", 1, 5)
	marketpinghour_CheckItem(Level, "WheatFlour", 1, 5)
	marketpinghour_CheckItem(Level, "Dye", 1, 5)
	marketpinghour_CheckItem(Level, "Beschlag", 1, 5)
	marketpinghour_CheckItem(Level, "Holzzapfen", 1, 5)
	marketpinghour_CheckItem(Level, "BuildMaterial", 1, 5)
	marketpinghour_CheckItem(Level, "Grindingbrick", 1, 5)
	marketpinghour_CheckItem(Level, "Parchment", 1, 5)
	marketpinghour_CheckItem(Level, "Pergament", 1, 5)
	marketpinghour_CheckItem(Level, "Ink", 1, 5)
	marketpinghour_CheckItem(Level, "Swamproot", 1, 5)
	marketpinghour_CheckItem(Level, "Steel", 1, 5)
	marketpinghour_RemoveItemMarket()
end


function CheckItem(CityLevel, Item, MinCount, MaxCount)
	
	local Wanted = (MaxCount*CityLevel)
	local pixn = 1+Rand(MaxCount)
	local Count = GetItemCount("", Item, INVENTORY_STD)

	if Count < Wanted then
		AddItems("", Item, pixn, INVENTORY_STD)
	end
	
	if Count > 5000 then
	local new = 100+Rand(Wanted)
		RemoveItems("", Item, Count, INVENTORY_STD)
		AddItems("", Item, new, INVENTORY_STD)
	end
end

function CleanUp()
end

function RemoveItemMarket()
	if not GetSettlement("", "City") then
		return 0
	end
	
	if CityIsKontor("City") then
		return 0
	end

 local chance, Name, Baseprice, Sellprice
 local Reducevalue = Rand(4)
 local item = {
		"Cookie", "Wheatbread", "Cake", "BreadRoll", "CreamPie", "Candy",
		"vase", "GrainPap", "SmallBeer", "SalmonFilet", "WheatBeer", "Mead", "RoastBeef",
		"BoozyBreathBeer", "GhostlyFog", "Tool", "Dagger", "SilverRing", "Shortsword", "IronBrachelet",
		"GemRing", "BeltOfMetaphysic", "GoldChain", "Longsword", "IronCap", "Chainmail",
		"FullHelmet", "Platemail", "OakwoodRing", "BuildMaterial", "Torch", "WalkingStick",
		"Mace", "CrossOfProtection", "RubinStaff", "Axe", "Cloth", "MoneyBag", "Blanket",
		"FarmersClothes", "LeatherArmor", "CitizensClothes", "GlovesOfDexterity", "NoblesClothes",
		"CamouflageCloak", "LeatherGloves", "HerbTea", "Perfume", "DartagnansFragrance",
		"DrFaustusElixir", "FragranceOfHoliness", "FlowerOfDiscord", "ToadExcrements", 
		"Toadslime", "CartBooster", "BoobyTrap", "Housel", "Poem", "Chaplet", "AboutTalents1",
		"LetterOfIndulgence", "LetterFromRome", "ThesisPaper", "AboutTalents2", "Shellchain", 
		"FriedHerring", "Shellsoup", "SmokedSalmon", "StinkBomb", "Pearlchain", "Bandage",
		"Soap", "MiracleCure", "Salve", "Medicine", "StaffOfAesculap", "Mixture", "MediPack",
		"PainKiller","WeaponPoison", "Antidote", "ParalysisPoison", "BlackWidowPoison", "Amulet",
		"Hasstirade", "Handwerksurkunde", "Kamm", "Holzzapfen", "Beschlag", "Stonerotary",
		"bust", "statue", "Blissstone", "Optigold", "Optisilber", "Optieisen", "Goldveryhigh",
		"Goldmedhigh", "Goldlowmed", "Urkunde", "Schuldenbrief", "HexerdokumentII", 
		"HexerdokumentI", "Schadelkerze", "Dye", "Knochenarmreif", "Pendel", "Spindel",
		"Voodo", "Robe", "Pddv", "Fat", "SugarBeet", "Pig","Cattle", "Sheep", "Wachs", "Ink",
		"Siegel", "Siegelring", "Empfehlung", "Pfandbrief", "Gargoyle", "Oil", "Saft", "Diamond",
		"Schnitzi", "Bible", "Kerzen", "TarotCards", "Weingeist", "Phiole", "InvisiblePotion",
		"Milch", "Wurst", "Salat", "Perle", "Kraut", "CakeBatter" 
		}
 
	for i=0, 141 do
	Name = item[i]

		if (Name ~= nil) then
		Baseprice = ItemGetBasePrice(Name)
		NewBaseprice = Baseprice - math.floor((Baseprice / 100 * 10))
		Sellprice = ItemGetPriceSell(Name, "") 
			if Sellprice < NewBaseprice then
			--RemoveItems ("", Name, Reducevalue, INVENTORY_STD)
			Transfer(nil, nil, INVENTORY_STD, "", INVENTORY_STD, Name, Reducevalue)
			end 

		end
	end
end