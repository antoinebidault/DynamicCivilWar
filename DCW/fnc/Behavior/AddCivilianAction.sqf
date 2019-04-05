/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_unit"];

if (side _unit == CIV_SIDE)then
{
    _unit call addActionHandcuff;
     _unit call addActionHalt;
    if ( _unit getVariable["DCW_Chief",objNull] != objNull && alive (_unit getVariable["DCW_Chief",objNull]))then{
        [_unit,_unit getVariable["DCW_Chief",objNull]]  call addActionFindChief;
    };
    _unit call addActionDidYouSee;
    _unit call addActionFeeling;
    _unit call addActionGetIntel;
    _unit call addActionRally;
    _unit call addActionLeave;
};
