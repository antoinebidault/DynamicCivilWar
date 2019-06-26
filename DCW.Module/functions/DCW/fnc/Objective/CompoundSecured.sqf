/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * 
 * Add a marker to map
 */ 
params["_compound"];
// Set the correct state

[_compound,"secured"] call DCW_fnc_setCompoundState;
[_compound,50,10] spawn DCW_fnc_setCompoundSupport;