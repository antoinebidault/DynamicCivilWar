if (didJIP) exitWith{ false };

playMusic "seal";
0 fadeSound .1;
0 fadeMusic 1;
if (daytime > 8 && daytime < 20) then {
	["Mediterranean",3,true] call bis_fnc_setppeffecttemplate;
};


sleep 3;
titleCut ["", "BLACK IN",14];
private _chopper = missionNamespace getVariable ["cut_chopper",objNull];
{ _x moveInCargo _chopper;} foreach units GROUP_PLAYERS;

_cam = "camera" camcreate getPos _chopper;
_cam cameraeffect ["internal", "back"];
_cam camSetPos (_chopper modelToWorld[3,50,2]);

[] spawn {
	sleep 3;
	nul = ["Bidass presents",.3,.7,7] spawn BIS_fnc_dynamicText; 
	sleep 13;
	nul = ["An arma III scenario",.3,.2,7] spawn BIS_fnc_dynamicText;
	sleep 16;
	nul = ["Dynamic Civil War",-1,-1,4,1,0] spawn BIS_fnc_dynamicText;
}; 

[_chopper, [30,2,17], 6] call DCW_fnc_camFollow;
[_chopper, [0,45,4], 13] call DCW_fnc_camFollow;
[_chopper, [7,40,20], 17] call DCW_fnc_camFollow;
titleCut ["", "BLACK OUT", 3];
sleep 3;
titleCut ["", "BLACK FADED", 9999];

camDestroy _cam;
showCinemaBorder false;

_cam cameraeffect ["terminate", "back"];
5 fadeSound 1;
