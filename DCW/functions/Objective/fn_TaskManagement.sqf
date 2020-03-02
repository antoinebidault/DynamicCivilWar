


// Initial task
{
	["primarygoal", _x, [ "This is your primary objective: find and resolve as many intel (or side mission) as you can. Your investigations will give you access to secondary task more important. There is lots of way to gather intel : interrogate locals, search the enemy's killed gear, interrogate the captured enemies...","Find intel on the commander","Find intel on the commander"], [], "ASSIGNED", 1, true, true,""] remoteExec ["BIS_fnc_setTask" ,_x , true];
} foreach ([] call DCW_fnc_allPlayers);

while {true} do{
  
		if (STAT_INTEL_RESOLVED > 5) then {
      _chopper = CRASHSITES select 0;
			[_chopper,false] call DCW_fnc_createtask;
		} else {
			if (STAT_INTEL_RESOLVED > 22) then {
        _chopper = CRASHSITES select 0;
        [_chopper,false] call DCW_fnc_createtask;
			} else {
        if (STAT_INTEL_RESOLVED > 45) then {
            [100] call DCW_fnc_spawnConvoy;
        };
      };
		};

  sleep 30;
};