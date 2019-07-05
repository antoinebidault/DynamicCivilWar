/*
  Author: 
    Bidass

  Description:
    triggered when a compound is secured

  Parameters:
    0: ARRAY - the compound's data array (In MARKERS global scope variable)

*/


params["_compound"];
// Set the correct state

[_compound,"secured"] call DCW_fnc_setCompoundState;
[_compound,50,10] spawn DCW_fnc_setCompoundSupport;