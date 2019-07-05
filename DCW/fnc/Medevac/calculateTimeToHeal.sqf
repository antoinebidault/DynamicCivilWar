/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - unit
    1: OBJECT - Injured unit

  Returns:
    BOOL - true 
*/



params ["_unit", "_injured"];

private _time = REVIVETIME_INSECONDS;
_time = _time * (damage _injured * 0.414);

_time;