/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/
 
waitUntil { time > 0 && DCW_STARTED };

//Create a side logic 
private _center = createCenter sideLogic; 
//Create a group for our modules 
private _logicGroup = createGroup _center; 
//Spawn a SupportRequestor module 

private _pos = [getPos (leader GROUP_PLAYERS), 3000, (floor (random 360))] call BIS_fnc_relPos;
SUPPORT_REQUESTER = _logicGroup createUnit ["SupportRequester",_pos, [], 0, "FORM"]; 
publicVariable "SUPPORT_REQUESTER";

// Transport menu config
COMMENU_TRANSPORT_ID = 0;
TRANSPORTPARADROP_MENU = [["Transport",false]];
{
	_displayName = getText(configFile >>  "CfgVehicles" >> _x >> "displayName");
	TRANSPORTPARADROP_MENU pushBack [_displayName, [_foreachIndex + 2], "", -5, [["expression",format[ "[player,COMMENU_TRANSPORT_ID] spawn BIS_fnc_removeCommMenuItem; [getPos player,1500,""%1""] spawn DCW_fnc_vehicleLift;",_x]]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"];
}
foreach SUPPORT_CAR_PARADROP_CLASS;
publicVariable "TRANSPORTPARADROP_MENU";


{
	[SUPPORT_REQUESTER, _x, 0] remoteExec ["BIS_fnc_limitSupport"];
} forEach [
	"Artillery",
	"CAS_Heli",
	"CAS_Bombing",
	"UAV",
	"Drop",
	"Transport"
];

SUPPORT_REQUESTER setVariable[ "BIS_fnc_initModules_disableAutoActivation", false, true ];
publicVariable "SUPPORT_REQUESTER";



private _logicGroupSupportProvider = createGroup _center;

{
	//[SUPPORT_REQUESTER, _x, 0] call BIS_fnc_limitSupport;
	//SUPPORT_REQUESTER setVariable [format ["BIS_SUPP_limit_%1_total", _x], -1];
	_supportProvider =  _logicGroupSupportProvider createUnit [format["SupportProvider_Virtual_%1",_x select 0],_pos, [], 0, "FORM"]; 
	
	//Setup provider values
	{
		_supportProvider setVariable [(_x select 0),(_x select 1),true];
	}forEach [
		["BIS_SUPP_crateInit",
		'
			_this remoteExec ["DCW_fnc_spawncrate",0,true];
		'],
		["BIS_SUPP_vehicles",_x select 1],		//types of vehicles to use
		["BIS_SUPP_vehicleinit","_this setCaptive true; { _x setCaptive true; } foreach crew _this;"],	//init code for vehicle
		["BIS_SUPP_filter","SIDE"]		//whether default vehicles comes from "SIDE" or "FACTION"
	];
	
	//ENABLE ACTIVATION
	_supportProvider setVariable["BIS_fnc_initModules_disableAutoActivation", false];

	[SUPPORT_REQUESTER, _x select 0, 0] remoteExec ["BIS_fnc_limitSupport"];
	[(leader GROUP_PLAYERS), SUPPORT_REQUESTER, _supportProvider] remoteExec ["BIS_fnc_addSupportLink"] ;

}forEach [
	["Artillery",SUPPORT_ARTILLERY_CLASS],
	["CAS_Heli",SUPPORT_CAS_HELI_CLASS],
	["CAS_Bombing",SUPPORT_BOMBING_AIRCRAFT_CLASS],
	["UAV",[SUPPORT_DRONE_CLASS]],
	["Drop",SUPPORT_DROP_AIRCRAFT_CLASS],
	["Transport",SUPPORT_TRANSPORT_CHOPPER_CLASS]
];
publicVariable "SUPPORT_REQUESTER";
