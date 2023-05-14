
include("FLuaVector.lua")
function Ritual(iPlayer, iCity, iUnit, bGold, bFaith)
	if bGold then return end 
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if not pCity:IsHasBuilding(GameInfoTypes.BUILDING_RITUAL_HEART) then return end
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitType() == GameInfoTypes.UNIT_CASCADING_RITUAL then
		pUnit:Kill(true, -1)
		local eBuildingChallaBonus = GameInfoTypes.BUILDING_D_FOR_CASCADING_RITUAL
		local iRitualBonus = pCity:GetNumRealBuilding(eBuildingChallaBonus) + 1	
		pCity:SetNumRealBuilding(eBuildingChallaBonus, iRitualBonus)
	end
end
GameEvents.CityTrained.Add(Ritual)

