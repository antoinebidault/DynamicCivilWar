params ["_unit"];
fnc_updatescore = compile preprocessFileLineNumbers  "supportui\fnc\UpdateScore.sqf";
fnc_supportui = compile preprocessFileLineNumbers  "supportui\fnc\SupportUI.sqf";
fnc_displayscore = compile preprocessFileLineNumbers  "supportui\fnc\DisplayScore.sqf";

sleep 14;

 //Create a side logic 
_center = createCenter sideLogic; 
//Create a group for our modules 
_logicGroup = createGroup _center; 
//Spawn a SupportRequestor module 
START_SCORE = 150;
SUPPORT_REQUESTER = _logicGroup createUnit ["SupportRequester",getPosWorld _unit, [], 0, "FORM"]; 

{
	//[SUPPORT_REQUESTER, _x, 0] call BIS_fnc_limitSupport;
	//SUPPORT_REQUESTER setVariable [format ["BIS_SUPP_limit_%1_total", _x], -1];
	_supportProvider =  _logicGroup createUnit [format["SupportProvider_Virtual_%1",_x select 0],[0,0,0], [], 0, "FORM"]; 
	
	//Setup provider values
	{
		_supportProvider setVariable [(_x select 0),(_x select 1)];
	}forEach [
		["BIS_SUPP_crateInit",""],		//init code for crate
		["BIS_SUPP_vehicles",_x select 1],		//types of vehicles to use
		["BIS_SUPP_vehicleinit",""],	//init code for vehicle
		["BIS_SUPP_filter","SIDE"]		//whether default vehicles comes from "SIDE" or "FACTION"
	];

	[SUPPORT_REQUESTER, _x select 0, 0] call BIS_fnc_limitSupport;
	[_unit, SUPPORT_REQUESTER, _supportProvider] call BIS_fnc_addSupportLink;

}forEach [
	["Artillery",["RHS_M119_WD"]],
	["CAS_Heli",[]],
	["CAS_Bombing",["RHS_A10"]],
	["UAV",["B_UAV_02_dynamicLoadout_F"]],
	["Drop",["RHS_C130J"]],
	["Transport",["RHS_UH1Y_d"]]
];




_unit setVariable ["IH_SCORE",_unit getVariable ["IH_SCORE",START_SCORE]];

if (isPlayer _unit)then{
	_unit addAction ["<t color='#eee'>Get supports</t>",{
		hint "With this user interface, you can order supports with your points ! Interrogating civilian, destroying weapons caches, eliminating patrols will give you extra points."; 
		(_this select 0) call fnc_supportui;
	},nil,1.5,false,true,"","true",15,false,""];
};

_unit call fnc_displayscore;
