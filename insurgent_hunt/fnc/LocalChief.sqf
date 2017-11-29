
RemoveAllActions _this;
_this setVariable["IH_LocalChief",true];

removeGoggles _this;
_this addGoggles (["G_Spectacles_Tinted","G_Aviator"] call BIS_fnc_selectRandom);
_this addHeadgear "LOP_H_ChDKZ_Beret";


_this addAction["What can I do for you ?",{

}];

_this addAction["Ask for medical supplies",{
    [(_this select 0),-1] call fnc_updateRep;
}];

_this addAction["Set up an outpost here...",{
    [(_this select 0),-1] call fnc_updateRep;
     private _buildings = nearestObjects [getPos (_this select 0), ["house"], 300];
    {
        if ([_x, 3] call BIS_fnc_isBuildingEnterable) then {
            _posBuilding = [_x] call BIS_fnc_buildingPositions;
            RESPAWN_POSITION = ([_posBuilding] call BIS_fnc_selectRandom) select 0;
            if (true) exitWith{true};
        };
    } foreach _buildings;

}];
