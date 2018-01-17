/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_unit"];
fnc_updatescore = compile preprocessFileLineNumbers  "supportui\fnc\UpdateScore.sqf";
fnc_afford = compile preprocessFileLineNumbers  "supportui\fnc\Afford.sqf";
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
DRONE_CLASS="rhs_pchela1t_vvsc";

{
	//[SUPPORT_REQUESTER, _x, 0] call BIS_fnc_limitSupport;
	//SUPPORT_REQUESTER setVariable [format ["BIS_SUPP_limit_%1_total", _x], -1];
	_supportProvider =  _logicGroup createUnit [format["SupportProvider_Virtual_%1",_x select 0],[0,0,0], [], 0, "FORM"]; 
	
	//Setup provider values
	{
		_supportProvider setVariable [(_x select 0),(_x select 1)];
	}forEach [
		["BIS_SUPP_crateInit",
		'
			ClearWeaponCargo _this;
			ClearMagazineCargo _this;
			clearBackpackCargo _this;
			removeAllItems _this;
			clearItemCargo _this;
			_this addMagazineCargoGlobal ["rhs_30Rnd_762x39mm",30];
			_this addMagazineCargoGlobal ["rhs_30Rnd_545x39_7N10_AK",20];
			_this addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK_green",20];
			_this addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR",10];
			_this addWeaponCargoGlobal ["rhs_rpg26",2];
			_this addWeaponCargoGlobal ["rhs_rshg2",2];
			_this addWeaponCargoGlobal ["rhs_igla",1];
			_this addItemCargoGlobal ["DemoCharge_F",20];
			_this addItemCargoGlobal ["O_UavTerminal",1];
			_this addItemCargoGlobal ["ToolKit",1];
			_this addItemCargoGlobal ["Medikit",1];
			_this addItemCargoGlobal ["FirstAidKit",10];
			_this addBackpackCargoGlobal ["rhs_assault_umbts",2];
			_this addItemCargoGlobal ["rhs_acc_ekp1",2];
			_this addItemCargoGlobal ["rhs_acc_ekp8_02",2];
			_this addItemCargoGlobal ["rhs_acc_pkas",2];
			_this addItemCargoGlobal ["rhs_acc_1p78",2];
			_this addItemCargoGlobal ["rhs_acc_1p29",2];
			_this addItemCargoGlobal ["rhs_acc_pso1m2",2];
			_this addItemCargoGlobal ["FirstAidKit",10];
		'],
		["BIS_SUPP_vehicles",_x select 1],		//types of vehicles to use
		["BIS_SUPP_vehicleinit",""],	//init code for vehicle
		["BIS_SUPP_filter","SIDE"]		//whether default vehicles comes from "SIDE" or "FACTION"
	];

	[SUPPORT_REQUESTER, _x select 0, 0] call BIS_fnc_limitSupport;
	[_unit, SUPPORT_REQUESTER, _supportProvider] call BIS_fnc_addSupportLink;

}forEach [
	["Artillery",["rhs_D30_msv"]],
	["CAS_Heli",[]],
	["CAS_Bombing",["RHS_Su25SM_vvsc"]],
	["UAV",[DRONE_CLASS]],
	["Drop",["RHS_Mi8mt_vdv"]],
	["Transport",["RHS_Mi8mt_vdv"]]
];




_unit setVariable ["DCW_SCORE",_unit getVariable ["DCW_SCORE",START_SCORE]];

if (isPlayer _unit)then{
	_unit addAction ["<t color='#EEEEEE'>Get supports</t>",{
		hint "With this user interface, you can order supports with your points ! Interrogating civilian, destroying weapons caches, eliminating patrols will give you extra points."; 
		(_this select 0) call fnc_supportui;
	},nil,1.5,false,true,"","true",15,false,""];
};

_unit call fnc_displayscore;

fnc_addCrateInventory = {
	clearWeaponCargoglobal _this;
	clearmagazinecargoglobal _this;
	clearitemcargoglobal _this;
	clearbackpackcargoglobal _this;
	["AmmoboxInit",[_this,true,{true}]] call BIS_fnc_arsenal;
	_this addItemCargoGlobal ["rhs_weapon_aks74",1];
	_this addItemCargoGlobal ["rhs_magazine_rhs_30Rnd_762x39mm",20];
	_this addItemCargoGlobal ["rhs_magazine_rhs_30Rnd_545x39_7N10_AK",20];
	_this addItemCargoGlobal ["rhs_magazine_rhs_30Rnd_545x39_AK_green",20];
	_this addItemCargoGlobal ["rhs_weapon_rpg26",2];
	_this addItemCargoGlobal ["rhs_weapon_rshg2",2];
	_this addItemCargoGlobal ["rhs_weapon_igla",1];
	_this addItemCargoGlobal ["DemoCharge_F",20];
	_this addItemCargoGlobal ["Item_O_UavTerminal",1];
	_this addItemCargoGlobal ["Item_ToolKit",1];
	_this addItemCargoGlobal ["Item_Medikit",1];
	_this addItemCargoGlobal ["Item_FirstAidKit",10];
	_this addItemCargoGlobal ["rhs_assault_umbts",10];
	_this addItemCargoGlobal ["rhs_magazine_rhs_100Rnd_762x54mmR",10];
	_this addItemCargoGlobal ["Item_rhs_acc_ekp1",2];
	_this addItemCargoGlobal ["Item_rhs_acc_ekp8_02",2];
	_this addItemCargoGlobal ["Item_rhs_acc_pkas",2];
	_this addItemCargoGlobal ["Item_rhs_acc_1p78",2];
	_this addItemCargoGlobal ["Item_rhs_acc_1p29",2];
	_this addItemCargoGlobal ["Item_rhs_acc_pso1m2",2];
	_this addItemCargoGlobal ["Item_FirstAidKit",10];
};
