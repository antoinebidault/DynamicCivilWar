



_this select 0 addEventHandler["FiredNear",
	{
		_civ=_this select 0;	
		_distance = _this select 2;	
		_gunner = _this select 7;	
		if (_distance > 50) exitWith { false };
		
		
		if (_civ distance _gunner > 45 && (random 100) < PERCENTAGE_INSURGENTS)then{
			[_civ,_gunner] spawn fnc_SpawnAsEnemy;
		}else{
			group _unit setspeedmode "FULL";
			_unit forceWalk false;
			removeAllActions _civ;
			switch(round(random 2))do{
				case 0:{_civ switchMove "ApanPercMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
				case 1:{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
				case 2:{_civ playMoveNow "ApanPpneMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
				default{_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL";};
			};		

			//nearestObjects[ PositionOrTarget, ["List","Of","Classnames","To","Look","For"], MaxDistanceToSearchAroundTarget ];
			_nH=nearestObjects [_civ, ["house"], 100];		

			//Pick an object found in the above nearestObjects array		
			_H=selectRandom _nH;

			//Finds list of all available building positions in the selected building		
			_HP=_H buildingPos -1;

			//Picks a building position from the list of building positions		
			_HP=selectRandom _HP;

			//Orders the civilian to move to the building position		
			_civ doMove _HP;

			if (_distance < 20)then{
				[_civ] call fnc_shout;
			};
			
			_civ setVariable["civ_affraid",true];

			//Remove the eventHandler to prevent spamming
			_civ removeAllEventHandlers "FiredNear";

			//Calme le mec
			_civ addAction["Calm down !",{
				params["_unit","_asker","_action"];
				_unit removeAction _action;
				_asker  action ["WeaponOnBack",  _asker];
				_asker globalChat "Calm down my friend !";
				_unit stop true;
				_unit  setVariable["civ_affraid",false];
				sleep 2;
				_unit switchMove "";
				sleep 2;
				[_unit] call fnc_addCivilianAction;
				[_unit] call fnc_handleFiredNear;
				[_unit,20] call fnc_UpdateRep;
				sleep 100;
				_unit stop false;
			},nil,1.5,true,true,"","true",2,false,""];
			if (isPlayer _gunner )then {
				[_unit,-10] call fnc_UpdateRep;
			}else{
				[_unit,+5] call fnc_UpdateRep;
			};
		};

	}
];

