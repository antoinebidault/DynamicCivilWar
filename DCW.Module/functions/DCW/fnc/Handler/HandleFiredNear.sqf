/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Catch firednear event => Make up
 * Thanks to phronk : https://forums.bistudio.com/profile/785811-phronk/
 */


_this select 0 addEventHandler["FiredNear",
{
	_civ=_this select 0;	
	_distance = _this select 2;	
	_gunner = _this select 7;	
	
	// Check the civ is not too far
	if ( { _civ distance _x > 30 && _civ distance _x < 400 } count ([] call DCW_fnc_allPlayers) == count ([] call DCW_fnc_allPlayers) && (_civ getVariable["DCW_Suspect", true] || (random 100) < PERCENTAGE_INSURGENTS))then{
		
		//Remove the eventHandler to prevent spamming
		_civ removeAllEventHandlers "FiredNear";
		[_civ,_gunner] spawn DCW_fnc_SpawnAsEnemy;
	}else{
		group _civ setspeedmode "FULL";
		_civ forceWalk false;
		
        _civ remoteExec ["removeAllActions",0];
		
		switch(round(random 2))do{
			case 0:{_civ switchMove "ApanPercMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			case 1:{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			case 2:{_civ playMoveNow "ApanPpneMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			default{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
		};		

		_nH=nearestObjects [_civ, ["house"], 100];		

		//Pick an object found in the above nearestObjects array		
		_H=selectRandom _nH;

		//Finds list of all available building positions in the selected building		
		_HP=_H buildingPos -1;

		//Picks a building position from the list of building positions		
		_HP=selectRandom _HP;

		//Orders the civilian to move to the building position		
		_civ doMove _HP;

		//Make unit shout
		if (_distance < 40)then{
			[_civ] call DCW_fnc_shout;
		};
		
		_civ setVariable["civ_affraid",true];

		//Remove the eventHandler to prevent spamming
		_civ removeAllEventHandlers "FiredNear";

		//Action to make him calm down !
		[_civ,["<t color='#FF0000'>Calm down !</t>",{
			params["_unit","_asker","_action"];
			_unit removeAction _action;
				if (!weaponLowered _asker)then{
				_asker  action ["WeaponOnBack", _asker];
			};
			[_asker,"Calm down my friend !",false] call DCW_fnc_Talk;
			_unit stop true;
			_unit  setVariable["civ_affraid",false];
			sleep .3;
			[_unit,""] remoteExec ["switchMove",0];
			sleep .3;
			[_unit] remoteExec ["DCW_fnc_addCivilianAction",0];
			[_unit,2] remoteExec ["DCW_fnc_UpdateRep",2];
			sleep 15;
			_unit stop false;
			[_unit]  remoteExec ["DCW_fnc_handleFiredNear",0];
		},nil,1.5,false,true,"","true",2,false,""]] remoteExec ["addAction"];

		if (isPlayer _gunner )then {
			[_unit,-5] remoteExec ["DCW_fnc_UpdateRep",2];
		}else{
			[_unit,1] remoteExec ["DCW_fnc_UpdateRep",2];
		};
	};

}];

