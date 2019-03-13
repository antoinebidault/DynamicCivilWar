/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

if (count (_this select 0) < 2) exitWith {[objNull];};

_listFirePlace = ["Campfire_burning_F", "FirePlace_burning_F",  "Land_FirePlace_F",  "MetalBarrel_burning_F"];

_fire = (_listFirePlace call BIS_fnc_selectRandom) createVehicle (_this select 0);

private _marker = createMarker [str(_this select 0), (_this select 0)];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [4,4];
_marker setMarkerBrush "SolidBorder";
_marker setMarkerText "Meeting point";
_marker setMarkerColor "ColorYellow";
_fire setVariable["marker",_marker];

[_fire];