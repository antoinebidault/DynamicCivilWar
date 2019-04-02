/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


unit = _this select 0;
REVIVETIME_INSECONDS = 10;

fnc_spawnHelo = compile preprocessFileLineNumbers  "DCW\medevac\fnc\SpawnHelo.sqf";
fnc_SpawnHeloCrew = compile preprocessFileLineNumbers  "DCW\medevac\fnc\SpawnHeloCrew.sqf";
fnc_SpawnHeloReplacement = compile preprocessFileLineNumbers  "DCW\medevac\fnc\SpawnHeloReplacement.sqf";
fnc_HandleDamage = compile preprocessFileLineNumbers  "DCW\medevac\fnc\HandleDamage.sqf";
fnc_HandleKilled = compile preprocessFileLineNumbers  "DCW\medevac\fnc\HandleKilled.sqf";
fnc_Heal = compile preprocessFileLineNumbers "DCW\medevac\fnc\heal.sqf";
fnc_Save = compile preprocessFileLineNumbers "DCW\medevac\fnc\save.sqf";
fnc_Carry = compile preprocessFileLineNumbers "DCW\medevac\fnc\carry.sqf";
fnc_ChopperPath = compile preprocessFileLineNumbers "DCW\medevac\fnc\chopperpath.sqf";
fnc_calculateTimeToHeal = compile preprocessFileLineNumbers "DCW\medevac\fnc\calculateTimeToHeal.sqf";
fnc_spawnHealEquipement = compile preprocessFileLineNumbers "DCW\medevac\fnc\spawnHealEquipement.sqf";
fnc_spawnObject = compile preprocessFileLineNumbers "DCW\medevac\fnc\spawnObject.sqf";
fnc_dropInHelo = compile preprocessFileLineNumbers "DCW\medevac\fnc\dropInHelo.sqf";
fnc_help = compile preprocessFileLineNumbers "DCW\medevac\fnc\help.sqf";
fnc_removeFAKS = compile preprocessFileLineNumbers "DCW\medevac\fnc\removeFAKS.sqf";
fnc_deleteMedevac = compile preprocessFileLineNumbers "DCW\medevac\fnc\deleteMedevac.sqf";

transportHelo = objNull;
handle = objNull;
MEDEVAC_State = "standby"; // standby/menu/map/inbound/aborted
MEDEVAC_marker = "";
SmokeShell = objNull;
unit addItem  "SmokeShellGreen";
unit addItem  "SmokeShellGreen";
unit addItem  "SmokeShellGreen";

private _soldiersDead = [];

{	
	if (!isPlayer(_x))then{
		_x addEventHandler ["HandleDamage",{_this call fnc_HandleDamage;}];
		_x addMPEventHandler ["MPKilled",{_this call fnc_HandleKilled;}];
	};
}foreach (units (group unit));

_posChopper = objNull;
MEDEVAC_action = "";
while {true} do {

	//Push dead soldiers
	_soldiersDead = units (group unit) select { _x getVariable["unit_injured",false] };

	//Launch chopper
	if (MEDEVAC_State == "map")then{

		MEDEVAC_State = "menu";
		MEDEVAC_marker = "";
		deleteMarker "medevac_marker";

		[HQ,"We're waiting now for your mark on the map !",true] remoteExec ["fnc_talk"];

		//open the map
		if (isPlayer unit) then {

	    	openMap true;

			//move the marker to the click position
			onMapSingleClick {
				MEDEVAC_marker = createMarkerLocal ["medevac_marker",_pos];
				MEDEVAC_marker setMarkerColorLocal "ColorBlack";
				MEDEVAC_marker setMarkerShapeLocal "ELLIPSE";
				MEDEVAC_marker setMarkerBrushLocal "Solid";
				MEDEVAC_marker setMarkerSizeLocal [13, 13];
			};

			//clear the click handle
			waitUntil {MEDEVAC_marker != ""};
			unit onMapSingleClick "";
			[HQ,"I copy!",true] remoteExec ["fnc_talk"];
			sleep 1;
			openMap false;

		 	MEDEVAC_action = unit addAction ["<t color='#000'>Abort medevac</t>", { 
				params["_unit","_actionId"];
				_unit removeAction MEDEVAC_action;
				MEDEVAC_State = "aborted";
			 }];

			if ((count _soldiersDead > 0) && MEDEVAC_State != "inbound")then {
				MEDEVAC_State = "inbound";

				// Chopper spawning
				transportHelo = [] call fnc_spawnHelo;
				_posChopper = position transportHelo;

				// Startup the chopper path
				[group transportHelo,getMarkerPos "medevac_marker",transportHelo,unit] spawn fnc_ChopperPath;
			}else{
				hint "Impossible to request";
				MEDEVAC_State = "menu";
				[unit, "Medevac"] call BIS_fnc_addCommMenuItem;
			};
		};
	};

	//StandBy
	if (isNull transportHelo && count _soldiersDead > 0 && MEDEVAC_State == "standby")then{
		MEDEVAC_State = "menu";
		[unit, "Medevac"] call BIS_fnc_addCommMenuItem;
	}else{
		if (MEDEVAC_State == "succeeded")then{
			[HQ,"Medevac mission succeeded",true] remoteExec ["fnc_talk"];
			[transportHelo] call fnc_deleteMedevac;
			MEDEVAC_State = "standby";
			sleep 120;
		} else {
			if (MEDEVAC_State == "aborted")then{
				[HQ,"Medevac mission aborted",true] remoteExec ["fnc_talk"];
				transportHelo move _posChopper;
				sleep 120;
				[transportHelo] call fnc_deleteMedevac;
				MEDEVAC_State = "standby";
			} else {
				if (MEDEVAC_State == "inbound" && (!alive transportHelo || damage transportHelo > .6))then{
					[HQ,"The chopper is destroyed ! MEDEVAC helicopter available in 2 minutes",true] remoteExec ["fnc_talk"];
					sleep 120;	
					[transportHelo] call fnc_deleteMedevac;
					MEDEVAC_State = "standby";
				};
			};
		};

	};
	sleep 3;
};


