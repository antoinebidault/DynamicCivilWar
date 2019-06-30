/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
 
_unit = _this;
waitUntil { time > 0 };

if (isNil 'SUPPORT_REQUESTER') then {
	//Create a side logic 
	private _center = createCenter sideLogic; 
	//Create a group for our modules 
	private _logicGroup = createGroup _center; 
	//Spawn a SupportRequestor module 

	private _pos = [_unit, 3000, (floor (random 360))] call BIS_fnc_relPos;
	SUPPORT_REQUESTER = _logicGroup createUnit ["SupportRequester",_pos, [], 0, "FORM"]; 
	publicVariable "SUPPORT_REQUESTER";

	// Transport menu config
	COMMENU_TRANSPORT_ID = 0;
	TRANSPORTPARADROP_MENU = [["Transport",false]];
	{
		_displayName = getText(configFile >>  "CfgVehicles" >> _x >> "displayName");
		TRANSPORTPARADROP_MENU pushBack [_displayName, [_foreachIndex + 2], "", -5, [["expression",format[ "[player,COMMENU_TRANSPORT_ID] spawn BIS_fnc_removeCommMenuItem; [getPos player,1500,""%1""] execVM ""DCW\fnc\supportui\VehicleLift.sqf"";",_x]]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"];
	}
	foreach SUPPORT_CAR_PARADROP_CLASS;
	publicVariable "TRANSPORTPARADROP_MENU";


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
				_this call DCW_fnc_spawncrate;
			'],
			["BIS_SUPP_vehicles",_x select 1],		//types of vehicles to use
			["BIS_SUPP_vehicleinit","_this setCaptive true; { _x setCaptive true; } foreach crew _this;"],	//init code for vehicle
			["BIS_SUPP_filter","SIDE"]		//whether default vehicles comes from "SIDE" or "FACTION"
		];
		
		//ENABLE ACTIVATION
		_supportProvider setVariable["BIS_fnc_initModules_disableAutoActivation", false];

		[SUPPORT_REQUESTER, _x select 0, 0] call BIS_fnc_limitSupport;
		[player, SUPPORT_REQUESTER, _supportProvider] call BIS_fnc_addSupportLink;

	}forEach [
		["Artillery",SUPPORT_ARTILLERY_CLASS],
		["CAS_Heli",SUPPORT_CAS_HELI_CLASS],
		["CAS_Bombing",SUPPORT_BOMBING_AIRCRAFT_CLASS],
		["UAV",[SUPPORT_DRONE_CLASS]],
		["Drop",SUPPORT_DROP_AIRCRAFT_CLASS],
		["Transport",SUPPORT_TRANSPORT_CHOPPER_CLASS]
	];
	publicVariable "SUPPORT_REQUESTER";

};

if (isPlayer _unit)then{
	_unit addAction ["<t color='#00FF00'>Get supports</t>",{
		hint "With this user interface, you can order supports with your points ! Interrogating civilian, destroying weapons caches, eliminating patrols will give you extra points."; 
		(_this select 0) call DCW_fnc_supportui;
	},nil,0.5,false,true,"","true",15,false,""];
};

//[] call DCW_fnc_displayscore;