params["_initialPos"];

RESPAWN_POSITION = _initialPos;
for "_i" from 0 to NUMBER_RESPAWN do
{
	_loadout = getUnitLoadout player;
	player setUnitTrait ["explosiveSpecialist",true];
	[player] execVM "insurgent_hunt\fnc\rest.sqf";
	nul = [player] execVM "supportui\init.sqf";

	waitUntil
	{
		!alive player;
	};

	if (_i == NUMBER_RESPAWN)then{
		endMission "KILLED";
	};

	_timeSkipped = round(6 + random 12);
	cutText ["You are dead","BLACK FADED", 999];
	_score = player getVariable ["IH_SCORE",0];
	_units = units (group player);
	{ if(alive _x) then{_x setPos ([RESPAWN_POSITION, 5 ,60, 3, 0, 20, 0] call BIS_fnc_findSafePos)}; }foreach _units;
	(typeof player) createUnit [RESPAWN_POSITION, group player, "newUnit = this; "];
	sleep 1;
	newUnit setPos RESPAWN_POSITION;
	newUnit setUnitLoadout _loadout;
	newUnit setVariable["IH_SCORE",_score];
	addSwitchableUnit newUnit;
	selectPlayer newUnit;
	_units joinSilent newUnit;
	group(newUnit) selectLeader newUnit;
	sleep 1;
	cutText ["You are dead","BLACK FADED", 999];
	newUnit switchMove "Acts_UnconsciousStandUp_part1";
	BIS_DeathBlur ppEffectAdjust [0.0];
	BIS_DeathBlur ppEffectCommit 0;
	cutText ["You are dead","BLACK FADED", 999];
	skipTime 6 + random 12;
	sleep 5;
	[worldName, "Back to camp",format["%1 hours later...",_timeSkipped], format ["%1 live%2 left",(NUMBER_RESPAWN-_i),if ((NUMBER_RESPAWN-_i) <= 1) then {""}else{"s"}]] call BIS_fnc_infoText;
	cutText ["","BLACK IN", 4];
	"dynamicBlur" ppEffectEnable true;   
	"dynamicBlur" ppEffectAdjust [6];   
	"dynamicBlur" ppEffectCommit 0;     
	"dynamicBlur" ppEffectAdjust [0.0];  
	"dynamicBlur" ppEffectCommit 5;  
	[] call PLAYER_KIA;
};

//Anyway => The end of the mission, we consumed all out lives
["epicFail",false,2] call BIS_fnc_endMission;
