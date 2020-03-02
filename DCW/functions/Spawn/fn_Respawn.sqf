/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    This function enable the respawning features on the player
	This must be executed on client side

  Parameters:
    0: OBJECT - Player
*/

params ["_player"];

if (!RESPAWN_ENABLED)then {
	NUMBER_RESPAWN = 0;
	REMAINING_RESPAWN = 0;
};
 
[_player] spawn DCW_fnc_surrenderSystem;

RESPAWN_CHOICE = "";
REMAINING_RESPAWN = NUMBER_RESPAWN;

if ((leader GROUP_PLAYERS) == _player) then {
	_player remoteExec ["removeAllActions"];
	sleep .3;
	_player call DCW_fnc_actionCamp;
	_player call DCW_fnc_addSupportUi;
};

DCW_fnc_handleRespawnBase = {
	params["_unit"];
    resetCamShake;
	// Remove units around the player
	{ if (_unit distance _x < 120 && side _x == SIDE_ENEMY) then {_x setDamage 1;} } foreach allUnits;


	// Set the group leader as a human if he is an AI
	if (!isPlayer (leader GROUP_PLAYERS)) then {
		GROUP_PLAYERS selectLeader _unit;
	};

	// Create a basic hidden marker on player's position (Used for blacklisting purposes)
	_pm = createMarker [format["player-marker-%1",name _unit], getPos _unit];
	_pm setMarkerShape "ELLIPSE";
	_pm setMarkerColor "ColorGreen";
	_pm setMarkerAlpha 0;
	_pm setMarkerSize [200,200];
	if (DEBUG) then {
		_pm setMarkerAlpha .3;
	};
	_unit setVariable["marker", _pm, true];

	// Initial score display
	_unit call DCW_fnc_resetState;
	
	[] call DCW_fnc_displayscore;
};

//Respawn handling
// Singleplayer
DCW_fnc_handleRespawnSingleplayer =
{
	params["_unit"];

	_loadout = getUnitLoadout _unit;
	
	// Check the unit state before anything
	waitUntil{ lifestate _unit == "INCAPACITATED" };
	
	addCamShake [5,999,1.5];
	
	sleep 3;

	// Injured soldiers
	[_unit] call DCW_fnc_injured;
	 
	// The player is alive !
	if (lifestate _unit == "HEALTHY") exitWith {};
	
	//count the remaining lives after death
	REMAINING_RESPAWN = REMAINING_RESPAWN - 1;
	if (REMAINING_RESPAWN == -1) exitWith { endMission "LOSER"; };

	// Initial score display
	[] call DCW_fnc_displayscore;

	_unit allowDamage false;
	cutText ["Respawning...","BLACK OUT", 2];
	sleep 2;
	
	_timeSkipped = round(6 + random 12);
	cutText ["Respawning...","BLACK FADED", 999];
	sleep 2;
	cutText ["","BLACK FADED",  999];
	[] call DCW_fnc_respawndialog;
	waitUntil{ RESPAWN_CHOICE != "" };
	cutText [format["Back to %1...", RESPAWN_CHOICE], "BLACK FADED", 999];
	sleep 2;
	
	// Move the alive AI unit back to position
	private _respawnPos = if (RESPAWN_CHOICE == "base") then {START_POSITION} else {CAMP_RESPAWN_POSITION};
	RESPAWN_CHOICE = ""; // Reset
	
	sleep 1;

	//Disable chasing if not in multiplayer
	if (!isMultiplayer) then{
		CHASER_TRIGGERED = false;
		publicVariable "CHASER_TRIGGERED";
	}; 

	[_unit] call DCW_fnc_handleRespawnBase;

	if (ACE_ENABLED) then {
		[objNull, _unit] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
	};

	_unit setUnitLoadout _loadout;

	//Black screen with timer...
	cutText ["","BLACK FADED", 999];
	
	BIS_DeathBlur ppEffectAdjust [0.0];
	BIS_DeathBlur ppEffectCommit 0;

	cutText ["","BLACK FADED", 999];
	
    if (!isMultiplayer) then {
		skipTime 6 + random 12;
	};
	
	
	GROUP_PLAYERS selectLeader _unit;
	{ 
		if (!(isPlayer _x) && (leader GROUP_PLAYERS) == _unit) then{
			_x call DCW_fnc_resetState;
			_x setPos ([_respawnPos, 0 ,10, 1, 0, 20, 0] call BIS_fnc_findSafePos);
		}; 
	} foreach units GROUP_PLAYERS;
	_unit setPos _respawnPos;

	sleep 5;
	[worldName, "Back to camp", format["%1 hours later...",_timeSkipped], format ["%1 live%2 left",REMAINING_RESPAWN,if (REMAINING_RESPAWN <= 1) then {""}else{"s"}]] call BIS_fnc_infoText;
	cutText ["","BLACK IN", 4];
	"dynamicBlur" ppEffectEnable true;   
	"dynamicBlur" ppEffectAdjust [6];   
	"dynamicBlur" ppEffectCommit 0;     
	"dynamicBlur" ppEffectAdjust [0.0];  
	"dynamicBlur" ppEffectCommit 5;  
	[] remoteExec ["PLAYER_KIA",2];
	
	sleep 5;
	_unit setVariable["DCW_unit_injured",false,true] ;
	_unit setCaptive false;
	_unit allowDamage true;
};


