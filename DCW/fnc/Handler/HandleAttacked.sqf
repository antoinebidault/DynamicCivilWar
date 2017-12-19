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
		_silencer = _gunner weaponAccessories currentMuzzle _gunner select 0;
		_hasSilencer = !isNil "_silencer" && {_silencer != ""};
		if (_hasSilencer || _distance > 160 || _gunner != player) exitWith { true };
		_unit setBehaviour "AWARE";
		_unit forceWalk false;
		_unit forceSpeed (0-1);
		_unit setSpeedMode "FULL";
		_unit removeAllEventHandlers "FiredNear";
	}
];