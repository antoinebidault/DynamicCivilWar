
0 fadeSound .2;
titleCut ["Mission loading...", "BLACK FADED",999];
_cam = "camera" camcreate START_POSITION;
_cam cameraeffect ["internal", "back"];
showCinemaBorder true;

waitUntil {!isNull(CHOPPER_INTRO)};
_dest = START_POSITION;
_chopper = CHOPPER_INTRO;



if (daytime > 8 && daytime < 20) then {
	["Mediterranean",3,true] call bis_fnc_setppeffecttemplate;
};

sleep 1;

titleCut ["", "BLACK IN",10];

playMusic "seal";

[] spawn {
	sleep 4;
	nul = ["Bidass presents",.3,.7,8] spawn BIS_fnc_dynamicText;
	sleep 14;
	nul = ["An arma III scenario",.5,.2,8] spawn BIS_fnc_dynamicText;
	sleep 14;
	nul = ["<t color='#cd8700' size = '2.4'>Dynamic Civil War</t>",-1,-1,10,1,0] spawn BIS_fnc_dynamicText;
	sleep 13;
	nul = ["Music by Explosion in the sky",.3,.7,5] spawn BIS_fnc_dynamicText;
};

_camPos =  [getPos _chopper, 400,[getPos _chopper,_dest] call BIS_fnc_dirTo] call BIS_fnc_relPos;
_camPos set[2,30];
_cam camSetPos _camPos;
_cam camsettarget _dest;
_cam camcommit 0;

_camPos set[2,40];
_cam camSetPos _camPos;
_cam camcommit 14;

sleep 13;

_cam camsettarget _chopper modelToWorld[0,0,-14];
_cam camcommit 4;

sleep 14;

//[_cam,_chopper, [14,2,17], 7] call DCW_fnc_camfollow;

_smoke = "SmokeShellYellow" createVehicle  _dest; 

[_chopper] spawn{
	params["_chopper"];
	sleep 3;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 5;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 3;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
};

[_cam,_chopper, [0,40,4], 7] call DCW_fnc_camfollow;

deleteVehicle _smoke;
_dest set [2,5];
_cam camSetPos _dest;
_cam camsettarget _chopper modelToWorld[0,0,-10];
_cam camcommit 0;

_dest set [2,10]; 
_cam camSetPos _dest;
_cam camcommit 10;

sleep 10;

//[_cam,_chopper, [-14,22,-15],7] call DCW_fnc_camfollow;

titleCut ["", "BLACK OUT", 1];
sleep 1;
titleCut ["", "BLACK FADED", 9999];


camDestroy _cam;
showCinemaBorder false;
_cam cameraeffect ["terminate", "back"];
[_chopper] spawn{
	params["_chopper"];
	sleep 3;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 5;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 3;
	_chopper action ["useWeapon",_chopper,driver _chopper,1];
	sleep 40;
	8 fadeSound 1;	
};

["",0,true] call bis_fnc_setppeffecttemplate;

//[player, "All units deployed to the insertion point", 150, 250, 75, 1, [], 0, false] call BIS_fnc_establishingShot;

