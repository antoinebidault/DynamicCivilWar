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

[_compound,"secured"] call fnc_setCompoundState;
[_compound,50,10] spawn fnc_setCompoundSupport;