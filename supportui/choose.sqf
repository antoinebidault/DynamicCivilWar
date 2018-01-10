/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private["_type","_price","_unit","_pos"];

_type  = _this select 0;
_price = _this select 1;

if( ((player getVariable["DCW_SCORE",0]) - _price) >= 0)then {
	
	//Fermeture plus MAJ score 
	closeDialog 0;
	[player,-_price] call fnc_updatescore;

	if (_type!="UAV")then{
		_nb = (SUPPORT_REQUESTER getVariable [format ["BIS_SUPP_limit_%1", _type], 0]) + 1;
		[SUPPORT_REQUESTER, _type,_nb] call BIS_fnc_limitSupport;
		BIS_supp_refresh = TRUE; 
		publicVariable "BIS_supp_refresh";
	}else{
		[HQ,"An UAV is moving toward your position"] call fnc_talk;
	    _pos = [player, 2500, 3000, 0, 0, 20, 0] call BIS_fnc_FindSafePos;
		_unit = createVehicle [DRONE_CLASS, [_pos select 0, _pos select 1, 300], [], 0,"FLY"];  
		createVehicleCrew _unit;  
		_unit setVelocity [60 * (sin (getDir this)), 60 * (cos (getDir this)),10];
		_unit move (player modelToWorld[0,0,300]);
		player connectTerminalToUAV _unit;
	};

}else{
	player sideChat "You can't afford it, not enough points... Try it later.";
};




