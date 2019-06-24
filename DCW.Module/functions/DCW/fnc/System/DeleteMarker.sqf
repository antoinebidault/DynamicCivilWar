/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

/*
Remove a marker associated to a unit. 
The marker name is stored in a variable.
BIDASS
*/

if (!DEBUG) exitWith {""};
deleteMarker (_this getVariable["marker",""]);
