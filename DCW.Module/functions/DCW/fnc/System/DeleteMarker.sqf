/*
  Author: 
    Bidass

  Description:
    Remove a marker associated to a unit. 
    The marker name is stored in a variable.

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

if (!DEBUG) exitWith {""};
deleteMarker (_this getVariable["marker",""]);
