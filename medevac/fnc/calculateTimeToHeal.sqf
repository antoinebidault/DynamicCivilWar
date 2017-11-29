/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */



params ["_unit", "_injured"];

private _time = REVIVETIME_INSECONDS;
_time = _time * (damage _injured * 0.414);

_time;