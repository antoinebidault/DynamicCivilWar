/*
  Author: 
    Bidass

  Description:
    Client base script
*/

if (isNull player) exitWith{};
if (!hasInterface) exitWith{};

titleCut ["", "BLACK FADED", 9999];

// Client side 
TALK_QUEUE = [];
MESS_SHOWN = false;
MESS_HEIGHT = 0;

//Briefing
player createDiaryRecord ["Diary",["Keep a good reputation",
"The civilian in the sector would be very sensitive to the way you talk to them. Some of them are definitly hostiles to our intervention. You are free to take them in custody, that's a good point to track the potential insurgents in the region. You must avoid any mistakes, because it could have heavy consequences on the reputation of our troops in the sector. More you hurt them, more they might join the insurgents. If you are facing some difficulties, it is possible to convince some of them to join your team (it would costs you some credits...). Keep in mind the rules of engagements and it would be alright."]];

//Briefing
player createDiaryRecord ["Diary",["How to gather supports ? Side operations",
"To accomplish these tasks, you would need resources from the HQ. They could provide you all the supports you need (Choppers, CAS, ammo drops, extractions...). But you must prove them the value of your action down there. You all know that what we're doing here is not very popular, even in the high command...<br/>That's why, as side objectives, you have to bring back peace in the region. There is a few sides missions you can accomplish :<br/><br/> Clear IEDs on road<br/>Liberate hostages<br/>Destroy mortars<br/>Destroy weapon caches<br/>Desmantle outposts<br/>Eliminate snipers team<br/><br/><br/>You can ask civilian to get some more intels about these sides operations.</br>Your insertion point is already secured and located <marker name='marker_base'>uphill Zaros</marker>. Good luck soldier !"]];

player createDiaryRecord ["Diary",["How to locate the commander ?",
"For this purpose, you have two options : Find and interrogate enemy officers located by our drones. They are oftenly running with mecanized infantry which is very easy to track with our sattelites and drones. The HQ will get you in touch if they've found one.<br/><br/>Interrogate the civilian chief located in large cities, talk to civilians, ask them informations about local chief. If you keep a good reputation, they would help us.<br/>Here is a photography of mecanized infantry with officier : <img image='images\officer.jpg' width='300' height='193'/>"]];

