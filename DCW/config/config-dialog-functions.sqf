
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


//Faction render
fnc_rendersideselect = {
	params["_side","_ctrlId","_dependentFactionCtrlIds"];
    _display = findDisplay 5001;
	_factions = [_side] call fnc_factionlist;
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
		_ctrlLoadout ctrlAddEventHandler ["LBSelChanged",format["[(lbValue[ctrlIDC(_this select 0),_this select 1]) call BIS_fnc_sideType, %1] spawn fnc_renderfactionselect",_x]];
	} foreach _dependentFactionCtrlIds;
	_ctrlLoadout;
};


fnc_replaceAllCutsceneSoldiers = {
	params["_units"];
	// REPLACE LOADOUT OF ALL CUTSCENE SOLDIERS
	{  
		if (str _x find "DCW_cutscene_soldier" == 0  ) then {
			_x setUnitLoadout (getUnitLoadout(_units call BIS_fnc_selectRandom)); 
		}; 
	} foreach allUnits; 

};

//Faction render
fnc_renderfactionselect = {
	params["_side","_ctrlId"];

    _display = findDisplay 5001;
	_factions = [_side] call fnc_factionlist;
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
	if (_ctrlId == 2103) then {
		_ctrlLoadout lbAdd "default";
		_size = (lbSize _ctrlLoadout) - 1;
		_ctrlLoadout lbSetValue [_size ,_size];
		_ctrlLoadout lbSetCurSel (_size);
		_ctrlLoadout lbSetData [_size, (_factions select 0) select 1];
	};

	_ctrlLoadout
};


fnc_fillSupportParam = {
	params["_param", "_array"];
	if (count _array > 0) then {
		_param = _array;
	};
	_param;
};


fnc_pointTo = {
	params["_cam","_unit"];
	_cam camSetPos (_unit modelToWorld[1,3,.6]);
	_cam camSetTarget (_unit modelToWorld[.3,0,1.3]); 
	_cam camCommit 0.5;
};

//Saving and close method;
fnc_SaveAndGoToLoadoutDialog = {

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
	
	SIDE_FRIENDLY = (2111 call fnc_getValue) call BIS_fnc_sideType;
	publicVariable "SIDE_FRIENDLY";

	FACTION_FRIENDLY =  lbData [2113, (2113 call fnc_getValue)];
	publicVariable "FACTION_FRIENDLY";

	FACTION_PLAYER = lbData [2103, (2103 call fnc_getValue)];
	publicVariable "FACTION_PLAYER";

	FACTION_ENEMY = lbData [2108, (2108 call fnc_getValue)];
	publicVariable "FACTION_ENEMY";

	SIDE_ENEMY = (2107 call fnc_getValue) call BIS_fnc_sideType;
	publicVariable "SIDE_ENEMY";

	// Civilian faction
	FACTION_CIV = lbData [2110, (2110 call fnc_getValue)];
	publicVariable "FACTION_CIV";

	// Number of respawn
	NUMBER_RESPAWN = (2112 call fnc_getValue);
	publicVariable "NUMBER_RESPAWN";



	//kill camera
	closeDialog 0;

	[] call fnc_openLoadoutDialog;
   
};

fnc_openLoadoutDialog = {
  	_ok = createDialog "LOADOUT_DIALOG"; 
    _display = findDisplay 5001;
	_noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
	[] call fnc_displayUnitName;
};

