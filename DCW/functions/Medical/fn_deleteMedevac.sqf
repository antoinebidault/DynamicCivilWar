/*
  Author: 
    Bidass

  Version:
    0.9.1

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

params["_helo","_grp"];

(leader _grp) removeAction MEDEVAC_action;
if(!isNull _helo)then{
	{ deleteVehicle _x ;} forEach units interventionGroup;
	{ deleteVehicle _x ;} forEach crew _helo;
	deleteVehicle _helo;
	
sleep 5;
	
[HQ,localize "STR_DCW_voices_HQ_rtb",true] remoteExec ["DCW_fnc_talk"];

};
