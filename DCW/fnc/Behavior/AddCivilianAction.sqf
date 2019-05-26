/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_unit"];

if (side _unit == SIDE_CIV) then
{
    _unit call addActionHalt;
    _unit call addActionLeave;
    _unit call addActionHandcuff;
};
