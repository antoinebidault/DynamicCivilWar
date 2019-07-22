/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/
if (!isServer) exitWith{};

private["_type","_price"];

_type  = _this select 0;
_price = _this select 1;
_leader = leader GROUP_PLAYERS;

if((DCW_SCORE - _price) >= 0)then {
	
	//Fermeture plus MAJ score 
	closeDialog 0;
	
	[GROUP_PLAYERS,-_price] remoteExec ["DCW_fnc_updateScore",2];   
	
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
			[HQ,"Support provided",true] remoteExec ["DCW_fnc_talk"];
			[_leader,{
				COMMENU_TRANSPORT_ID = [_this, "TransportParadrop"] call BIS_fnc_addCommMenuItem;
				publicVariable "COMMENU_TRANSPORT_ID";
			}] remoteExec ["spawn",owner _leader];
		} else {
			if (_type == "buildingKit") then {
				[HQ,"Support provided",true] remoteExec ["DCW_fnc_talk"];
				[_leader,{
					COMMENU_OUTPOST_ID = [_this, "OutpostBuildingKit"] call BIS_fnc_addCommMenuItem;
					publicVariable "COMMENU_OUTPOST_ID";
				}] remoteExec ["spawn",owner _leader];
			} else {
				[HQ,"Support provided",true] remoteExec ["DCW_fnc_talk"];
				_nb = (SUPPORT_REQUESTER getVariable [format ["BIS_SUPP_limit_%1", _type], 0]) + 1;
				[SUPPORT_REQUESTER, _type,_nb] remoteExec ["BIS_fnc_limitSupport"];

			}; 
		};
	};
	sleep 1; 
	BIS_supp_refresh = TRUE; 
	publicVariable "BIS_supp_refresh";
}else{
	"You can't afford it, not enough points... Try it later." remoteExec["hint",owner _leader];
};






