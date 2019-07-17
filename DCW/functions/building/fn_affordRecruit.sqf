
if (isNull player) exitWith{};

_index = lbCurSel 1500;

_unitName = (FRIENDLY_LIST_UNITS select _index);
_price = (FRIENDLY_LIST_UNITS select _index) call DCW_fnc_getUnitCost;

if (!([GROUP_PLAYERS,_price] call DCW_fnc_afford)) exitWith { hint "Can't buy this item"; };

closeDialog 0;

sleep .1;

_radius = 60;
_grp = createGroup SIDE_FRIENDLY;
_pos = [getPos player, 0,7,1,0,20] call BIS_fnc_findSafePos;
_unit = [_grp,_pos,true,_unitName] call DCW_fnc_spawnFriendly;
_unit enableDynamicSimulation true;
_buildings = [getpos _unit, _radius] call DCW_fnc_findBuildings;
[_grp,"DCW_fnc_simplePatrol", [_grp,_radius,false]] call DCW_fnc_patrolDistributeToHC;
[_unit,format["private %1, at your command !", name _unit],false] call DCW_fnc_talk;
[player,"Welcome soldier !",false]  call DCW_fnc_talk;