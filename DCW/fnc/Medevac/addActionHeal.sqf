if (_this getVariable["DCW_fnc_addActionHeal",-1] != -1) exitWith{};

[_this, {
	_actionId = [_this,"Heal","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","_this distance _target <= 2","true",{
			params["_injured","_healer"];
			if (!alive _injured) exitWith {};
			_healer setVariable["DCW_heal_injured", _injured, true];
			_injured setVariable["DCW_healer", _healer, true];
			[_healer, "medicStart"] remoteExec ["playActionNow"];
			[_injured,"DCW_fnc_carry"] spawn DCW_fnc_removeAction; 
			[_injured,"Aaaargh...", false] spawn DCW_fnc_talk;
			[_injured,["Sorry man... I just fucked up...","Shit ! It's a fucking mess...","I am in pain...","Don't forget the letter..."] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
			[_healer,["Don't give up mate !","Stay with us !","Stay alive !","We won't abandon you !"] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
			[_injured] spawn DCW_fnc_shout;
			[_healer,_injured,20] spawn DCW_fnc_spawnHealEquipement;
			_offset = [0,0,0];
			_dir = 0;
			_relpos = _healer worldToModel position _injured;
			if ((_relpos select 0) < 0) then {_offset = [-0.2,0.7,0]; _dir = 90} else {_offset = [0.2,0.7,0]; _dir = 270};
			_injured attachTo [_healer, _offset];
			[_injured, _dir] remoteExec ["setDir", 0, false];
			true;
		},{
		//	params["_injured","_healer"];
		//	if (!alive _injured) exitWith { _healer playActionNow "medicStop"; };
			//_healer playActionNow "medicStart";
			true;
		},{
			params["_injured","_healer","_action"];
			_healer setVariable["DCW_healer", objNull,true];
			_healer setVariable["DCW_heal_injured", objNull, true];
			_injured setVariable ["DCW_unit_injured", false, true];
			[_healer, "medicStop"] remoteExec ["playActionNow"];
			detach _injured;
			_injured setUnconscious false;
			_injured setDamage 0;
			_injured setCaptive false;
			_injured setHit ["legs", 0]; 
			[_injured,"DCW_fnc_carry"] call DCW_fnc_removeAction; 
			_injured call DCW_fnc_removeActionHeal;
			deleteMarker (_injured getVariable ["DCW_marker_injured",  ""]);
			
			// If civilian add a bonus
			if (side _injured == SIDE_CIV) then {
				[GROUP_PLAYERS,25] remoteExec ["DCW_fnc_updateScore",2];   
			};
			
			[_healer,["Ok, you're good to go !","Get a cover to take back strength !"] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
			true;
		},{
			params["_injured","_healer"];
			_healer setVariable["DCW_healer", objNull, true];
			_healer setVariable["DCW_heal_injured", objNull, true];
			[_healer, "medicStop"] remoteExec ["playActionNow"];
			if (lifeState _injured == "INCAPACITATED") then {
				[_injured, "DCW_fnc_carry"] call DCW_fnc_addAction; 
			};
			detach _injured;
			false;
		},[],12,nil,true,false] call BIS_fnc_holdActionAdd;
	_this setVariable["DCW_fnc_addActionHeal", _actionId];
}] remoteExec ["call", GROUP_PLAYERS];