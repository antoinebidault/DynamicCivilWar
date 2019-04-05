/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

 params["_unit"];
 
 _unit addMPEventHandler ["MPKilled",
    { 
        params["_unit","_killer"];
        _unit remoteExec ["RemoveAllActions",0];
        private _side = side group _unit;
        if (_side == CIV_SIDE && isPlayer _killer)then{ 
            [_unit,_killer] call CIVILIAN_KILLED;
        }else{
            if (_side == ENEMY_SIDE && group _killer == GROUP_PLAYERS)then{

                [_unit, ["Disguise",{
                    params ["_enemy","_unit"];
                    [_unit,_enemy] spawn fnc_undercover;
                },nil,1.5,false,true,"","true",3,false,""]] remoteExec["addAction",0];

                //Search intel;
                 [ _unit,"Search and secure","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 2","true",
                 {(_this select 1) playActionNow "TakeFlag";},
                 {},
                 {
                    _unit = (_this select 0);
                    _player = (_this select 1);
                    [_unit,_player] remoteExec ["ENEMY_SEARCHED",2];
                    [_unit, _player,25] remoteExec ["fnc_GetIntel",2];
                },{},[],1,nil,true,false] remoteExec ["BIS_fnc_holdActionAdd",0 , true];

                [_unit,_killer] call ENEMY_KILLED;
            };
        };
        _unit setVariable["DCW_IsIntel",false];
        _unit setVariable["unit_injured",false, true];
        _unit call fnc_deleteMarker;

    }
 ];