player createDiaryRecord ["Diary",["Main objective : kill the commander",
"Dynamic Civil War<br/><br/>
In this singleplayer scenario, you have one major objective : assassinate the enemy general. We kow that it would considerably change the situation in this region which is ravaged by war. At this point, we have no intel on his exact location. He is probably hidden in mountains or forests, wandering from place to place very often far from the conflicts areas. Firstly, you must get intel about his approximate position.<br/><img image='images\target.jpg' width='302' height='190'/><br/><br/>"]];

 _loc =  nearestLocations [getPosWorld player, ["NameVillage","NameCity","NameCityCapital"],10000] select 0;

player addWeapon "itemGPS";
player addItem "MineDetector";
if (ACE_ENABLED) then {
	player addItem "ACE_DefusalKit";
	player addItem "ACE_EarPlugs";
} else {
	player addItem "ToolKit";
};

// If unit JIP
if (didJIP) then {
	 player setPos START_POSITION;
};

// If is admin
if (ENABLE_DIALOG && !didJIP) then {
	
	playMusic "AmbientTrack04_F";

	if ((leader GROUP_PLAYERS) != player) then{
		titleCut ["", "BLACK IN", 4];

		[] spawn {
			uisleep 4;
			[parseText "<t font='PuristaBold'  size='1.6'>Dynamic Civil War</t><br />by Bidass", true, nil, 12, 0.7, 0] spawn BIS_fnc_textTiles;
			uisleep 14;
			[
				[
					[format["Welcome on %1, ",worldName], "align = 'left' shadow = '1' size = '1.0'"],
					["","<br/>"], // line break
					["Stand by, the administrator is currently configuring", "align = 'left' shadow = '1' size = '1'"],
					["","<br/>"], // line break
					["the scenario's parameters...","align = 'left' shadow = '1' size = '1.0'"]
				]
			] spawn BIS_fnc_typeText2;
		};

		_randomPos = [getPos player, 200, 10000, 0, 0, 20, 0] call BIS_fnc_findSafePos;
		_randomPos set [2, 140];
		_targetPos = [_randomPos, 1000, 1100, 0, 0, 20, 0] call BIS_fnc_findSafePos;
		CONFIG_CAMERA = "camera" camcreate _randomPos;
		CONFIG_CAMERA cameraeffect ["internal", "back"];
		showCinemaBorder false;
		CONFIG_CAMERA camSetPos _randomPos;
		CONFIG_CAMERA camCommit 0;
		CONFIG_CAMERA camSetTarget _targetPos; 
		CONFIG_CAMERA camSetPos _targetPos;
		CONFIG_CAMERA camCommit 500;
	} else { 
		// He is the team leader => he administrates the mission
		[] call DCW_fnc_dialog;
	};

	// Just in case there is no config at all
	if (!isPlayer (leader GROUP_PLAYERS)) then {
		DCW_STARTED = true;
	};

	waitUntil {DCW_STARTED};

	// Close the dialog 
	if ((leader GROUP_PLAYERS) != player) then{
		CONFIG_CAMERA cameraeffect ["terminate", "back"];
		camDestroy CONFIG_CAMERA;
	} else {
		{
			if (!isPlayer _x) then {
				[_x,"MOVE"] remoteExec ["enableAI"] ;
				[_x,"FSM"] remoteExec ["enableAI"] ;
			};
			if (DEBUG) then {
				[_x,""] remoteExec ["switchMove"];
				_x setPos START_POSITION;
			};
		}
		foreach units group player;
	};

	DCW_STARTED = true;
	publicVariableServer "DCW_STARTED";

	hintSilent "";
} else {
	DCW_STARTED = true;
	publicVariableServer "DCW_STARTED";
};

if (!DEBUG && !didJIP) then {
	[] call DCW_fnc_intro;
};

uisleep .3;
titleCut ["", "BLACK FADED", 9999];
// Info text
[worldName, format["%1km from %2", round(((getPos _loc) distance2D player)/10)/100,text _loc], str(date select 1) + "." + str(date select 2) + "." + str(date select 0), daytime call BIS_fnc_timeToString] spawn BIS_fnc_infoText;
uisleep 5;
"dynamicBlur" ppEffectEnable true;  
"dynamicBlur" ppEffectAdjust [6];   
"dynamicBlur" ppEffectCommit 0;     
"dynamicBlur" ppEffectAdjust [0.0];  
"dynamicBlur" ppEffectCommit 5;  
titleCut ["", "BLACK FADED", 1];
uisleep 1;
titleCut ["", "BLACK IN", 5];

// Enable radio
enableSentences true;
enableRadio true;

// init user respawn loop
[player] spawn DCW_fnc_respawn; //Respawn loop

// Initial score display
[] call DCW_fnc_displayscore;

//Loop to check mines
iedBlasts=["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
iedJunks=["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];

// Trigger the blasting effect
iedAct={	
	_iedObj=_this;
	if(mineActive _iedObj)then{

		_iedBlast = selectRandom iedBlasts;
		createVehicle[_iedBlast,(getPosATL _iedObj),[],0,"NONE"];
		createVehicle["Crater",(getPosATL _iedObj),[],0,"NONE"];

		{
			hideObject _x
		}forEach nearestObjects[getPosATL _iedObj,iedJunks,4];
		
		deleteVehicle _iedObj;
	};
};

[] spawn {
	while {true} do {
		{
			_mine = _x select 0;
			if (!(mineActive _mine) || !(alive _mine)) then {
				_junk = _x select 1;
				// It's in cache, that's okay !
				if (player distance _junk < 250) then{

					// The mine is defused by the player
					_junk remoteExec ["DCW_fnc_success", 2, false];

					// Delete the mine
					IEDS = IEDS - [_x];
					publicVariable "IEDS";
				};
				
			} else {
				if (_mine distance player < 3  && (speed player > 4 || (stance player) != "PRONE")) then{
					_mine call iedAct;
				};
			};
			sleep .2;
		} foreach IEDS;
		sleep .4;
	};
};

// Hover effect on map;
addMissionEventHandler
[	"Map",
	{	
		params ["_isOpened","_isForced"];
		if (_isOpened) then {
			// Fetch markers from server silently
			[] spawn {
				params ["_markers"];
			 	_timer = time;
				_markers = [ missionNamespace, "MARKERS", []] call BIS_fnc_getServerVariable;
				CurrentMarker = "";
				["DCW-markerhover", "onEachFrame", {
					params ["_markers","_timer"];
					_map = findDisplay 12 displayCtrl 51; 
					_mapMarker = (ctrlMapMouseOver _map);
					hintsilent "";
					_map ctrlMapCursor ["Track","Track"];
					if (_mapMarker select 0 == "marker"  ) then {
						_map ctrlMapCursor ["Track","HC_overFriendly"];
						if ( ["dcw-cluster-",str (_mapMarker select 1)] call BIS_fnc_inString && CurrentMarker != _mapMarker select 1) then {
							CurrentMarker = _mapMarker select 1;
							_marker = [_markers,_mapMarker select 1] call DCW_fnc_getMarkerById;
							_compound = _marker select 0;
							_people = (_compound select 6);
							_population = (_people select 0) + (_people select 1) + (_people select 2) + (_people select 5) + (_people select 8); 
							_dbg =  "";
							if (DEBUG) then {
								_labels = ["Civilians","Snipers","Enemies","Cars","Ieds","Caches","Hostages","Mortars","Outposts","Friendlies"];
								{
									_dbg =  _dbg + format["<br/><t >%1:%2</t>",_labels select _foreachIndex,_x];
								}foreach _people;
								_dbg =  _dbg + format["<br/><t>Defend task state:%1</t>",_compound select 16];
							};
							
							hintsilent parseText format["<t color='#cd8700' >%1</t><br/><t size='1.3'>State : %2</t><br/><t size='1.3'>Reputation : %3/100</t><br/><t size='1.3'>Population : %4</t>%5",(_marker select 0) select 14,(_marker select 0) select 12,(_marker select 0) select 13,_population,_dbg];
						} else {
							CurrentMarker = "";
						};
					} else{
						CurrentMarker = "";
					};

					// Refresh each 4 secs
					if (time == _timer + 4 ) then {
						_markers = [missionNamespace, "MARKERS", []] call BIS_fnc_getServerVariable;
						_timer = time;
					};

					if (!visibleMap) then {
						["DCW-markerhover", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					};
				},[_markers,_timer]] call BIS_fnc_addStackedEventHandler;
			};
		};
	
	}
];

sleep 30;

if (!isMultiplayer) then{saveGame;};

