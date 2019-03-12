/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Spawn a leutnant to assassine
 */


private _compos = [compo_commander1,compo_commander2];
private _newPos = [];
private _radiusSpawnRange = [1000,5400];
private _playerPos = getPos LEADER_PLAYERS;
private _initPos = [_playerPos,_radiusSpawnRange select 0, _radiusSpawnRange select 1, 4, 0, 20, 0, MARKER_WHITE_LIST] call BIS_fnc_FindSafePos;
private _grp = createGroup ENEMY_SIDE;
private _leutnant = _grp createUnit [ENEMY_COMMANDER_CLASS, _initPos,[],ENEMY_SKILLS,"NONE"];

removeAllWeapons _leutnant;
_leutnant setBehaviour "SAFE";
_leutnant execVM "DCW\loadout\loadout-officer.sqf";

//Trucks
private _road = [_initPos,3000, MARKER_WHITE_LIST] call BIS_fnc_nearestRoad;
private _roadPos = getPos _road;
private _roadConnectedTo = roadsConnectedTo _road;
if (count _roadConnectedTo == 0) exitWith { hint "restart";[] spawn fnc_SpawnSecondaryObjective; };
private _connectedRoad = _roadConnectedTo select 0;

private _roadDirection = [_road, _connectedRoad] call BIS_fnc_DirTo;
private _truck = [_roadPos, _roadDirection, ENEMY_LEUTNANT_LIST_CARS call bis_fnc_selectrandom, createGroup ENEMY_SIDE] call BIS_fnc_spawnVehicle select 0;
_leutnant moveInAny _truck;

private _nbUnit = (count (fullCrew [_truck,"cargo",true]))-1;
private _unit = objNull;
for "_yc" from 1 to _nbUnit  do {
    _unit = [_grp, _initPos, true] call fnc_spawnEnemy;
    _unit moveInAny _truck;
};

_grp selectLeader _leutnant;
[_truck,_leutnant,500] spawn fnc_leutnantPatrol;

_leutnant addMPEventHandler ["MPKilled",{
    ["DCW_secondary","FAILED",true] spawn BIS_fnc_taskSetState;
}];

_leutnant addEventHandler ["HandleDamage",{
    
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
    
	if (_damage == 0) exitWith {false};
	
	if (_damage > .9 && !(_unit getVariable["DCW_isUnconscious",false])) then {
        _unit setVariable["DCW_isUnconscious",true];
		[_unit] spawn fnc_shout;	
		removeAllActions _unit;
		_unit setDamage .9;
		_unit setHit ["legs", 1];

        if (vehicle _unit != _unit)then{
           moveOut _unit;
        };
        
        //Spasm and unconscious state
        _unit spawn {
            sleep .2;
            _this setUnconscious true;
            waitUntil { vehicle _this != _this || animationState _this == "ainjppnemstpsnonwrfldnon"  }; 
            _this playAction "GestureSpasm" + str floor random 7; 
        };	

		_damage = .9;


		  [ _unit,"Interrogate","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","true","true",{
			(_this select 1) playActionNow "medicStart";
		  },{
		    (_this select 1) playActionNow "medicStart";
		  },{
            params["_unit","_player"];
			_player playActionNow "medicStop";
            ["DCW_secondary","SUCCEEDED",true] spawn BIS_fnc_taskSetState;
            _unit setVariable["DCW_interrogated",true];
            _unit removeAllMPEventHandlers "Killed";
            
            [_unit]spawn{
                params["_unit"];
                sleep 100;
                _unit setDamage 1;
            };
            _unit call fnc_MainObjectiveIntel;
		},{
		  (_this select 1) playActionNow "medicStop";
		},[],3,nil,true,false] spawn BIS_fnc_holdActionAdd;

	}else{
        if (!(_unit getVariable["DCW_interrogated",false]) && _unit getVariable["DCW_isUnconscious",false]) then {
            _damage = .9;
	        _unit setDamage .9;
        };
    };
    
	_damage;
}];


//Custom variable
private _marker = createMarker ["leutnantLMarker",getPos _leutnant];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorRed";
_marker setMarkerType "mil_warning";
_leutnant setVariable["marker",_marker];
LEUTNANT = _leutnant;
private _firstSpawn = true;

while {sleep 20; alive _leutnant && !(_leutnant getVariable["DCW_interrogated",false]) } do {
    [ "DCW_secondary",LEADER_PLAYERS, [format["Our drones give us some informations about an insurgent's leutnant location. Move to his location and try to gather infomration. His name is %1",name _leutnant],"Interrogate the leutnant","Interrogate the leutnant"],getPos _leutnant,"ASSIGNED",1,if (_firstSpawn) then {true}else{false}] call BIS_fnc_setTask;
    private _loc =  nearestLocations [getPosWorld _leutnant, ["NameVillage","NameCity","NameCityCapital"],10000] select 0;
	// Info text
    
    [HQ,format["We have some new intels on the enemy leutnant : %1, he is located %2km from %3",name _leutnant,round(((getPos _loc) distance2D player)/10)/100,text _loc], true] remoteExec ["fnc_talk"];
    _marker setMarkerPos (getPos _leutnant);
    _firstSpawn = false;
    sleep 300 + random 240;
};

deleteMarker _marker;
sleep 100 + random 400;

[] spawn fnc_SpawnSecondaryObjective;
false;
