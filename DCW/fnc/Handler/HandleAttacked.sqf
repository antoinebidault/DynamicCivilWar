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
		if (!captive _unit  && morale _unit < -0.5 && _unit call BIS_fnc_enemyDetected) then {
			_unit setCaptive true;
			_unit action ["Surrender", _player]; 
			_unit call addActionLiberate;
			_unit call addActionLiberate;
			_unit call addActionLookInventory;
			_unit call addActionGetIntel;
		};
		/*_silencer = _gunner weaponAccessories currentMuzzle _gunner select 0;
		_hasSilencer = !isNil "_silencer" && {_silencer != ""};
		if (_hasSilencer || _distance > 160 || !isPlayer _gunner ) exitWith { true };
		_unit setBehaviour "AWARE";
		_unit forceWalk false;
		_unit forceSpeed (0-1);
		_unit setSpeedMode "FULL";
		_unit removeAllEventHandlers "FiredNear";*/
	}
];