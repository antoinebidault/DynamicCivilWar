disableSerialization;

fnc_getValue = {
	private _ctrlId = _this;
	private _display = findDisplay 5001;
	private _ctrl =  _display displayCtrl _ctrlId;
	_ctrl lbValue (lbCurSel _ctrl);
};

fnc_getValueChkBx = {
	private _ctrlId = _this;
	private _display = findDisplay 5001;
	private _ctrl =  _display displayCtrl _ctrlId;
	cbChecked  _ctrl;
};

//Saving and close method;
fnc_SaveAndCloseConfigDialog = {

	//Time of the day;
	TIME_OF_DAYS = 2100 call fnc_getValue;
	publicVariable "TIME_OF_DAYS";

	//Weather
	WEATHER = (2101 call fnc_getValue) / 100;
	publicVariable "WEATHER";

	//Time_selected;
	POPULATION_INTENSITY = (2102 call fnc_getValue);
	publicVariable "POPULATION_INTENSITY";

	//Revive
	MEDEVAC_ENABLED =  2104 call fnc_getValueChkBx;
	publicVariable "MEDEVAC_ENABLED";

	//Respawn
	RESPAWN_ENABLED =  2105 call fnc_getValueChkBx;
	publicVariable "RESPAWN_ENABLED";

	// Ammobox restricted
	RESTRICTED_AMMOBOX =  2106 call fnc_getValueChkBx;
	publicVariable "RESTRICTED_AMMOBOX";

	//kill camera
	closeDialog 0;

	[] spawn {
		titleCut ["", "BLACK OUT", 2];
		sleep 2;
		{
			if (!isPlayer _x) then {
				[_x,"MOVE"] remoteExec ["enableAI", 2] ;
				[_x,"FSM"] remoteExec ["enableAI", 2] ;
			};
    		[_x,""] remoteExec ["switchMove", 0];
		}
		foreach units group player;
		UNIT_SHOWCASE_CAMERA cameraeffect ["terminate", "back"];
		camDestroy UNIT_SHOWCASE_CAMERA;
		//deleteVehicle UNIT_SHOWCASE;
		DCW_STARTED = true;
		publicVariableServer "DCW_STARTED";

		titleCut ["", "BLACK FADED", 999];

	};
};

//Saving and close method;
fnc_SwitchUnit = {
	params["_ctrl","_val"];
	_factionName =  lbData [_ctrl,_val];
	titleCut ["", "BLACK OUT", 1];
	sleep 1;

	//Weather
	unitClasses = [_factionName] call fnc_FactionGetUnits;
	if (count unitClasses > 0) then {
		_grp = createGroup east;
		{
			_rndClass = unitClasses call BIS_fnc_selectRandom;
			_phantomUnit = _grp createUnit [_rndClass, [0,0,0], [], 0, "FORM"];
			_x setUnitLoadout(getUnitLoadout(_phantomUnit));
			deleteVehicle _phantomUnit;
		} foreach units (group player);
		deleteGroup _grp;
	};
	titleCut ["", "BLACK FADED", 1];
	sleep 1;

	titleCut ["", "BLACK IN", 3];

	//UNIT_SHOWCASE execVM format["DCW\loadout\loadout-%1.sqf",_this];
	//player execVM format["DCW\loadout\loadout-%1.sqf",_this];

	sleep .3;

	disableSerialization;
	private _display = findDisplay 5001;

	/*
	private _ctrl =  _display displayCtrl 2200;
	private _image = getText (configfile >> "CfgWeapons" >> primaryWeapon player >> "picture");
	_ctrl ctrlSetText _image;

	private _ctrl =  _display displayCtrl 2201;
	private _image = getText (configfile >> "CfgWeapons" >> secondaryWeapon player >> "picture");
	_ctrl ctrlSetText _image;
		
	private _ctrl =  _display displayCtrl 2202;
	private _image = getText (configfile >> "CfgWeapons" >> handgunWeapon player >> "picture");
	_ctrl ctrlSetText _image;*/

};

titleCut ["", "BLACK FADED", 999];

