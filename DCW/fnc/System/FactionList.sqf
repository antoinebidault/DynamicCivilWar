/**
 * DYNAMIC CIVIL WAR
 * Created: 2019-03-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Return the list of factions
 */


params[];

_allowedmenclass = ["Man"]; 

//--------------------------------

//Some config functions
	
_CfgFactions = configFile >> "CfgFactionClasses";
FACTIONS = [];
for "_i" from 1 to ((count _CfgFactions) - 1) do 
{
	_faction = _CfgFactions select _i;
	if (getNumber(_faction >> "side") < 2 && getNumber(_faction >> "side") > 0) then {
		FACTIONS = FACTIONS + [[getText(_faction >> "displayName"), configName _faction, getText(_faction >> "icon") ]];
	};
};

FACTIONS;