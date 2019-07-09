disableSerialization;

private _ok = createDialog "RESPAWN_DIALOG"; 
private _display = findDisplay 5002;
private _noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
private _ctrlRespawnCamp = _display displayCtrl 4101;
private _ctrlRespawnBase = _display displayCtrl 4102;

// Check respawn state
while {dialog} do {
	if (CAMP_RESPAWN_POSITION isEqualTo []) then { _ctrlRespawnCamp ctrlEnable false; };
	if (START_POSITION isEqualTo []) then { _ctrlRespawnBase ctrlEnable false; };
	sleep 1;
};

noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];