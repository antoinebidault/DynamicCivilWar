/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private["_type","_price","_unit","_pos"];

_type  = _this select 0;
_price = _this select 1;

if((DCW_SCORE - _price) >= 0)then {
	
	//Fermeture plus MAJ score 
	closeDialog 0;
	[GROUP_PLAYERS,-_price] remoteExec ["fnc_updateScore",2];   
	
	if (_type=="UAV")then{
		[HQ,"An UAV is moving toward your position",true] remoteExec ["fnc_talk"];
	    _pos = [(leader GROUP_PLAYERS), 2500, 3000, 0, 0, 20, 0] call BIS_fnc_FindSafePos;
		_unit = createVehicle [SUPPORT_DRONE_CLASS, [_pos select 0, _pos select 1, 300], [], 0,"FLY"];  
		createVehicleCrew _unit;  
		_unit setCaptive true;
		_unit move ((leader GROUP_PLAYERS) modelToWorld[0,0,300]);
		(leader GROUP_PLAYERS) connectTerminalToUAV _unit;
	}else{
		if (_type=="vehicle") then {
			[HQ,"A car will be droped at your position",true] remoteExec ["fnc_talk"];
			[leader GROUP_PLAYERS,300] execVM "DCW\supportui\fnc\VehicleLift.sqf";
		} else {
			[HQ,"Support provided",true] remoteExec ["fnc_talk"];
			_nb = (SUPPORT_REQUESTER getVariable [format ["BIS_SUPP_limit_%1", _type], 0]) + 1;
			[SUPPORT_REQUESTER, _type,_nb] call BIS_fnc_limitSupport;
			BIS_supp_refresh = TRUE; 
			publicVariable "BIS_supp_refresh";
		};
	};

}else{
	(leader GROUP_PLAYERS) sideChat "You can't afford it, not enough points... Try it later.";
};




