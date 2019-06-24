/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
_group = _this select 0;

fnc_spawnHelo = compile preprocessFileLineNumbers  "DCW\medevac\fnc\SpawnHelo.sqf";
fnc_SpawnHeloCrew = compile preprocessFileLineNumbers  "DCW\medevac\fnc\SpawnHeloCrew.sqf";
fnc_SpawnHeloReplacement = compile preprocessFileLineNumbers  "DCW\medevac\fnc\SpawnHeloReplacement.sqf";
fnc_HandleDamage = compile preprocessFileLineNumbers  "DCW\medevac\fnc\HandleDamage.sqf";
fnc_HandleKilled = compile preprocessFileLineNumbers  "DCW\medevac\fnc\HandleKilled.sqf";
fnc_Heal = compile preprocessFileLineNumbers "DCW\medevac\fnc\heal.sqf";
fnc_Save = compile preprocessFileLineNumbers "DCW\medevac\fnc\save.sqf";
fnc_Carry = compile preprocessFileLineNumbers "DCW\medevac\fnc\carry.sqf";
fnc_addActionCarry = compile preprocessFileLineNumbers "DCW\medevac\fnc\addActionCarry.sqf";
fnc_ChopperPath = compile preprocessFileLineNumbers "DCW\medevac\fnc\chopperpath.sqf";
fnc_calculateTimeToHeal = compile preprocessFileLineNumbers "DCW\medevac\fnc\calculateTimeToHeal.sqf";
fnc_spawnHealEquipement = compile preprocessFileLineNumbers "DCW\medevac\fnc\spawnHealEquipement.sqf";
fnc_spawnObject = compile preprocessFileLineNumbers "DCW\medevac\fnc\spawnObject.sqf";
fnc_dropInHelo = compile preprocessFileLineNumbers "DCW\medevac\fnc\dropInHelo.sqf";
fnc_help = compile preprocessFileLineNumbers "DCW\medevac\fnc\help.sqf";
fnc_removeFAKS = compile preprocessFileLineNumbers "DCW\medevac\fnc\removeFAKS.sqf";
fnc_deleteMedevac = compile preprocessFileLineNumbers "DCW\medevac\fnc\deleteMedevac.sqf";
fnc_caller = compile preprocessFileLineNumbers "DCW\medevac\fnc\caller.sqf";
fnc_injured = compile preprocessFileLineNumbers "DCW\medevac\fnc\injured.sqf";

REVIVETIME_INSECONDS = 10;
_transportHelo = objNull;
_posChopper = objNull;
_supportHeli = 1000;

private _soldiersDead = [];

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
		_x removeAllEventHandlers "HandleDamage";
		_x addEventHandler ["HandleDamage",{_this call fnc_HandleDamage;}];
		_x addMPEventHandler ["MPKilled",{_this call fnc_HandleKilled;}];
	};
}foreach (units _group);



/*
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
			[_leader,_soldiersDead] call fnc_caller;
		};
	};

	//Launch chopper
	if (MEDEVAC_State == "map")then{

		MEDEVAC_marker = "";

		deleteMarker "medevac_marker";

		[HQ,"We're waiting now for your mark on the map !",true] remoteExec ["fnc_talk"];

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
				[HQ,"I copy!",true] remoteExec ["fnc_talk"];
				sleep 1;
				openMap false;

			 }] remoteExec ["spawn",_leader,false];

			waitUntil {sleep 3;MEDEVAC_State == "pointselected"};
			MEDEVAC_State = "inbound";
			[_leader,_soldiersDead] call fnc_caller;

			// Chopper spawning
			_transportHelo = [_group] call fnc_spawnHelo;
			_posChopper = position _transportHelo;

			// Startup the chopper path
			[group _transportHelo,getMarkerPos "medevac_marker",_transportHelo,_group] spawn fnc_ChopperPath;
		};
	};

	//StandBy
	if (isNull _transportHelo && count _soldiersDead > 0 && MEDEVAC_State == "standby")then{
		MEDEVAC_State = "menu";
		[_leader,_soldiersDead] call fnc_caller;
	}else{
		if (MEDEVAC_State == "succeeded") then {
			[HQ,"Medevac mission succeeded",true] remoteExec ["fnc_talk"];
			[_transportHelo,_group] call fnc_deleteMedevac;
			MEDEVAC_State = "standby";
			sleep 120;
		} else {
			if (MEDEVAC_State == "aborted") then {
				[HQ,"Medevac mission aborted",true] remoteExec ["fnc_talk"];
				_transportHelo move _posChopper;
				sleep 120;
				[_transportHelo,_group] call fnc_deleteMedevac;
				MEDEVAC_State = "standby";
			} else {
				if (MEDEVAC_State == "inbound" && (!alive _transportHelo || damage _transportHelo > .6)) then {
					[HQ,"The chopper is destroyed ! MEDEVAC helicopter available in 2 minutes",true] remoteExec ["fnc_talk"];
					sleep 120;	
					[_transportHelo,_group] call fnc_deleteMedevac;
					MEDEVAC_State = "standby";
				};
			};
		};
	};
	sleep 3;
};*/

