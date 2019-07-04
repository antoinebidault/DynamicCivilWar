/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Revive system
 */
_group = _this select 0;

// Replacement team event handling
{	
	if (!isPlayer(_x))then{
		_x setskill 1;
		_x setUnitAbility 1;
		_x allowFleeing 0;
		_x setskill ["aimingAccuracy", 1];
		_x setskill ["aimingShake", 1];
		_x setskill ["aimingSpeed", 1];
		_x setskill ["spotDistance", 1];
		_x setskill ["spotTime", 1];
		_x setskill ["commanding", 1];
		_x setskill ["courage", 1];
		_x setskill ["general", 1];
		_x setskill ["reloadSpeed", 1];
		_x remoteExec ["removeAllEventHandlers", owner _x];
		[_x, ["HandleDamage",{_this call DCW_fnc_handleDamage;}]] remoteExec ["addEventHandler", owner _x];
		_x addMPEventHandler ["MPKilled",{_this call DCW_fnc_handleKilled;}];
	};
}foreach (units _group);



/*

REVIVETIME_INSECONDS = 10;
_transportHelo = objNull;
_posChopper = objNull;
_supportHeli = 1000;

private _soldiersDead = [];

MEDEVAC_State = "standby"; // standby/menu/map/inbound/aborted
MEDEVAC_MENU_LASTID = 0;
MEDEVAC_marker = "";
MEDEVAC_action = "";
MEDEVAC_SmokeShell = objNull;

_leader = leader(_group);
_supportHeliMenuId = 0;
while {true} do {

	//Push dead soldiers
	_soldiersDead = units _group select { _x getVariable["unit_KIA",false] };
	
	// If leader
	if (isPlayer (leader(_group)) && alive (leader(_group)) && _leader != leader(_group)) then {
		hint "switching MEDEVAC leader";
		_leader = leader(_group);
		if (!isMultiplayer) then {
			[_leader,_soldiersDead] call DCW_fnc_caller;
		};
	};

	//Launch chopper
	if (MEDEVAC_State == "map")then{

		MEDEVAC_marker = "";

		deleteMarker "medevac_marker";

		[HQ,"We're waiting now for your mark on the map !",true] remoteExec ["DCW_fnc_talk"];

		//open the map
		if ((count _soldiersDead > 0) && isPlayer _leader) then {
			[[_leader],{
				params["_leader"];
	    		 openMap  true;

				//move the marker to the click position
				onMapSingleClick {
					MEDEVAC_marker = createMarkerLocal ["medevac_marker",_pos];
					MEDEVAC_marker setMarkerColorLocal "ColorBlack";
					MEDEVAC_marker setMarkerShapeLocal "ELLIPSE";
					MEDEVAC_marker setMarkerBrushLocal "Solid";
					MEDEVAC_marker setMarkerSizeLocal [13, 13];
				};

				//clear the click handle
				waitUntil {MEDEVAC_marker != ""|| !alive _leader};
				publicVariableServer "MEDEVAC_marker";
				
				MEDEVAC_State = "pointselected";
				publicVariableServer "MEDEVAC_State";

				_leader onMapSingleClick "";
				[HQ,"I copy!",true] remoteExec ["DCW_fnc_talk"];
				sleep 1;
				openMap false;

			 }] remoteExec ["spawn",_leader,false];

			waitUntil {sleep 3;MEDEVAC_State == "pointselected"};
			MEDEVAC_State = "inbound";
			[_leader,_soldiersDead] call DCW_fnc_caller;

			// Chopper spawning
			_transportHelo = [_group] call DCW_fnc_spawnHelo;
			_posChopper = position _transportHelo;

			// Startup the chopper path
			[group _transportHelo,getMarkerPos "medevac_marker",_transportHelo,_group] spawn DCW_fnc_chopperPath;
		};
	};

	//StandBy
	if (isNull _transportHelo && count _soldiersDead > 0 && MEDEVAC_State == "standby")then{
		MEDEVAC_State = "menu";
		[_leader,_soldiersDead] call DCW_fnc_caller;
	}else{
		if (MEDEVAC_State == "succeeded") then {
			[HQ,"Medevac mission succeeded",true] remoteExec ["DCW_fnc_talk"];
			[_transportHelo,_group] call DCW_fnc_deleteMedevac;
			MEDEVAC_State = "standby";
			sleep 120;
		} else {
			if (MEDEVAC_State == "aborted") then {
				[HQ,"Medevac mission aborted",true] remoteExec ["DCW_fnc_talk"];
				_transportHelo move _posChopper;
				sleep 120;
				[_transportHelo,_group] call DCW_fnc_deleteMedevac;
				MEDEVAC_State = "standby";
			} else {
				if (MEDEVAC_State == "inbound" && (!alive _transportHelo || damage _transportHelo > .6)) then {
					[HQ,"The chopper is destroyed ! MEDEVAC helicopter available in 2 minutes",true] remoteExec ["DCW_fnc_talk"];
					sleep 120;	
					[_transportHelo,_group] call DCW_fnc_deleteMedevac;
					MEDEVAC_State = "standby";
				};
			};
		};
	};
	sleep 3;
};*/

