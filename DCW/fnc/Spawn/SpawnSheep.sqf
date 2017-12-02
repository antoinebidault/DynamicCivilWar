/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */


private _minRange = 300;
private _firstTrigger = true;
while{true}do {
	if (count SHEEP_POOL < MAX_SHEEP_HERD)then{

		//Get random pos
		if (_firstTrigger) then {_minRange = 20; _firstTrigger = false;}else{_minRange = 300;};
		_pos = [position player, _minRange, 350, 4, 0, 20, 0] call BIS_fnc_findSafePos;

		_numberOfmen = 1 + round(random 1);
		_numberOfSheep = 3 + floor(random 7);

		_goatgroup = createGroup CIV_SIDE; 

		_isSheep = if (random 1 > 0.5)then{true;}else{false;}; 
		_type = if (_isSheep)then{"Sheep_random_F";}else{"Goat_random_F"};
		_hasDog = if (random 1 > 0.5)then{true;}else{false;}; 
		_isEnemy = if (random 1 > 0.5)then{true;}else{false;}; 

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

		if (_hasDog)then{
			_goatgroup createUnit ["Fin_random_F",_pos,[],0,"NONE"];
		};

		for "_j" from 1 to _numberOfSheep  do {
	
			_goat= _goatgroup createUnit [_type,_pos,[],0,"NONE"];
			_goat addEventHandler ["Killed", {
				_man = leader (group (_this select 0));
				if (  ( group(_this select 1) == (group player)) && alive _man && _man isKindOf "Man") then{
					[_man,-2] call fnc_updateRep;
                	[_man,"Damn ! Don't touch my sheep !"] spawn fnc_talk;
				};
			}];
			if (DEBUG)then{
				[_goat,"ColorGrey"] call fnc_addmarker;
			};
		};
		
	  	SHEEP_POOL pushBack _goatgroup;
	};	

	{
		if( (leader (_x)) distance player > 400)then{
			SHEEP_POOL = SHEEP_POOL - [_x];
			{
				if (DEBUG)then{
					
					deleteMarker (_x getVariable["marker",""]);
				};
				UNITS_SPAWNED = UNITS_SPAWNED - [_x];
				deleteVehicle _x;
			}foreach units (_x);
			deleteGroup (_x);
		}
	}foreach SHEEP_POOL;

	sleep 5;
};
