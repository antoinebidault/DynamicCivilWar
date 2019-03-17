if (didJIP) exitWith{ false };

playMusic "ASOTheme";

sleep 3;
titleCut ["", "BLACK IN", 7];
_cam = "camera" camcreate [4599.38,2317.12,10.9028];
_cam cameraeffect ["internal", "back"];
_cam camSetPos [4599.38,2317.12,10.3];
_cam camSetTarget [4612,2288.64,1];
_cam camCommit 0;

_cam camSetPos [4599.38,2317.12,1.3];
_cam camSetFov .9;

_cam camCommit 20;

sleep 24;

[] spawn {
	nul = ["Bidass presents",.3,.7,7] spawn BIS_fnc_dynamicText;
	sleep 12;
	nul = ["An arma III scenario",.3,.2,7] spawn BIS_fnc_dynamicText;
	sleep 12;
	nul = ["Dynamic Civil War",-1,-1,4,1,0] spawn BIS_fnc_dynamicText;
};


_cam camSetPos [4757.76,2270.84,3.5422];
_cam camSetTarget [4649.6,2231.56,0];
_cam camCommit 0;

_cam camSetPos [4757.76,2270.84,1.5422];
_cam camSetFov .9;
_cam camCommit 5;

sleep 5;

_cam camSetPos [4692.01,2238.88,1.7];
_cam camSetTarget [4744.7,2264.79,1];
_cam camCommit 0;

_cam camSetFov .8;
_cam camCommit 6;

sleep 16;

camDestroy _cam;
showCinemaBorder false;
_cam cameraeffect ["terminate", "back"];

/*
private _chopper = vehicle player;
private _sniper = missionNamespace getVariable ["cut_sniper",objNull];
private _target = missionNamespace getVariable ["cut_target",objNull];
_cam = "camera" camcreate (_sniper modelToWorld[.5,4,.3]);
_cam cameraeffect ["internal", "back"];
/*
sleep 3;
_sniper setAmmo [currentWeapon _sniper, 0];

["RealIsBrown",3,true] call bis_fnc_setppeffecttemplate;


_cam camSetPos (_sniper modelToWorld[.5,4,.3]);
_cam camSetTarget (_sniper modelToWorld[-100,500,-20]);
_cam camCommit 0;

_cam camSetPos (_sniper modelToWorld[1,-.5,.3]);
_cam camCommit 20;
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

sleep 7;
titleCut ["", "BLACK OUT", 3];
sleep 3;
titleCut ["", "BLACK FADED", 2];
sleep 2;
titleCut ["", "BLACK IN", 5];

_cam camSetPos (_chopper modelToWorld[3,15,-3]);
_cam camSetTarget (_chopper modelToWorld[3,0,.5]);
_cam camCommit 0;
_null=[_cam,_chopper] spawn{
	params["_cam","_chopper"];
	private _loop = 0;
	while { _loop < 30 } do {
		_cam camSetPos (_chopper modelToWorld[3,50,2]);
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
	while { _loop < 10 } do {
		_cam camSetPos (_chopper modelToWorld[7.5,-30,0]);
		_cam camsettarget _chopper modelToWorld[0,0,0];
		_cam camSetFov 1.0;
		_cam camcommit .5;
		sleep .2;
		_loop = _loop+.2;
	};
	_cam camSetPos  (_chopper modelToWorld[7.5,-30,0]);
	_cam camsettarget (_chopper modelToWorld[0,0,0]);
	_cam camcommit 0;

	_cam camSetPos [7890.86,11665.3,2];
	_cam camsettarget _chopper;
	_cam camSetFov 1.0;
	_cam camcommit 6;
	sleep 15;
};

sleep 3;
_chopper action ["useWeapon",_chopper,driver _chopper,1];
sleep 5;
_chopper action ["useWeapon",_chopper,driver _chopper,1];
sleep 3;
_chopper action ["useWeapon",_chopper,driver _chopper,1];
sleep 1;
sleep 8;
camDestroy _cam;
showCinemaBorder false;
_cam cameraeffect ["terminate", "back"];

playMusic "ASOTheme";
titleCut ["Prepare for landing...", "BLACK FADED", 999];
["",0,true] call bis_fnc_setppeffecttemplate;
[] Spawn {
    _loc =  nearestLocations [getPosWorld player, ["NameVillage","NameCity","NameCityCapital"],10000] select 0;
	
	// Info text
	[worldName, format["%1km from %2", round(((getPos _loc) distance2D player)/10)/100,text _loc], str(date select 1) + "." + str(date select 2) + "." + str(date select 0)] spawn BIS_fnc_infoText;
	sleep 5;
	"dynamicBlur" ppEffectEnable true;  
	"dynamicBlur" ppEffectAdjust [6];   
	"dynamicBlur" ppEffectCommit 0;     
	"dynamicBlur" ppEffectAdjust [0.0];  
	"dynamicBlur" ppEffectCommit 5;  
	titleCut ["", "BLACK IN", 5];
};
*/