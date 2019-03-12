/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_unit"];

if (side _unit == CIV_SIDE)then
{
    _unit remoteExec ["addActionHandcuff"];
    _unit remoteExec ["addActionHalt"];
    if ( _unit getVariable["DCW_Chief",objNull] != objNull && alive (_unit getVariable["DCW_Chief",objNull]))then{
        [_unit,_unit getVariable["DCW_Chief",objNull]] remoteExec ["addActionFindChief"];
    };
    _unit remoteExec ["addActionDidYouSee"];
    _unit remoteExec ["addActionFeeling"];
    _unit remoteExec ["addActionGetIntel"];
    _unit remoteExec ["addActionRally"];
    _unit remoteExec ["addActionLeave"];

};
