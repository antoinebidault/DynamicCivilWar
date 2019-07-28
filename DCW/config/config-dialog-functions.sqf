/*
	Author: 
		Bidass

  Version:
    {VERSION}

	Description:
		Functions library for the config dialog

*/



DCW_fnc_getValue = {
	private _ctrlId = _this;
	private _display = findDisplay 5001;
	private _ctrl =  _display displayCtrl _ctrlId;
	_ctrl lbValue (lbCurSel _ctrl);
};

DCW_fnc_getValueChkBx = {
	private _ctrlId = _this;
	private _display = findDisplay 5001;
	private _ctrl =  _display displayCtrl _ctrlId;
	cbChecked  _ctrl;
};


//Faction render
DCW_fnc_rendersideselect = {
	params["_side","_ctrlId","_dependentFactionCtrlIds"];
    _display = findDisplay 5001;
	_factions = [_side] call DCW_fnc_factionlist;
	private _ctrlLoadout = _display displayCtrl _ctrlId;
	
	// Clear the select
	lbClear _ctrlLoadout;

	{
		_ctrlLoadout lbAdd  (_x call BIS_fnc_sideName);
		_ctrlLoadout lbSetValue [_forEachIndex ,_x call BIS_fnc_sideID];
		_ctrlLoadout lbSetColor [_forEachIndex,_x call BIS_fnc_sideColor];
		if (_x == _side) then { _ctrlLoadout lbSetCurSel _forEachIndex; };
	}foreach [west,east,resistance];

	{
		_ctrlLoadout ctrlAddEventHandler ["LBSelChanged",format["[(lbValue[ctrlIDC(_this select 0),_this select 1]) call BIS_fnc_sideType, %1] spawn DCW_fnc_renderfactionselect",_x]];
	} foreach _dependentFactionCtrlIds;
	_ctrlLoadout;
};


DCW_fnc_replaceAllCutsceneSoldiers = {
	params["_units","_cars"];
	// REPLACE LOADOUT OF ALL CUTSCENE SOLDIERS
	{  
		if (str _x find "DCW_cutscene_soldier" == 0  ) then {
			_x setUnitLoadout (getUnitLoadout(_units call BIS_fnc_selectRandom)); 
			[_x] joinSilent createGroup ((2111 call DCW_fnc_getValue) call BIS_fnc_sideType);
		}; 
	} foreach allUnits; 

    // REPLACE LOADOUT OF ALL CUTSCENE SOLDIERS
	{  
		if (str _x find "DCW_cutscene_car" == 0  ) then {
			_name = str _x ;
			hideObject _x;
			_pos = getPos _x;
			_objects =[_x,"ModuleRespawnVehicle_F"] call BIS_fnc_allSynchronizedObjects;
			waitUntil {isHidden _x};
			_vehicle = (_cars call BIS_fnc_selectRandom) createVehicle (getPos _x) ;
			_vehicle setDir (getDir _x);
			_vehicle setPos _pos;
			if (count _objects > 0 ) then {
				_respawnModule = _objects select 0;
				_respawnModule synchronizeObjectsAdd [_vehicle];
			};
			deleteVehicle _x;
			_vehicle setVehicleVarName _name;
		}; 
	} foreach allMissionObjects "Car"; 

};

//Faction render
DCW_fnc_renderfactionselect = {
	params["_side","_ctrlId"];

    _display = findDisplay 5001;
	_factions = [_side] call DCW_fnc_factionlist;
	private _ctrlLoadout = _display displayCtrl _ctrlId;

	// Clear the select
	lbClear _ctrlLoadout;

	{
		_ctrlLoadout lbAdd (_x select 0);
		_ctrlLoadout lbSetValue [_forEachIndex ,_forEachIndex];
		_ctrlLoadout lbSetData [_forEachIndex, _x select 1];
		_ctrlLoadout lbSetPicture [_forEachIndex,_x select 2];
	}foreach _factions;
	_ctrlLoadout lbSetCurSel 0;

	// A little correction
	if (_ctrlId == 2103 && _side == west) then {
		_ctrlLoadout lbAdd "Default (NATO)";
		_size = (lbSize _ctrlLoadout) - 1;
		_ctrlLoadout lbSetValue [_size ,_size];
		_ctrlLoadout lbSetCurSel (_size);
		_ctrlLoadout lbSetData [_size, (_factions select 0) select 1];
	};

	_ctrlLoadout
};


DCW_fnc_fillSupportParam = {
	params["_param", "_array"];
	if (count _array > 0) then {
		_param = _array;
	};
	_param;
};


