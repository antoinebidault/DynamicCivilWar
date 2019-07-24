/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Show the respawn dialog and wait for the player choice

  Parameters:
    0: OBJECT - Player
*/


disableSerialization;

 _ok = createDialog "RESPAWN_DIALOG"; 
 _display = findDisplay 5002;
 _noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
 _ctrlRespawnCamp = _display displayCtrl 4101;
 _ctrlRespawnBase = _display displayCtrl 4102;

 // TODO => Transform it in a select with all respawn points in "BIS_fnc_getRespawnPositions"

// Check respawn state
while {dialog} do {
	if (CAMP_RESPAWN_POSITION isEqualTo []) then { _ctrlRespawnCamp ctrlEnable false; };
	if (START_POSITION isEqualTo []) then { _ctrlRespawnBase ctrlEnable false; };
	sleep 1;
};

noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];