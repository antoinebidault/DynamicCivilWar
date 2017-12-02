/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */


RemoveAllActions _this;
_this setVariable["DCW_LocalChief",true];

removeGoggles _this;
_this addGoggles (["G_Spectacles_Tinted","G_Aviator"] call BIS_fnc_selectRandom);
_this addHeadgear "LOP_H_ChDKZ_Beret";



_this addAction["Give me some information about your chief",{
    (_this select 0) call fnc_MainObjectiveIntel;
}];

/*
_this addAction["Ask for medical supplies",{
    [(_this select 0),-1] call fnc_updateRep;
}];
*/

_this addAction["Set up camp here",{
    params["_unit","_asker"];

    _buildings = nearestObjects [getPos _unit, ["house"], 300];
    {
        if ([_x, 3] call BIS_fnc_isBuildingEnterable) then {
            _posBuilding = [_x] call BIS_fnc_buildingPositions;
            RESPAWN_POSITION = ([_posBuilding] call BIS_fnc_selectRandom) select 0;
            if (true) exitWith{true};
        };
    } foreach _buildings;
    
    [_asker,"Is it possible to set up our camp here ?"] call fnc_talk;
    [_unit,format["Alright...",_dir]] call fnc_talk;
    [_unit,-1] call fnc_updateRep;
    hint "Next time, you'll respawn at this position.";
}];
