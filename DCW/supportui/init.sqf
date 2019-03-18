/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
 
params ["_unit"];
waitUntil { time > 0 };

 //Create a side logic 
private _center = createCenter sideLogic; 
//Create a group for our modules 
private _logicGroup = createGroup _center; 
//Spawn a SupportRequestor module 

private _pos = [_unit, 3000, (floor (random 360))] call BIS_fnc_relPos;
SUPPORT_REQUESTER = _logicGroup createUnit ["SupportRequester",_pos, [], 0, "FORM"]; 

{
	[SUPPORT_REQUESTER, _x, 0] call BIS_fnc_limitSupport;
} forEach [
	"Artillery",
	"CAS_Heli",
	"CAS_Bombing",
	"UAV",
	"Drop",
	"Transport"
];

SUPPORT_REQUESTER setVariable[ "BIS_fnc_initModules_disableAutoActivation", false ];


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
			_this call fnc_fillCrate;
		'],
		["BIS_SUPP_vehicles",_x select 1],		//types of vehicles to use
		["BIS_SUPP_vehicleinit",""],	//init code for vehicle
		["BIS_SUPP_filter","SIDE"]		//whether default vehicles comes from "SIDE" or "FACTION"
	];
	//ENABLE ACTIVATION
	_supportProvider setVariable["BIS_fnc_initModules_disableAutoActivation", false];

	[SUPPORT_REQUESTER, _x select 0, 0] call BIS_fnc_limitSupport;
	[player, SUPPORT_REQUESTER, _supportProvider] call BIS_fnc_addSupportLink;

}forEach [
	["Artillery",[SUPPORT_ARTILLERY_CLASS]],
	["CAS_Heli",[SUPPORT_CAS_HELI_CLASS]],
	["CAS_Bombing",[SUPPORT_BOMBING_AIRCRAFT_CLASS]],
	["UAV",[SUPPORT_DRONE_CLASS]],
	["Drop",[SUPPORT_DROP_AIRCRAFT_CLASS]],
	["Transport",[SUPPORT_TRANSPORT_CHOPPER_CLASS]]
];


if (isPlayer _unit)then{
	_unit addAction ["<t color='#EEEEEE'>Get supports</t>",{
		hint "With this user interface, you can order supports with your points ! Interrogating civilian, destroying weapons caches, eliminating patrols will give you extra points."; 
		(_this select 0) call fnc_supportui;
	},nil,1.5,false,true,"","true",15,false,""];
};

[] call fnc_displayscore;