/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params["_initialPos","_player"];

if (!RESPAWN_ENABLED)then {
	NUMBER_RESPAWN = 0;
	REMAINING_RESPAWN = 0;
};

REMAINING_RESPAWN = NUMBER_RESPAWN;
RESPAWN_POSITION = _initialPos;
PLAYER_ALIVE = true;

//Default trait
_player setUnitTrait ["explosiveSpecialist",true];

//Support UI
if (LEADER_PLAYERS == _player) then {

	//Rest animations
	[_player] execVM "DCW\fnc\Behavior\Rest.sqf";

	// Revive friendlies with chopper pick up
	if (REVIVE_ENABLED) then{
		[_player] execVM "DCW\medevac\init.sqf";
	};

	nul = [LEADER_PLAYERS] call fnc_supportuiInit;
};

//Damage handler
if (RESPAWN_ENABLED) then{
	_player addEventHandler["HandleDamage",{
		params [
			"_unit",			// Object the event handler is assigned to.
			"_hitSelection",	// Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
			"_damage",			// Resulting level of damage for the selection.
			"_source",			// The source unit (shooter) that caused the damage.
			"_projectile",		// Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.) (String)
			"_hitPartIndex",	// Hit part index of the hit point, -1 otherwise.
			"_instigator",		// Person who pulled the trigger. (Object)
			"_hitPoint"			// hit point Cfg name (String)
		];

		if (_damage > .95 && NUMBER_RESPAWN >= 1 && PLAYER_ALIVE)then{
			PLAYER_ALIVE = false;
			_unit setUnconscious true;
			addCamShake [15, 5, 0.7];
			[_unit] spawn fnc_HandleRespawn;
			_damage = .95;
			_unit setDamage .95;
		}else{
			if (!PLAYER_ALIVE)then{
				_damage = .95;
				_unit playActionNow "agonyStart";
				_unit setDamage .95;
			}
		};
		
		_damage;
	}];
}else{
	_player addMPEventHandler ["MPKilled",{
		params [
			"_unit"			// Object the event handler is assigned to.
		];
		PLAYER_ALIVE = false;
	}];
};

//Respawn handling
fnc_HandleRespawn =
{
	params["_unit"];
	_loadout = getUnitLoadout _unit;

	waitUntil{!PLAYER_ALIVE};

	//count the remaining lives after death
	REMAINING_RESPAWN = REMAINING_RESPAWN - 1;

	if (REMAINING_RESPAWN == -1)exitWith{endMission "KILLED";};
	
	cutText ["You are severly injured","BLACK OUT", 7];
	sleep 7;
	_unit setUnconscious false;

	_timeSkipped = round(6 + random 12);
	cutText ["You are severly injured","BLACK FADED", 999];

	// Move the alive AI unit back to position
	{ 
		if(alive _x && !isPlayer _x && LEADER_PLAYERS == _unit) then{
			_x setPos ([RESPAWN_POSITION, 5 ,60, 3, 0, 20, 0] call BIS_fnc_FindSafePos)
		}; 
	}foreach  units (group _unit);

	sleep 1;
	_unit switchMove "Acts_UnconsciousStandUp_part1";

	//Disable chasing
	CHASER_TRIGGERED = false; 
	PLAYER_ALIVE = true;
    resetCamShake;

	//Set new pos and loadout
	_unit setDamage 0;
	_unit setPos RESPAWN_POSITION;
	_unit setUnitLoadout _loadout;

	//Black screen with timer...
	sleep 2;
	cutText ["You are severly injured","BLACK FADED", 999];
	
	BIS_DeathBlur ppEffectAdjust [0.0];
	BIS_DeathBlur ppEffectCommit 0;
	cutText ["You are severly injured","BLACK FADED", 999];
	
    if (!isMultiplayer) then {
		skipTime 6 + random 12;
	};
	sleep 5;
	[worldName, "Back to camp",format["%1 hours later...",_timeSkipped], format ["%1 live%2 left",REMAINING_RESPAWN,if (REMAINING_RESPAWN <= 1) then {""}else{"s"}]] call BIS_fnc_infoText;
	cutText ["","BLACK IN", 4];
	"dynamicBlur" ppEffectEnable true;   
	"dynamicBlur" ppEffectAdjust [6];   
	"dynamicBlur" ppEffectCommit 0;     
	"dynamicBlur" ppEffectAdjust [0.0];  
	"dynamicBlur" ppEffectCommit 5;  
	[] call PLAYER_KIA;
};
