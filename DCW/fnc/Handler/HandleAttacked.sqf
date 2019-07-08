/*
  Author: 
    Bidass

  Description:
    FiredNear handler attached to enemy unit
	It will make the unit surrender when over pressured
	(Wounded, low morale, less distance from gunner, whole team decimated...)

  Parameters:
    0: OBJECT - unit

  Returns:
    BOOL - true 
*/
 params["_unit"];
_unit addEventHandler["FiredNear",
	{
		_unit=_this select 0;	
		_distance = _this select 2;	
		_muzzle = _this select 4;	
		_gunner = _this select 7;	
		if (!captive _unit && side _gunner == SIDE_FRIENDLY  && count (units (group _unit)) == 1 && damage _unit < .6 && morale _unit < -.65 && _unit distance _gunner < 120) then {
			[_unit,_gunner] remoteExec["DCW_fnc_surrender"];
		};
	}
];

true;