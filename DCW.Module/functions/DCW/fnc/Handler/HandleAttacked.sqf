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
			_unit removeAllEventHandlers "FiredNear";
			_unit setCaptive true;
			_unit action ["Surrender", _unit]; 
			removeHeadgear _unit;
			_weapon = currentWeapon _unit;       
			
			_dude removeWeapon (currentWeapon _unit);
			sleep .1;
			_weaponHolder = "WeaponHolderSimulated" createVehicle [0,0,0];
			_weaponHolder addWeaponCargoGlobal [_weapon,1];
			_weaponHolder setPos (_unit modelToWorld [0,.2,1.2]);
			_weaponHolder disableCollisionWith _unit;
			_dir = random(360);
			_speed = 1.5;
			_weaponHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir),4];  

			_unit call DCW_fnc_addActionLiberate;
			_unit call DCW_fnc_addActionLookInventory;
			_unit call DCW_fnc_addActionGetIntel;
			[_unit] call DCW_fnc_shout;
			[_gunner, ["This enemy is surrendering","He gives up !","Hands up !", "Your hands in the hair !"] call BIS_fnc_selectRandom, false] spawn DCW_fnc_talk;
		};
	}
];