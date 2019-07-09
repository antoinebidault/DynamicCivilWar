/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: Bidass

  Version:
    {VERSION}
 * License : GNU (GPL)
 * Get the current visibility of an item
 */

params["_unit","_en"];
if (isNil '_unit' || isNil '_en')exitWith{0};
private _vis1 = eyepos _unit;
private _vis2 = AGLToASL (_unit modelToWorld (_unit selectionPosition "pelvis"));
private _vis3 = AGLToASL (_unit modelToWorld (_unit selectionPosition "rightshoulder"));
private _vis4 = AGLToASL (_unit modelToWorld (_unit selectionPosition "leftshoulder"));
private _visibility = [_vis1,_vis2,_vis3,_vis4] apply {[_unit,"view"] checkvisibility [eyepos _en,_x]};
_visibility = round ((_visibility call BIS_fnc_arithmeticMean) *100);
_visibility;