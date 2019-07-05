/**
 * DYNAMIC CIVIL WAR
 * Created: 2019-03-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Return the list of factions
 */


params["_side"];

_allowedmenclass = ["Man"]; 

_CfgFactions = configFile >> "CfgFactionClasses";
FACTIONS = [];
for "_i" from 1 to ((count _CfgFactions) - 1) do 
{
	_faction = _CfgFactions select _i;
	if (getNumber(_faction >> "side") == (_side call BIS_fnc_sideID)) then {
		FACTIONS = FACTIONS + [[getText(_faction >> "displayName"), configName _faction, getText(_faction >> "icon") ]];
	};
};

FACTIONS;