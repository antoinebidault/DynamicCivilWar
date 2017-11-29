

params ["_unit", "_injured"];

private _time = REVIVETIME_INSECONDS;
_time = _time * (damage _injured * 0.414);

_time;