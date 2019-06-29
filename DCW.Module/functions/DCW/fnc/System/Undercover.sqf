
/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Undercover loop triggered on disguise action on enemy dead bodies
 */
if (isNull player) exitWith{false};

private["_unit","_enemy"];
params["_unit","_enemy"];

private _inventory = getUnitLoadout _enemy;
private _inventoryBackUp = getUnitLoadout _unit;

if (CHASER_TRIGGERED || CHASER_VIEWED || _unit getVariable["DCW_undercover",false]) exitWith{[_unit,"I can't do this...", false] spawn DCW_fnc_talk;false;};

private _grpUnit = group _unit;

[_unit, "medic"] remoteExec ["playActionNow"];
_unit setCaptive true;
_unit setVariable["DCW_undercover",true];
_unit call DCW_fnc_displayscore;

sleep 2;

_unit setUnitLoadout _inventory;
_enemy setUnitLoadout _inventoryBackUp;


sleep 1;
[_unit] joinSilent grpNull;

private _clothes = [uniform _unit,vest _unit,headgear _unit];

_null = [_unit,"Good idea ! I'm gonna infiltrate their line.", false] spawn DCW_fnc_talk; 

private _idFiredNear = _unit addEventHandler["FiredNear",{
	params["_unit","_veh","_dist","_weap","_muz","_mode","_am","_gunner"];
	if (side _gunner == SIDE_ENEMY && alive _unit && alive _gunner && _dist < 20)then{
		_unit setVariable["DCW_undercover" , false];
	};
}];

private _idFired = _unit addEventHandler["Fired",{
	params["_unit","_weap","_muzz","_mode","_ammo","_mag","_projectile"];
	 _unit setCaptive false;
	 _unit setVariable["DCW_Watched",true];
	 [_unit]spawn {
		 params["_unit"];
		 sleep 4;
		 if (_unit getVariable["DCW_undercover" , false])then{
		 	_unit setCaptive true;
			_unit setVariable["DCW_Watched",false];
		 };
	 };
}];


while {_unit getVariable["DCW_undercover",false]}do{

	if (!([uniform _unit,vest _unit,headgear _unit] isEqualTo _clothes)) then{
		hint "You changed your clothes !";
		_unit setVariable["DCW_undercover", false];
	};

	{
		if (side _x == SIDE_ENEMY)then{
			
			if (_x knowsAbout _unit > 2) then{
				private _know =  [_x,_unit] call DCW_fnc_getVisibility; //[ position _x, getDir _x, 45, position _unit] call BIS_fnc_inAngleSector;
				private _en = _x;
				//Check if units is shooting at him
				if (_know > 20 && alive _en && !captive _unit && behaviour _en != "SAFE")then{
					if (!(_en getVariable["DCW_Watching",false])) then{
						_en setVariable["DCW_Watching",true];
						_unit setVariable["DCW_Watched",true];
						_unit call DCW_fnc_displayscore;
						_en forceSpeed 0;
						_en doWatch _unit;
					    if (!weaponLowered _en)then{
							_en  action ["WeaponOnBack", _en];
						};
						_null = [_unit,_en] spawn {
							params["_unit","_en"];
							sleep 4;
							_en forceSpeed (0-1);
							_en setVariable["DCW_Watching",false];
							_unit setVariable["DCW_Watched",false];
						    if (weaponLowered _en)then{
								_en  action ["WeaponOnBack", _en];
							};
							_unit call DCW_fnc_displayscore;
							if (([_en,_unit] call DCW_fnc_getVisibility > 50 && alive _en) && _unit getVariable["DCW_undercover", false]) then{
								hint "Attacked !";
								_unit setVariable["DCW_undercover", false];
							};
						};
					};
				};

				if (_know > 10 && alive _en && _en distance _unit < 50   && _unit getVariable["DCW_speak",false])then{
					hint "Their hear your voice !";
					_unit setVariable["DCW_undercover", false];
				};

				//Check if weapon up && low speed && up
				if (_know > 20 && _en distance _unit < 50 && alive _en &&  ((weaponLowered _en && !weaponLowered _unit) || (behaviour _en == "SAFE" && stance _unit != "STAND") || (behaviour _en == "SAFE" && speed _unit > 14) ))then{
					if (!(_en getVariable["DCW_Watching",false])) then{
						hint "You're looking suspicious !";
						_en setVariable["DCW_Watching",true];
						_unit setVariable["DCW_Watched",true];
						_unit call  DCW_fnc_displayscore;
						_en forceSpeed 0;
						_en doWatch _unit;
						if (!weaponLowered _en)then{
							_en  action ["WeaponOnBack", _en];
						};
						_null = [_unit,_en] spawn {
							params["_unit","_en"];
							sleep 4;
							_en forceSpeed (0-1);
							_en setVariable["DCW_Watching",false];
							_unit setVariable["DCW_Watched",false];
							_unit call  DCW_fnc_displayscore;
							 if (weaponLowered _en)then{
								_en  action ["WeaponOnBack", _en];
							};
							if ([_en,_unit] call DCW_fnc_getVisibility > 50  && _en distance _unit < 50 &&  ((weaponLowered _en && !weaponLowered _unit) || (behaviour _en == "SAFE" && stance _unit != "STAND" ) || speed _unit > 14) && alive _en && _unit getVariable["DCW_undercover", false]) then{
								hint "Watched !";
								_unit setVariable["DCW_undercover", false];
							};
						};
					};
				};

				//Check if too close
				if (_know > 2 && alive _en  && (_unit distance _en) < 4) then {
					if (!(_en getVariable["DCW_Watching",false])) then{
						hint "You're too close !";
						_en setVariable["DCW_Watching",true];
						_unit setVariable["DCW_Watched",true];
						_unit call  DCW_fnc_displayscore;
						_en forceSpeed 0;
						_en doWatch _unit;
						_null = [_unit,_en] spawn {
							params["_unit","_en"];
							sleep 4;
							_en forceSpeed (0-1);
							_en setVariable["DCW_Watching",false];
							_unit setVariable["DCW_Watched",false];
							_unit call  DCW_fnc_displayscore;
							 if (weaponLowered _en)then{
								_en  action ["WeaponOnBack", _en];
							};
							if ([_en,_unit] call DCW_fnc_getVisibility > 50  && _unit distance _en < 4 && alive _en && (_unit getVariable["DCW_undercover", false])) then {
								hint "Watched !";
								_unit setVariable["DCW_undercover", false];
							};
						};
					};
				};
			};
		};

		
	} count allUnits;

	

	sleep .1;
};

_unit call  DCW_fnc_displayscore;
_unit setCaptive false;
_unit removeEventHandler ["FiredNear",_idFiredNear];
_unit removeEventHandler ["Fired",_idFired];
[_unit] joinSilent _grpUnit;
_grpUnit selectLeader _unit;