DCW_fnc_pointTo = {
	params["_cam","_unit"];
	_cam camSetPos (_unit modelToWorld[1,3,.6]);
	_cam camSetTarget (_unit modelToWorld[.3,0,1.3]); 
	_cam camCommit 0.5;
};

DCW_fnc_save = {
	//Time of the day;
	TIME_OF_DAYS = 2100 call DCW_fnc_getValue;
	publicVariable "TIME_OF_DAYS";

	//Weather
	WEATHER = (2101 call DCW_fnc_getValue) / 100;
	publicVariable "WEATHER";

	//Time_selected;
	PERCENTAGE_OF_ENEMY_COMPOUND = (2102 call DCW_fnc_getValue);
	publicVariable "PERCENTAGE_OF_ENEMY_COMPOUND";

	//Revive
	MEDEVAC_ENABLED =  2104 call DCW_fnc_getValueChkBx;
	publicVariable "MEDEVAC_ENABLED";

	//Respawn
	RESPAWN_ENABLED =  2105 call DCW_fnc_getValueChkBx;
	publicVariable "RESPAWN_ENABLED";

	// Ammobox restricted
	RESTRICTED_AMMOBOX =  2106 call DCW_fnc_getValueChkBx;
	publicVariable "RESTRICTED_AMMOBOX";
	
	SIDE_FRIENDLY = (2111 call DCW_fnc_getValue) call BIS_fnc_sideType;
	publicVariable "SIDE_FRIENDLY";

	FACTION_FRIENDLY =  lbData [2113, (2113 call DCW_fnc_getValue)];
	publicVariable "FACTION_FRIENDLY";

	FACTION_PLAYER = lbData [2103, (2103 call DCW_fnc_getValue)];
	publicVariable "FACTION_PLAYER";

	FACTION_ENEMY = lbData [2108, (2108 call DCW_fnc_getValue)];
	publicVariable "FACTION_ENEMY";

	SIDE_ENEMY = (2107 call DCW_fnc_getValue) call BIS_fnc_sideType;
	publicVariable "SIDE_ENEMY";

	// Civilian faction
	FACTION_CIV = lbData [2110, (2110 call DCW_fnc_getValue)];
	publicVariable "FACTION_CIV";

	// Number of respawn
	NUMBER_RESPAWN = (2112 call DCW_fnc_getValue);
	publicVariable "NUMBER_RESPAWN";

	SHOW_SECTOR = 2122 call DCW_fnc_getValueChkBx;
	publicVariable "SHOW_SECTOR";

	if (SIDE_FRIENDLY == SIDE_ENEMY) exitWith{hintC "Choose a different enemy side !";false};

	true;
};

//Saving and close method;
DCW_fnc_saveAndGoToLoadoutDialog = {

	_result = [] call DCW_fnc_save;
	if (_result) then {
		//kill camera
		closeDialog 0;

		[] call DCW_fnc_openLoadoutDialog;
	};
   
};

DCW_fnc_chooseLocation = {
	_ctrlMap = ((findDisplay 5001) displayCtrl 122);
	_ctrlMap ctrlShow  true;
	ctrlSetFocus _ctrlMap;
	
	marker_setup = false;

	//move the marker to the click position
	player onMapSingleClick {
		if (surfaceIsWater _pos || !(_pos inArea "GAME_ZONE")) then {
			hint "Please, select a position on the ground";
		}else{
			"marker_base" setMarkerPos _pos;
			marker_setup = true;
		};
	};

	//clear the click handle
	waitUntil {marker_setup};
	marker_setup = false;
	
	_pos = getMarkerPos "marker_base";
	_pos = [_pos, 0, 250, 17, 0, .4, 0] call BIS_fnc_findSafePos;
	"marker_base" setMarkerPos _pos;
	START_POSITION = getMarkerPos "marker_base";
	START_POSITION set [2,0];
	
	publicVariableServer "START_POSITION";

	player onMapSingleClick "";
	sleep .1;
	
	_ctrlMap ctrlShow  false;
	
};

DCW_fnc_openLoadoutDialog = {
  	_ok = createDialog "LOADOUT_DIALOG"; 
    _display = findDisplay 5002;
	_noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
	[] call DCW_fnc_displayUnitName;
};

DCW_fnc_saveAndCloseConfigDialog = {

	//kill camera
	closeDialog 0;

	// Switch back to the group leader
	selectPlayer (leader GROUP_PLAYERS);

	//Sound back in
	2 fadeSound 1;

	[] spawn {

		// Delete the chopper
		if(!isNull CHOPPER_DEMO) then { { deleteVehicle _x; } foreach crew CHOPPER_DEMO; deleteVehicle CHOPPER_DEMO};

		titleCut [localize "STR_DCW_configDialogFunctions_preparing", "BLACK OUT", .5];
			
		sleep .5;

		titleCut [localize "STR_DCW_configDialogFunctions_preparing", "BLACK FADED", 999];

		// Execute mission setup on server
		[] remoteExec ["DCW_fnc_missionSetup", 2];
		
		CONFIG_CAMERA cameraeffect ["terminate", "back"];
		camDestroy CONFIG_CAMERA;
		//deleteVehicle UNIT_SHOWCASE;

	};
};  

