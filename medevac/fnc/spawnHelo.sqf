private ["_transporthelo","_chopper","_start","_ch"];

_chopper = missionNamespace getVariable ["medevac_chopper" , objNull];
_chopperClassName = typeOf _chopper;
_start = position _chopper;
_ch = [[_start select 0, _start select 1, 50], 180, _chopperClassName, side unit] call BIS_fnc_spawnVehicle;
_transporthelo = _ch select 0;
_chGroup = _ch select 2; // group of helo so waypoints work.
_chGroup setBehaviour "CARELESS"; // Make sure they don't get distracted.
//_transporthelo flyInHeight 50;
_transporthelo setVehicleLock "LOCKEDPLAYER";
_transporthelo setCaptive true;

_transporthelo addEventHandler["Killed",{
    [transportHelo] call fnc_abortMedevac;
}];

_transporthelo;