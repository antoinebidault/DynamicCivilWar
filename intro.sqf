
private _chopper = vehicle player;
private _sniper = missionNamespace getVariable ["cut_sniper",objNull];
private _target = missionNamespace getVariable ["cut_target",objNull];
_cam = "camera" camcreate (_sniper modelToWorld[.5,4,.3]);
_cam cameraeffect ["internal", "back"];
titleCut ["", "BLACK FADED", 999];
sleep 3;
titleCut ["", "BLACK IN", 7];
_sniper setAmmo [currentWeapon _sniper, 0];

["RealIsBrown",3,true] call bis_fnc_setppeffecttemplate;


_cam camSetPos (_sniper modelToWorld[.5,4,.3]);
_cam camSetTarget (_sniper modelToWorld[-100,500,-20]);
_cam camCommit 0;

_cam camSetPos (_sniper modelToWorld[1,-.5,.3]);
_cam camCommit 20;
sleep 10;
playSound "rhs_rus_land_rc_08";
sleep 14;
_sniper doTarget _target;
_sniper setAmmo [currentWeapon _sniper, 10];
_sniper forceWeaponFire [weaponState _sniper select 1, weaponState _sniper select 2];
sleep .3;
_target setDamage 1;
sleep 4;
_cam camSetPos (_target modelToWorld[0,0,10]);
_cam camSetTarget (_target modelToWorld[.3,-.5,.3]);
_cam camCommit 0;
_cam camSetPos (_target modelToWorld[0,0,7]);
_cam camCommit 10;
sleep 10;

_cam camSetPos (_chopper modelToWorld[3,15,-3]);
_cam camSetTarget (_chopper modelToWorld[3,0,.5]);
_cam camCommit 0;
_null=[_cam,_chopper] spawn{
	params["_cam","_chopper"];
	private _loop = 0;
	while { _loop < 30 } do {
		_cam camSetPos (_chopper modelToWorld[3,60,2]);
		_cam camsettarget _chopper modelToWorld[3,0,.5];
		_cam camSetFov 1.0;
		_cam camcommit .5;
		sleep .2;
		_loop = _loop+.2;
	};
	_cam camSetPos (_chopper modelToWorld[7.5,-15,0]);
	_cam camsettarget _chopper modelToWorld[0,0,0];
	_cam camcommit 0;
	_loop = 0;
	while { _loop < 30 } do {
		_cam camSetPos (_chopper modelToWorld[7.5,-30,0]);
		_cam camsettarget _chopper modelToWorld[0,0,0];
		_cam camSetFov 1.0;
		_cam camcommit .5;
		sleep .2;
		_loop = _loop+.2;
	};
};


nul = ["Bidass presents",.3,.7,7] spawn BIS_fnc_dynamicText;
sleep 12;
nul = ["An arma III scenario",.3,.2,7] spawn BIS_fnc_dynamicText;
sleep 12;
nul = ["Addons by Red Hammer Studio",-.4,.7,7] spawn BIS_fnc_dynamicText;
sleep 3;
_chopper action ["useWeapon",_chopper,driver _chopper,1];
sleep 5;
_chopper action ["useWeapon",_chopper,driver _chopper,1];
sleep 3;
_chopper action ["useWeapon",_chopper,driver _chopper,1];
sleep 1;
sleep 5;
camDestroy _cam;
showCinemaBorder false;
_cam cameraeffect ["terminate", "back"];

//endMission "END1";