_anims = ["Acts_millerCamp_A","Acts_millerCamp_C","acts_millerIdle","Acts_Ending_Lacey2","Acts_starterPistol_loop","Acts_listeningToRadio_Loop","Acts_ComingInSpeakingWalkingOut_10","Acts_ComingInSpeakingWalkingOut_4","Acts_ShieldFromSun_loop","Acts_ComingInSpeakingWalkingOut_4"];
UNIT_SHOWCASE = player; 
{
	if (!isPlayer _x) then {
		[_x,"MOVE"] remoteExec ["disableAI", 2] ;
		[_x,"FSM"] remoteExec ["disableAI", 2] ;
	};
	_anim = _anims select 0;
	_anims = _anims - [_anim];
    [_x,_anim] remoteExec ["switchMove", 0];
}
foreach units group player;

UNIT_SHOWCASE_CAMERA = "camera" camcreate (getPos UNIT_SHOWCASE);
UNIT_SHOWCASE_CAMERA cameraeffect ["internal", "back"];
showCinemaBorder false;
UNIT_SHOWCASE_CAMERA camSetPos (UNIT_SHOWCASE modelToWorld[1,3,.3]);
UNIT_SHOWCASE_CAMERA camSetTarget (UNIT_SHOWCASE modelToWorld[.3,0,1.3]); 
UNIT_SHOWCASE_CAMERA camCommit 0;
sleep 2;
titleCut ["", "BLACK IN", 7];
 
private _ok = createDialog "PARAMETERS_DIALOG"; 
private _display = findDisplay 5001;

noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

//Time

private _ctrlListTime = _display displayCtrl 2100;
_ctrlListTime lbAdd "Night";
_ctrlListTime lbSetValue  [0,23];
_ctrlListTime lbAdd  "Early morning";
_ctrlListTime lbSetValue  [1,7];
_ctrlListTime lbAdd  "Afternoon";
_ctrlListTime lbSetValue  [2,12];
_ctrlListTime lbAdd "Evening";
_ctrlListTime lbSetValue  [3,19];
_ctrlListTime lbSetCurSel  2;


//Weather
private _ctrlListWeather = _display displayCtrl 2101;
_ctrlListWeather lbAdd "Beautiful";
_ctrlListWeather lbSetValue  [0,0];
_ctrlListWeather lbAdd "Clouds";
_ctrlListWeather lbSetValue  [1,25];
_ctrlListWeather lbAdd  "Average";
_ctrlListWeather lbSetValue  [2,50];
_ctrlListWeather lbAdd "Storm";
_ctrlListWeather lbSetValue  [3,70];
_ctrlListWeather lbAdd "Rain";
_ctrlListWeather lbSetValue  [4,100];
_ctrlListWeather lbSetCurSel  1;

//Population
private _ctrlListPopulation = _display displayCtrl 2102;
_ctrlListPopulation lbAdd "High";
_ctrlListPopulation lbSetValue  [0,1.25];
_ctrlListPopulation lbAdd  "Standard";
_ctrlListPopulation lbSetValue  [1,1];
_ctrlListPopulation lbAdd "Low";
_ctrlListPopulation lbSetValue  [2,.7];
_ctrlListPopulation lbSetCurSel  1;

//Population
_factions = [] call fnc_factionlist;
private _ctrlLoadout = _display displayCtrl 2103;
{
	_ctrlLoadout lbAdd (_x select 0);
	_ctrlLoadout lbSetValue [_forEachIndex ,_forEachIndex];
	_ctrlLoadout lbSetData [_forEachIndex, _x select 1];
	_ctrlLoadout lbSetPicture [_forEachIndex,_x select 2];
}foreach _factions;
_ctrlLoadout lbSetCurSel 0;

_ctrlLoadout ctrlAddEventHandler ["LBSelChanged","[ctrlIDC(_this select 0),_this select 1] spawn fnc_SwitchUnit"];
_ctrlLoadout ctrlEnable false;

//Data
private _ctrlReviveOn = _display displayCtrl 2104;
_ctrlReviveOn cbSetChecked true;

//Respawn
private _ctrlRespawnOn = _display displayCtrl 2105;
_ctrlRespawnOn cbSetChecked true;

//Respawn
private _ctrlAmmoOn = _display displayCtrl 2106;
_ctrlAmmoOn cbSetChecked true;

