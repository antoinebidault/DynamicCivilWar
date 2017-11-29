params ["_unit"];

if (side _unit == CIV_SIDE)then
{
    _unit call addActionHandcuff;
    _unit call addActionHalt;
    _unit call addActionDidYouSee;
    _unit call addActionFeeling;
    _unit call addActionGetIntel;
    _unit call addActionRally;
    if ( _unit getVariable["IH_Chief",objNull] != objNull && alive (_unit getVariable["IH_Chief",objNull]))then{
        [_unit,_unit getVariable["IH_Chief",objNull]] call addActionFindChief;
    };
};