fnc_SaveAndCloseConfigDialog = {

	//kill camera
	closeDialog 0;

	// Switch back to the group leader
	selectPlayer (leader GROUP_PLAYERS);

	//Sound back in
	2 fadeSound 1;

	[] spawn {
		{
			_x addItem "MineDetector";
			if (ACE_ENABLED) then {
				_x addItem "ACE_DefusalKit";
				_x addItem "ACE_EarPlugs";
			} else {
				_x addItem "ToolKit";
			};
		}foreach units GROUP_PLAYERS;

		// Delete the chopper
		if(!isNull CHOPPER_DEMO) then { { deleteVehicle _x; } foreach crew CHOPPER_DEMO; deleteVehicle CHOPPER_DEMO};

		titleCut ["Preparing units...", "BLACK OUT", .5];
		sleep .5;
		titleCut ["Preparing units...", "BLACK FADED", 999];
		[] call fnc_missionsetup;
		
		CONFIG_CAMERA cameraeffect ["terminate", "back"];
		camDestroy CONFIG_CAMERA;
		//deleteVehicle UNIT_SHOWCASE;
		DCW_STARTED = true;
		publicVariable "DCW_STARTED";

	};
};

CHOPPER_DEMO = objNull;

fnc_DisplayChopper = {
	0 fadeSound 0;
	if(!isNull CHOPPER_DEMO) then { { deleteVehicle _x; } foreach crew CHOPPER_DEMO;deleteVehicle CHOPPER_DEMO};
	sleep .4;
	SUPPORT_MEDEVAC_CHOPPER_CLASS = [SUPPORT_MEDEVAC_CHOPPER_CLASS,[lbData [2103, (2103 call fnc_getValue)], ["Helicopter"], "Transport"] call fnc_FactionGetSupportUnits] call fnc_fillSupportParam;
  	CHOPPER_DEMO = ( SUPPORT_MEDEVAC_CHOPPER_CLASS call BIS_fnc_selectRandom) createVehicle  (player modelToWorld[0,-21,0]);

	CHOPPER_DEMO setPos [getPos(CHOPPER_DEMO) select 0, getPos(CHOPPER_DEMO) select 1,0];
	CHOPPER_DEMO engineOn true;
	(driver CHOPPER_DEMO) stop true;
};

fnc_SwitchUnit = {
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
		[_dir] call fnc_switchUnit;
	};
	
	[] call fnc_displayUnitName;
	
	selectPlayer UNIT_SHOWCASE;
	[CONFIG_CAMERA,UNIT_SHOWCASE] call fnc_pointTo;
};

fnc_editLoadout = {
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
				[] spawn fnc_initcamera;
				[] call fnc_openLoadoutDialog;
			}; 
		}] call BIS_fnc_addStackedEventHandler ;
	};
};

//Saving and close method;
fnc_SwitchFaction = {
	params["_ctrl","_val"];
	
	_factionName =  lbData [_ctrl,_val];
	

	// Set the allied selector to the same faction by default
	((findDisplay 5001) displayCtrl 2113)  lbSetCurSel (lbCurSel _ctrl);
	
	((findDisplay 5001) displayCtrl _ctrl)  ctrlEnable false;

	titleCut ["", "BLACK OUT", .3];

	//Weather
	_unitClasses = [_factionName,["Man"],[]] call fnc_FactionGetUnits;
	if (count _unitClasses > 0) then {
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
	};

	[] call fnc_DisplayChopper;
	[_unitClasses] call fnc_replaceAllCutsceneSoldiers;
 
	titleCut ["", "BLACK IN", 2];

	sleep .3;

	((findDisplay 5001) displayCtrl _ctrl)  ctrlEnable true;

	disableSerialization;

};

fnc_displayUnitName ={
	_ctrl = ((findDisplay 5001) displayCtrl 4444) ;
	 //getText(configfile >> "CfgVehicles" >> typeOf UNIT_SHOWCASE >> "displayName")
	_text = format["%1 %2", name UNIT_SHOWCASE,if ( UNIT_SHOWCASE == leader GROUP_PLAYERS ) then {"(player)"} else { "" }];
    ctrlSetText [4444,_text];
};

fnc_initcamera = {
	CONFIG_CAMERA = "camera" camcreate (getPos UNIT_SHOWCASE);
	CONFIG_CAMERA cameraeffect ["internal", "back"];
	showCinemaBorder false;
	[CONFIG_CAMERA, UNIT_SHOWCASE] call fnc_pointTo;
};
