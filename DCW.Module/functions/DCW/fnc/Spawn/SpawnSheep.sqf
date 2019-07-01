/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


private _minRange = 300;
private _firstTrigger = true;
while {true} do {
	if (count SHEEP_POOL < MAX_SHEEP_HERD)then{
		_units = [];
		//Get random pos
		if (_firstTrigger) then {_minRange = 20; _firstTrigger = false;}else{_minRange = 280;};

		// Pick up a random position around a random player
		
		_pos = [position (([] call DCW_fnc_allPlayers) call BIS_fnc_selectRandom), _minRange, 350, 4, 0, 2, 0] call BIS_fnc_findSafePos;

		_numberOfmen = round(random 2);
		_numberOfSheep = 4 + floor(random 4	);

		_goatgroup = createGroup SIDE_CIV; 

		_isSheep = if (random 1 > 0.5)then{true;}else{false;}; 
		_type = if (_isSheep)then{"Sheep_random_F";}else{"Goat_random_F"};
		_hasDog = if (random 1 > 0.5)then{true;}else{false;}; 
		_isEnemy = if (random 1 > 0.5)then{true;}else{false;}; 


		if (_numberOfmen > 0)then{
			for "_j" from 1 to _numberOfmen  do {
			
				_unit = [_goatgroup,_pos] call DCW_fnc_SpawnCivil;
			
				if(_j==1)then{
					_unit setBehaviour "SAFE";
					_unit allowFleeing 0;
					_unit setSpeedMode "LIMITED";
					_unit  setUnitRank "COLONEL";
					_goatgroup selectLeader _unit;
				};

				if(random 1 > 0.5)then{
					_unit action ["sitdown",_unit];
				};

				_units pushBack _unit;

			};
		};
		
		if (_hasDog)then{
			_dog = createAgent ["Fin_random_F", _pos, [], 0, "NONE"];
			_units pushBack _dog;
			//_goatgroup createUnit ["Fin_random_F",_pos,[],0,"NONE"];
		};

		for "_j" from 1 to _numberOfSheep  do {
			_goat = createAgent [_type, _pos, [], 0, "NONE"];
			_goat addMPEventHandler ["MPKilled", {
				_men = position(_this select 0) nearObjects ["Man", 40];

				if ({alive _x && side _x == SIDE_CIV}count _men > 0 && group(_this select 1) == GROUP_PLAYERS) then{
					[_men select 0,-3] remoteExec ["DCW_fnc_UpdateRep",2];
                	[_man select 0,"Damn ! Don't touch my sheep !", false] spawn DCW_fnc_talk;
				};
			}];
			if (DEBUG)then{
				[_goat,"ColorGrey"] call DCW_fnc_addmarker;
			};
	  		_units pushBack _goat;
		};
		SHEEP_POOL pushback _units;
	};	

	// garbage collection
	{
		// Delete all sheeps when all players are away !
		_cheepLeader = _x select 0;
		_array = _x;
		if( _x isEqualTo [] || ({ _cheepLeader distance _x > 400 } count ([] call DCW_fnc_allPlayers)) == count ([] call DCW_fnc_allPlayers))then {
			SHEEP_POOL = SHEEP_POOL - [_array];
			{
				if (!(_x getVariable ["DCW_recruit", false])) then {
					_x call DCW_fnc_deleteMarker;
					deleteVehicle _x;
				};
			} foreach _array;
		}
	} foreach SHEEP_POOL;

	sleep 15;
};
