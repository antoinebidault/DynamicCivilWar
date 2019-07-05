/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

/*
Remove a marker associated to a unit. 
The marker name is stored in a variable.
BIDASS
*/

if (!DEBUG) exitWith {""};
deleteMarker (_this getVariable["marker",""]);
