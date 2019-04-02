/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_unit"];

if (side _unit == CIV_SIDE)then
{
    _unit remoteExec ["addActionHandcuff",0];
    _unit remoteExec ["addActionHalt",0];
    if ( _unit getVariable["DCW_Chief",objNull] != objNull && alive (_unit getVariable["DCW_Chief",objNull]))then{
        [_unit,_unit getVariable["DCW_Chief",objNull]] remoteExec ["addActionFindChief",0];
    };
    _unit remoteExec ["addActionDidYouSee",0];
    _unit remoteExec ["addActionFeeling",0];
    _unit remoteExec ["addActionGetIntel",0];
    _unit remoteExec ["addActionRally",0];
    _unit remoteExec ["addActionLeave",0];
};
