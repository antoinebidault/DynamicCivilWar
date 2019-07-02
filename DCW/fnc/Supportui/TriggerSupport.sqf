/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */
if (!isServer) exitWith{};

private["_type","_price"];

_type  = _this select 0;
_price = _this select 1;

if((DCW_SCORE - _price) >= 0)then {
	
	//Fermeture plus MAJ score 
	closeDialog 0;
	_leader = leader GROUP_PLAYERS;
	[GROUP_PLAYERS,-_price] call DCW_fnc_updateScore;   
	
	if (_type=="UAV")then{
		[HQ,"An UAV is moving toward your position",true] remoteExec ["DCW_fnc_talk"];
	    _pos = [_leader, 2500, 3000, 0, 0, 20, 0] call BIS_fnc_findSafePos;
		_drone = createVehicle [SUPPORT_DRONE_CLASS, [_pos select 0, _pos select 1, 300], [], 0,"FLY"];  
		createVehicleCrew _drone;  
		_drone setCaptive true;
		_drone move (_leader modelToWorld[0,0,300]);
		_leader connectTerminalToUAV _drone;
	}else{
		if (_type=="vehicle") then {
			[HQ,"A car will be dropped at your position",true] remoteExec ["DCW_fnc_talk"];
			COMMENU_TRANSPORT_ID = [(_leader), "TransportParadrop"] remoteExec ["BIS_fnc_addCommMenuItem",_leader];
			publicVariableServer "COMMENU_TRANSPORT_ID";
		} else {
			[HQ,"Support provided",true] remoteExec ["DCW_fnc_talk"];
			_nb = (SUPPORT_REQUESTER getVariable [format ["BIS_SUPP_limit_%1", _type], 0]) + 1;
			[SUPPORT_REQUESTER, _type,_nb] remoteExec ["BIS_fnc_limitSupport"];
			BIS_supp_refresh = TRUE; 
			publicVariable "BIS_supp_refresh";
		};
	};

}else{
	(_leader) sideChat "You can't afford it, not enough points... Try it later.";
};




