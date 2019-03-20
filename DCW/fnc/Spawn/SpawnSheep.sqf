/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


private _minRange = 300;
private _firstTrigger = true;
while{true}do {
	if (count SHEEP_POOL < MAX_SHEEP_HERD)then{
	
		//Get random pos
		if (_firstTrigger) then {_minRange = 20; _firstTrigger = false;}else{_minRange = 300;};

		// Pick up a random position around a random player
		
		_pos = [position (allPlayers call BIS_fnc_selectRandom), _minRange, 350, 4, 0, 20, 0] call BIS_fnc_FindSafePos;

		_numberOfmen = round(random 2);
		_numberOfSheep = 3 + floor(random 4	);

		_goatgroup = createGroup CIV_SIDE; 

		_isSheep = if (random 1 > 0.5)then{true;}else{false;}; 
		_type = if (_isSheep)then{"Sheep_random_F";}else{"Goat_random_F"};
		_hasDog = if (random 1 > 0.5)then{true;}else{false;}; 
		_isEnemy = if (random 1 > 0.5)then{true;}else{false;}; 


		if (_numberOfmen > 0)then{
			for "_j" from 1 to _numberOfmen  do {
			
				_unit = [_goatgroup,_pos] call fnc_SpawnCivil;
			
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

				UNITS_SPAWNED pushBack _unit;
			};
		};

		if (_hasDog)then{
			_goatgroup createUnit ["Fin_random_F",_pos,[],0,"NONE"];
		};

		for "_j" from 1 to _numberOfSheep  do {
	
			_goat= _goatgroup createUnit [_type,_pos,[],0,"NONE"];
			_goat addMPEventHandler ["MPKilled", {
				_man = leader (group (_this select 0));
				if (group(_this select 1) == GROUP_PLAYERS && alive _man && _man isKindOf "Man") then{
					[_man,-2] call fnc_updateRep;
                	[_man,"Damn ! Don't touch my sheep !", false] spawn fnc_talk;
				};
			}];
			if (DEBUG)then{
				[_goat,"ColorGrey"] call fnc_addmarker;
			};
		};
		
	  	SHEEP_POOL pushBack _goatgroup;
	};	

	// garbage collection
	{
		// Delete all sheeps when all players are away !
		if(  ({(leader _x) distance _x > 400 } count allPlayers) == count allPlayers)then {
			SHEEP_POOL = SHEEP_POOL - [_x];
			{
				_x call fnc_deleteMarker;
				UNITS_SPAWNED = UNITS_SPAWNED - [_x];
				deleteVehicle _x;
			}foreach units (_x);
			deleteGroup (_x);
		}
	} foreach SHEEP_POOL;

	sleep 15;
};
