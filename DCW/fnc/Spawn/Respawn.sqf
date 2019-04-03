/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_player"];


if (!RESPAWN_ENABLED)then {
	NUMBER_RESPAWN = 0;
	REMAINING_RESPAWN = 0;
};

RESPAWN_CHOICE = "";
REMAINING_RESPAWN = NUMBER_RESPAWN;

publicVariable "INITIAL_RESPAWN_POSITION";

PLAYER_ALIVE = true;

//Default trait
_player setUnitTrait ["explosiveSpecialist",true];

//Rest animations
[_player] call fnc_rest;

//Squad leader specific
if ((leader GROUP_PLAYERS) == _player) then {

	// Revive friendlies with chopper pick up
	if (REVIVE_ENABLED) then{
		[_player] execVM "DCW\medevac\init.sqf";
	};

	[_player] call fnc_camp;
	[_player] call fnc_supportuiInit;
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

		if (_damage > .96 && NUMBER_RESPAWN >= 1 && PLAYER_ALIVE)then{
			PLAYER_ALIVE = false;
			_unit setUnconscious true;
			addCamShake [15, 5, 0.7];
			[_unit] spawn fnc_HandleRespawn;
			_damage = .96;
			_unit setDamage .96;
		}else{
			if (!PLAYER_ALIVE)then{
				_damage = .96;
				_unit playActionNow "agonyStart";
				_unit setDamage .96;
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
	 
	 // Corrected player rating
	 if (rating _unit < 0) then {
		_unit addRating ((-(rating _unit)) + 1000);
	};

	//count the remaining lives after death
	REMAINING_RESPAWN = REMAINING_RESPAWN - 1;
	if (REMAINING_RESPAWN == -1)exitWith{ endMission "KILLED"; };
	
	cutText ["You are severly injured","BLACK OUT", 7];
	sleep 7;
	_unit setUnconscious false;

	_timeSkipped = round(6 + random 12);
	cutText ["You are severly injured","BLACK FADED", 999];
	sleep 2;
	cutText ["","BLACK FADED",  999];
	[] call fnc_respawndialog;
	waitUntil{RESPAWN_CHOICE != ""};
	cutText [format["Back to %1...",RESPAWN_CHOICE],"BLACK FADED", 999];
	sleep 1;
	
	// Move the alive AI unit back to position
	private _respawnPos = if (RESPAWN_CHOICE == "base") then {INITIAL_RESPAWN_POSITION} else {CAMP_RESPAWN_POSITION};
	RESPAWN_CHOICE = ""; // Reset

	if (!isMultiplayer) then {
		{ 
			if(!isPlayer _x && (leader GROUP_PLAYERS) == _unit) then{
				_x setPos ([_respawnPos, 5 ,60, 3, 0, 20, 0] call BIS_fnc_FindSafePos)
			}; 
		}foreach  units (group _unit);
	};

	sleep 1;

	[_unit,"Acts_UnconsciousStandUp_part1"] remoteExec ["switchMove",0];

	//Disable chasing if not in multiplayer
	if (!isMultiplayer) then{
		CHASER_TRIGGERED = false;
		publicVariable "CHASER_TRIGGERED";
	}; 
	PLAYER_ALIVE = true;
    resetCamShake;

	//Set new pos and loadout
	_unit setDamage 0;
	_unit setPos _respawnPos;
	_unit setUnitLoadout _loadout;

	//Black screen with timer...
	sleep 2;
	cutText ["","BLACK FADED", 999];
	
	BIS_DeathBlur ppEffectAdjust [0.0];
	BIS_DeathBlur ppEffectCommit 0;
	cutText ["","BLACK FADED", 999];
	
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
