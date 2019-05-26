
_units = units GROUP_PLAYERS;
GROUP_PLAYERS = createGroup SIDE_FRIENDLY;
_units joinSilent GROUP_PLAYERS;

FRIENDLY_LIST_UNITS = [FRIENDLY_LIST_UNITS,[FACTION_PLAYER,["Man"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;
ALLIED_LIST_UNITS = [ALLIED_LIST_UNITS,[FACTION_FRIENDLY,["Man"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;
ALLIED_LIST_CARS = [ALLIED_LIST_CARS,[FACTION_FRIENDLY,["Car"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;

FRIENDLY_CHOPPER_CLASS = [FRIENDLY_CHOPPER_CLASS,[FACTION_PLAYER,["Helicopter"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;

CIV_LIST_UNITS = [FACTION_CIV,["Man"],[]] call fnc_factiongetunits;
CIV_LIST_CARS = [FACTION_CIV,["Car"],[]] call fnc_factiongetunits;

ENEMY_LIST_UNITS = [ENEMY_LIST_UNITS,[FACTION_ENEMY,["Man"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;
ENEMY_LIST_CARS = [ENEMY_LIST_CARS,[FACTION_ENEMY,["Car"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;
ENEMY_CHOPPERS =  [ENEMY_CHOPPERS,[FACTION_ENEMY,["Helicopter"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;
ENEMY_LIST_TANKS = [ENEMY_LIST_TANKS,[FACTION_ENEMY,["Tank"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;
ENEMY_SNIPER_UNITS =  [ENEMY_SNIPER_UNITS,[FACTION_ENEMY,["Man"], ["sniper"]] call fnc_factiongetunits] call fnc_fillSupportParam;
ENEMY_CONVOY_CAR_CLASS = ENEMY_LIST_CARS select 0;
ENEMY_CONVOY_TRUCK_CLASS = [ENEMY_CONVOY_TRUCK_CLASS,[FACTION_ENEMY,["Truck_F"],[]] call fnc_factiongetunits] call fnc_fillSupportParam;
ENEMY_COMMANDER_CLASS = ENEMY_LIST_UNITS select 0; 
ENEMY_OFFICER_LIST_CARS = ENEMY_LIST_CARS; 

_mortars = [FACTION_ENEMY,["StaticMortar"],[]] call fnc_factiongetunits;
if (count _mortars > 0) then {
	ENEMY_MORTAR_CLASS = _mortars select 0;
};

SUPPORT_ARTILLERY_CLASS = [SUPPORT_ARTILLERY_CLASS,[FACTION_PLAYER, ["StaticWeapon"], "Artillery"] call fnc_FactionGetSupportUnits] call fnc_fillSupportParam;
SUPPORT_TRANSPORT_CHOPPER_CLASS = [SUPPORT_TRANSPORT_CHOPPER_CLASS,[FACTION_PLAYER, ["Helicopter"], "Transport"] call fnc_FactionGetSupportUnits] call fnc_fillSupportParam;
SUPPORT_DROP_AIRCRAFT_CLASS = [SUPPORT_DROP_AIRCRAFT_CLASS,[FACTION_PLAYER, ["Air"], "Drop"] call fnc_FactionGetSupportUnits] call fnc_fillSupportParam;
SUPPORT_MEDEVAC_CHOPPER_CLASS = [SUPPORT_MEDEVAC_CHOPPER_CLASS,[FACTION_PLAYER, ["Helicopter"], "Transport"] call fnc_FactionGetSupportUnits] call fnc_fillSupportParam;
SUPPORT_BOMBING_AIRCRAFT_CLASS = [SUPPORT_BOMBING_AIRCRAFT_CLASS,[FACTION_PLAYER, ["Plane"], "CAS_Bombing"] call fnc_FactionGetSupportUnits] call fnc_fillSupportParam;
SUPPORT_CAS_HELI_CLASS = [SUPPORT_CAS_HELI_CLASS,[FACTION_PLAYER, ["Helicopter"], "CAS_Heli"] call fnc_FactionGetSupportUnits] call fnc_fillSupportParam;
SUPPORT_HEAVY_TRANSPORT_CLASS = [SUPPORT_HEAVY_TRANSPORT_CLASS,[FACTION_PLAYER, ["Helicopter"], "Drop"] call fnc_FactionGetSupportUnits] call fnc_fillSupportParam;
SUPPORT_DRONE_CLASS = if (SIDE_FRIENDLY == WEST) then {"B_UAV_02_dynamicLoadout_F"} else {"O_UAV_02_dynamicLoadout_F"};
SUPPORT_MEDEVAC_CREW_CLASS = ALLIED_LIST_UNITS call BIS_fnc_selectrandom;
SUPPORT_CAR_PARADROP_CLASS = [FACTION_PLAYER,["Car"],"slingload"] call fnc_FactionGetSupportUnits call BIS_fnc_selectrandom;


// EMpty the array for memory saving purposes...
CONFIG_VEHICLES = [];