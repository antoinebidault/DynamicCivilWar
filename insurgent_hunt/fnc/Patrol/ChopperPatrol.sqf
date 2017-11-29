private ["_newPos"];
params["_chopper"];
private _grp = group _chopper;
_chopper flyInHeight 75;
_grp setSpeedMode "LIMITED";
sleep random 50;

while { alive _chopper }do{
    sleep .4;
     _newPos = ([player, 0, 450, 0, 0, 20, 0] call BIS_fnc_findSafePos);
     _grp move _newPos;
    waitUntil {(_chopper distance2D _newPos) < 140};
    sleep .4;
      _newPos = ([player,2500, 3500, 0, 0, 20, 0] call BIS_fnc_findSafePos);
     _grp move _newPos;
    waitUntil {(_chopper distance2D _newPos) < 140};
    sleep random 100;
}