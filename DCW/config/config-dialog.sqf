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

	//Weather
	WEATHER = (2101 call fnc_getValue) / 100;

	//Time_selected;
	POPULATION_INTENSITY = (2102 call fnc_getValue) / 100;

	//Revive
	REVIVE_ENABLED =  2104 call fnc_getValueChkBx;

	//Respawn
	RESPAWN_ENABLED =  2105 call fnc_getValueChkBx;

	
	//hint str [TIME_OF_DAYS, WEATHER, POPULATION_INTENSITY,RESPAWN_ENABLED,REVIVE_ENABLED];


	//kill camera
	closeDialog 0;

	[] spawn {
		titleCut ["", "BLACK OUT", 2];
		sleep 2;
		UNIT_SHOWCASE_CAMERA cameraeffect ["terminate", "back"];
		camDestroy UNIT_SHOWCASE_CAMERA;
		deleteVehicle UNIT_SHOWCASE;
		DCW_START = true;
		titleCut ["", "BLACK FADED", 999];
		sleep 2;
		titleCut ["", "BLACK IN", 7];

	};
};

//Saving and close method;
fnc_SwitchUnit = {
	//Weather
	UNIT_SHOWCASE execVM format["DCW\loadout\loadout-%1.sqf",_this];
	player execVM format["DCW\loadout\loadout-%1.sqf",_this];

	sleep .3;

	disableSerialization;
	private _display = findDisplay 5001;

	private _ctrl =  _display displayCtrl 2200;
	private _image = getText (configfile >> "CfgWeapons" >> primaryWeapon player >> "picture");
	_ctrl ctrlSetText _image;

		
	private _ctrl =  _display displayCtrl 2201;
	private _image = getText (configfile >> "CfgWeapons" >> secondaryWeapon player >> "picture");
	_ctrl ctrlSetText _image;
		
	private _ctrl =  _display displayCtrl 2202;
	private _image = getText (configfile >> "CfgWeapons" >> handgunWeapon player >> "picture");
	_ctrl ctrlSetText _image;

};

titleCut ["", "BLACK FADED", 999];

UNIT_SHOWCASE =  (createGroup EAST) createUnit ["O_Soldier_AAT_F",[7896.11,11684.8,0.0523224], [], 0, "NONE"]; 
UNIT_SHOWCASE disableAI "MOVE";
UNIT_SHOWCASE disableAI "FSM";

UNIT_SHOWCASE_CAMERA = "camera" camcreate (getPos UNIT_SHOWCASE);
UNIT_SHOWCASE_CAMERA cameraeffect ["internal", "back"];
showCinemaBorder false;
UNIT_SHOWCASE_CAMERA camSetPos (UNIT_SHOWCASE modelToWorld[1,3,.3]);
UNIT_SHOWCASE_CAMERA camSetTarget (UNIT_SHOWCASE modelToWorld[.3,0,1.3]); 
UNIT_SHOWCASE_CAMERA camCommit 0;
sleep 2;
titleCut ["", "BLACK IN", 7];
showCinemaBorder false;
 
private _ok = createDialog "PARAMETERS_DIALOG"; 
private _display = findDisplay 5001;

1 call fnc_SwitchUnit; 


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
_ctrlListPopulation lbSetValue  [0,75];
_ctrlListPopulation lbAdd  "Middle";
_ctrlListPopulation lbSetValue  [1,50];
_ctrlListPopulation lbAdd "Low";
_ctrlListPopulation lbSetValue  [2,35];
_ctrlListPopulation lbSetCurSel  1;

//Population
private _ctrlLoadout = _display displayCtrl 2103;
_ctrlLoadout lbAdd "Grigor";
_ctrlLoadout lbSetValue  [0,1];
_ctrlLoadout lbAdd "Vladimir";
_ctrlLoadout lbSetValue  [1,2];
_ctrlLoadout lbAdd "Serguei";
_ctrlLoadout lbSetValue  [2,3];
_ctrlLoadout lbAdd "Ivanov";
_ctrlLoadout lbSetValue  [3,4];
_ctrlLoadout lbAdd "Aleksei";
_ctrlLoadout lbSetValue  [4,5];
_ctrlLoadout lbSetCurSel  0;
_ctrlLoadout ctrlAddEventHandler ["LBSelChanged","((_this select 1) + 1) spawn fnc_SwitchUnit"];


//Data
private _ctrlReviveOn = _display displayCtrl 2104;
_ctrlReviveOn cbSetChecked true;

//Respawn
private _ctrlRespawnOn = _display displayCtrl 2105;
_ctrlRespawnOn cbSetChecked true;