//Damage handler
if (RESPAWN_ENABLED) then{

	if (isMultiplayer) then {
		// Add tickets to the player
		if (NUMBER_RESPAWN != -1) then {
			[_player, NUMBER_RESPAWN, false] call BIS_fnc_respawnTickets;
		};
		REMAINING_RESPAWN = NUMBER_RESPAWN;

		[SIDE_FRIENDLY, getMarkerPos "marker_base","Base"] call BIS_fnc_addRespawnPosition;
		
		[_player] call DCW_fnc_handleRespawnBase;

	    _player addMPEventHandler ["MPRespawn", {
			params ["_unit", "_corpse"];
			_unit spawn DCW_fnc_resetState;
			[_unit, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;
			_unit setVariable["marker", MARKER_PLAYER, true];
			if (NUMBER_RESPAWN != -1) then {
				REMAINING_RESPAWN = [_unit,nil,true] call BIS_fnc_respawnTickets;
			};
			[_unit] spawn DCW_fnc_handleRespawnBase;
		}];

		_player addMPEventHandler ["MPKilled",{
			params ["_unit"	];
			[_unit, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
			[] remoteExec ["PLAYER_KIA",2];
			// Delete the marker with a little delay
			if (REMAINING_RESPAWN == 0)exitWith{  endMission "LOSER";  };
			[_unit] spawn {
				params["_unit"];
				sleep 10;
				_unit call DCW_fnc_deletemarker;
			};
		}];

		// Prevent ACE to do bullshit
		_player removeAllEventHandlers "HandleDamage";
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

			// Reducing damage with a factor of 3
			if (_damage >= .9 && lifeState _unit != "INCAPACITATED" )then{
				_unit setUnconscious true;
				_unit setVariable ["DCW_unit_injured",true,true];
				addCamShake [15, 6, 0.7];
				_damage = .9;
				_unit setDamage .9;
					// Injured soldiers
				[_unit] spawn DCW_fnc_injured;
			} else {
				if (lifeState _unit == "INCAPACITATED")then{
					_damage = .9;
					_unit setDamage .9;
				};
			};
			_damage;
		}];

	} else {
		
		// Disable team switching
		enableTeamSwitch false;

		// In Singleplayer
		[_player] call DCW_fnc_handleRespawnBase;

		// Prevent ACE to do bullshit
		_player removeAllEventHandlers "HandleDamage";
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

			// Reducing damage with a factor of 3
			if (_damage >= .9 && lifeState _unit != "INCAPACITATED" )then{
				_unit setUnconscious true;
				_unit setVariable ["DCW_unit_injured",true,true];
				addCamShake [15, 6, 0.7];
				_damage = .9;
				_unit setDamage .9;
				[_unit] spawn DCW_fnc_handleRespawnSinglePlayer;
			} else {
				if (lifeState _unit == "INCAPACITATED")then{
					_damage = .9;
					_unit setDamage .9;
				};
			};
			
			_damage;
		}];
	};
}else{
	// If nothing activated, just use the vanilla system
	_player addMPEventHandler ["MPKilled",{
		params ["_unit"];
		[] remoteExec ["PLAYER_KIA",2];
	}];
};

