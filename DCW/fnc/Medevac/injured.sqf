params["_unit"];


if (vehicle _unit != _unit) then {
	_unit leaveVehicle (vehicle _unit);
};

_unit remoteExec ["DCW_fnc_addActionCarry"];

// Stabilize
[ _unit,"Heal","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","_this distance _target <= 2","true",{
		params["_injured","_healer"];
		if (!alive _injured) exitWith {};
		_healer playActionNow "medicStart";
		_healer setVariable["healer", _injured];
		[_injured,"Aaaargh...", false] spawn DCW_fnc_talk;
		[_injured,["Sorry man... I just fucked up...","Shit ! It's a fucking mess...","I am in pain...","Don't forget the letter..."] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
		[_healer,["Don't give up mate !","Stay with us !","Stay alive !","We won't abandon you !"] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
		[_injured] spawn DCW_fnc_shout;
		[_healer,_injured,20] spawn DCW_fnc_spawnHealEquipement;
		_offset = [0,0,0]; _dir = 0;
		_relpos = _healer worldToModel position _injured;
		if ((_relpos select 0) < 0) then {_offset = [-0.2,0.7,0]; _dir = 90} else {_offset = [0.2,0.7,0]; _dir = 270};
		_injured attachTo [_healer, _offset];
		[_injured, _dir] remoteExec ["setDir", 0, false];
	},{
		params["_injured","_healer"];
		//_healer playActionNow "medicStart";
	
	},{
		params["_injured","_healer"];
		_healer setVariable["healer", objNull];
		_injured setVariable ["unit_injured", false, true];
		_healer playActionNow "medicStop";
		detach _injured;
		_injured setUnconscious false;
		_injured setDamage 0;
		_injured setCaptive false;
		_injured setHit ["legs", 0]; 
		deleteMarker (_injured getVariable ["DCW_marker_injured",  ""]);
		removeAllActions _injured;
		[_healer,["Ok, you're good to go !","Get a cover to take back strength !"] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
		_injured;
	},{
		params["_injured","_healer"];
		_healer setVariable["healer", objNull];
		_healer playActionNow "medicStop";
		detach _injured;
	},[],15,nil,true,true] remoteExec ["BIS_fnc_holdActionAdd"];

_unit setUnconscious true;
_unit setCaptive true;
_unit setVariable ["unit_injured", true, true];

_deathsound = format ["A3\sounds_f\characters\human-sfx\P0%1\Hit_Max_%2.wss", selectRandom [4,5,6,7,8,9], selectRandom [1,2,3,4,5]];
playSound3D [_deathsound, _unit, false, getPosASL _unit, 1.5, 1, 150];	

_unit setHit ["legs", 1]; 