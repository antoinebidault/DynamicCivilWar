/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
 params["_unit"];
_unit addEventHandler["FiredNear",
	{
		_unit=_this select 0;	
		_distance = _this select 2;	
		_muzzle = _this select 4;	
		_gunner = _this select 7;	
		if (!captive _unit && side _gunner == SIDE_FRIENDLY  && count (units (group _unit)) == 1 && damage _unit < .6 && morale _unit < -.7 && _unit distance _gunner < 120) then {
			[_unit] remoteExec["DCW_fnc_surrender"];
		};
	}
];