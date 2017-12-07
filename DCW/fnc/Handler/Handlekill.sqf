/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

 params["_unit"];
 
 _unit addeventhandler ["Killed",
    { 
        params["_unit","_killer"];
        RemoveAllActions _unit;
        private _side = side group _unit;
        if (_side == CIV_SIDE && _killer == player)then{ 
            [_unit,_killer] call CIVILIAN_KILLED;
        }else{
            if (_side == ENEMY_SIDE && group _killer == group player)then{

                //Search intel;
                 [ _unit,"Search and secure","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 2","true",
                 {(_this select 1) playActionNow "TakeFlag";},
                 {},
                 {
                    _unit = (_this select 0);
                    [_unit,(_this select 1)] call ENEMY_SEARCHED;
                    [_unit, _this select 1,25] call fnc_GetIntel;
                },{},[],1,nil,true,false] call BIS_fnc_holdActionAdd;

                [_unit,_killer] call ENEMY_KILLED;
            };
        };
        _unit setVariable["DCW_IsIntel",false];
        _unit setVariable["unit_injured",false];
        deleteMarker (_unit getVariable["marker",""]);

    }
 ];