CHOPPER_DEMO = objNull;
CHOPPER_DEMO_POS = (player modelToWorld[0,-21,0]);
DCW_fnc_displayChopper = {
	0 fadeSound 0;
	sleep .3;
	if(!isNull CHOPPER_DEMO) then { { deleteVehicle _x; } foreach crew CHOPPER_DEMO; deleteVehicle CHOPPER_DEMO;};
	sleep .3;
	_choppers = [lbData [2103, (2103 call DCW_fnc_getValue)], ["Helicopter"], "Transport"] call DCW_fnc_factionGetSupportUnits;
	if (count _choppers > 0) then {
		SUPPORT_MEDEVAC_CHOPPER_CLASS = _choppers;
		SUPPORT_TRANSPORT_CHOPPER_CLASS = _choppers;
		FRIENDLY_CHOPPER_CLASS = _choppers;
		CHOPPER_DEMO = (SUPPORT_MEDEVAC_CHOPPER_CLASS call BIS_fnc_selectRandom) createVehicle  CHOPPER_DEMO_POS;
		CHOPPER_DEMO setPos [getPos(CHOPPER_DEMO) select 0, getPos(CHOPPER_DEMO) select 1,0];
		CHOPPER_DEMO engineOn true;
		CHOPPER_DEMO allowDamage false;
		createVehicleCrew CHOPPER_DEMO;
		(driver CHOPPER_DEMO) stop true;
	};
};

DCW_fnc_switchUnit = {
	params["_dir"];

	_len = count (units GROUP_PLAYERS);
	_currentIndex = (units GROUP_PLAYERS) find UNIT_SHOWCASE;
	if (_dir == "next") then {
		if ((_len - 1) == _currentIndex ) then {_currentIndex = -1; };
		UNIT_SHOWCASE = (units GROUP_PLAYERS) select (_currentIndex + 1);
	} else {
		if (_currentIndex == 0 ) then {_currentIndex = _len; };
		UNIT_SHOWCASE = (units GROUP_PLAYERS) select (_currentIndex - 1);
	};
	
	// If player, you're not allowed to edit their loadout
	if (isPlayer UNIT_SHOWCASE && UNIT_SHOWCASE != leader GROUP_PLAYERS) then {
		[_dir] call DCW_fnc_switchUnit;
	};
	
	[] call DCW_fnc_displayUnitName;
	
	selectPlayer UNIT_SHOWCASE;
	[CONFIG_CAMERA,UNIT_SHOWCASE] call DCW_fnc_pointTo;
};

DCW_fnc_editLoadout = {

	camDestroy CONFIG_CAMERA;
	closeDialog 0;

	DCW_LOADOUT = true;
	publicVariable "DCW_LOADOUT";

	[ "Open", [ true ] ] spawn BIS_fnc_arsenal;
	
	[] spawn {
		sleep 1;
		[ "dcw-arsenalof", "onEachFrame", {
			if (isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ])) then {
				hintSilent "done";
				["dcw-arsenalof", "onEachFrame" ] call BIS_fnc_removeStackedEventHandler ;
				[] spawn DCW_fnc_initcamera;
				[] call DCW_fnc_openLoadoutDialog;
			}; 
		}] call BIS_fnc_addStackedEventHandler ;
	};
};

//Saving and close method;
DCW_fnc_switchFaction = {
	params["_ctrl","_val"];
	
	_factionName =  lbData [_ctrl,_val];
	_display = (findDisplay 5001);

	// Set the allied selector to the same faction by default
	(_display displayCtrl 2113)  lbSetCurSel (lbCurSel _ctrl);
	
	(_display displayCtrl _ctrl)  ctrlEnable false;
	(_display displayCtrl 2222)  ctrlEnable false;
	

	titleCut ["", "BLACK OUT", .3];

	//Weather
	_unitClasses = [_factionName,["Man"],[]] call DCW_fnc_factionGetUnits;
	_carClasses = [_factionName,["Car"],[]] call DCW_fnc_factionGetUnits;

	// If nothing found, take the default units
	if (count _unitClasses == 0) then {
		_unitClasses = FRIENDLY_LIST_UNITS
	};
	
	_grp = createGroup east;
	_phantoms = [];
	{
		_rndClass = _unitClasses call BIS_fnc_selectRandom;
		_phantomUnit = _grp createUnit [_rndClass, [0,0,0], [], 0, "FORM"];
		_phantoms pushBack _phantomUnit;
	} foreach units (group player);

	// Add a little time for 3CB to initialize correctly
	sleep 1;

	{ 
		_x setUnitLoadout(getUnitLoadout(_phantoms select _foreachIndex));
		deleteVehicle (_phantoms select _foreachIndex);
	} foreach units (group player);


	deleteGroup _grp;

	[] call DCW_fnc_displayChopper;
	[_unitClasses,_carClasses] call DCW_fnc_replaceAllCutsceneSoldiers;
 
	titleCut ["", "BLACK IN", 2];

	sleep .3;

	(_display displayCtrl _ctrl)  ctrlEnable true;
	(_display displayCtrl 2222)  ctrlEnable true;

	disableSerialization;

};

