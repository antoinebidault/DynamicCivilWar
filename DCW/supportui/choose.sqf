/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private["_type","_price","_unit","_pos"];

_type  = _this select 0;
_price = _this select 1;

if( ((GROUP_PLAYERS getVariable["DCW_SCORE",0]) - _price) >= 0)then {
	
	//Fermeture plus MAJ score 
	closeDialog 0;
	[GROUP_PLAYERS,-_price] call fnc_updatescore;
	
	if (_type!="UAV")then{
		[HQ,"Support provided",true] remoteExec ["fnc_talk"];
		_nb = (SUPPORT_REQUESTER getVariable [format ["BIS_SUPP_limit_%1", _type], 0]) + 1;
		[SUPPORT_REQUESTER, _type,_nb] remoteExec ["BIS_fnc_limitSupport", 0, true];
		BIS_supp_refresh = TRUE; 
		publicVariable "BIS_supp_refresh";
	}else{
		[HQ,"An UAV is moving toward your position",true] remoteExec ["fnc_talk"];
	    _pos = [LEADER_PLAYERS, 2500, 3000, 0, 0, 20, 0] call BIS_fnc_FindSafePos;
		_unit = createVehicle [SUPPORT_DRONE_CLASS, [_pos select 0, _pos select 1, 300], [], 0,"FLY"];  
		createVehicleCrew _unit;  
		_unit setCaptive true;
		_unit move (LEADER_PLAYERS modelToWorld[0,0,300]);
		LEADER_PLAYERS connectTerminalToUAV _unit;
	};

}else{
	LEADER_PLAYERS sideChat "You can't afford it, not enough points... Try it later.";
};




