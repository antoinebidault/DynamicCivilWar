/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private ["_transporthelo","_chopper","_start","_ch"];

//_chopper = missionNamespace getVariable ["medevac_chopper" , objNull];
_chopperClassName = "RHS_UH60M_d";
_start = [position player, 4000, 4500, 0, 0, 20, 0] call BIS_fnc_findSafePos;

_ch = [[_start select 0, _start select 1, 50], 180, _chopperClassName, side unit] call BIS_fnc_spawnVehicle;

_transporthelo = _ch select 0;
_chGroup = _ch select 2; 
_chGroup setBehaviour "CARELESS"; 
_transporthelo setVehicleLock "LOCKEDPLAYER";
_transporthelo setCaptive true;

//If the chopper is destroyed => Abort medevac
_transporthelo addEventHandler["Killed",{
    [transportHelo] call fnc_abortMedevac;
}];

_transporthelo;