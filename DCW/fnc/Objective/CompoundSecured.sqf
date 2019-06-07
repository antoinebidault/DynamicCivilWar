/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * 
 * Add a marker to map
 */


params["_unit"];

// Set the correct state
[_securedMarker,"secured"] call fnc_setCompoundState;
[_securedMarker,50,10] spawn fnc_setCompoundSupport;