DCW_fnc_displayUnitName ={
	_ctrl = ((findDisplay 5001) displayCtrl 4444) ;
	 //getText(configfile >> "CfgVehicles" >> typeOf UNIT_SHOWCASE >> "displayName")
	_text = format["%1 %2", name UNIT_SHOWCASE,if ( UNIT_SHOWCASE == leader GROUP_PLAYERS ) then {"(player)"} else { "" }];
    ctrlSetText [4444,_text];
};

DCW_fnc_initcamera = {
	CONFIG_CAMERA = "camera" camcreate (getPos UNIT_SHOWCASE);
	CONFIG_CAMERA cameraeffect ["internal", "back"];
	showCinemaBorder false;
	[CONFIG_CAMERA, UNIT_SHOWCASE] call DCW_fnc_pointTo;
};



DCW_fnc_openConfigDialog = {
	_ok = createDialog "PARAMETERS_DIALOG"; 
	_display = findDisplay 5001;
	_noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
	
	// Hide the map by default
	_ctrlMap = (_display displayCtrl 122);
	_ctrlMap ctrlShow false;

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

	_ctrlListPopulation lbAdd "Highest (50%)";
	_ctrlListPopulation lbSetValue  [0,50];
	_ctrlListPopulation lbAdd "High (25%)";
	_ctrlListPopulation lbSetValue  [1,25];
	_ctrlListPopulation lbAdd  "Standard (5%)";
	_ctrlListPopulation lbSetValue  [2,5];
	_ctrlListPopulation lbAdd "Low (3%)";
	_ctrlListPopulation lbSetValue  [3,3];
	_ctrlListPopulation lbSetCurSel  2;


	//Weather
	private _ctrlListResp = _display displayCtrl 2112;
	_ctrlListResp lbAdd "None";
	_ctrlListResp lbSetValue  [0,0];
	_ctrlListResp lbAdd  "4";
	_ctrlListResp lbSetValue  [1,4];
	_ctrlListResp lbAdd "10";
	_ctrlListResp lbSetValue  [2,10];
	_ctrlListResp lbAdd "40";
	_ctrlListResp lbSetValue  [3,40];
	_ctrlListResp lbAdd "Infinite";
	_ctrlListResp lbSetValue  [4,-1];
	_ctrlListResp lbSetCurSel  1;

	//Data
	private _ctrlReviveOn = _display displayCtrl 2104;
	_ctrlReviveOn cbSetChecked true;

	//Respawn
	private _ctrlRespawnOn = _display displayCtrl 2105;
	_ctrlRespawnOn cbSetChecked true;

	//Respawn
	private _ctrlAmmoOn = _display displayCtrl 2106;
	_ctrlAmmoOn cbSetChecked true;

	//Respawn
	private _ctrlShowSector = _display displayCtrl 2122;
	_ctrlShowSector cbSetChecked true;

	

	[SIDE_FRIENDLY,2111,[2103,2113]] call DCW_fnc_rendersideselect;

	[SIDE_ENEMY,2107,[2108]] call DCW_fnc_rendersideselect;

	[SIDE_ENEMY,2108] call DCW_fnc_renderfactionselect ;

	_factionSelect = [SIDE_FRIENDLY,2103] call DCW_fnc_renderfactionselect ;
	_factionSelect ctrlAddEventHandler ["LBSelChanged","[ctrlIDC(_this select 0),_this select 1] spawn DCW_fnc_switchFaction"];

	_factionSelectFr = [SIDE_FRIENDLY,2113] call DCW_fnc_renderfactionselect;
	_factionSelectFr lbSetCurSel 1; // Select FIA by default

	[SIDE_CIV,2110] call DCW_fnc_renderfactionselect ;

	[] call DCW_fnc_displayChopper;
};
