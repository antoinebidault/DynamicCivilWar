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
        RemoveAllActions _unit;
        private _side = side group _unit;
        if (_side == CIV_SIDE && isPlayer _killer)then{ 
            [_unit,_killer] call CIVILIAN_KILLED;
        }else{
            if (_side == ENEMY_SIDE && group _killer == GROUP_PLAYERS)then{

                _unit addAction["Disguise",{
                    params ["_enemy","_unit"];
                    [_unit,_enemy] spawn fnc_undercover;
                },nil,1.5,true,true,"","true",3,false,""];

                //Search intel;
                 [ _unit,"Search and secure","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 2","true",
                 {(_this select 1) playActionNow "TakeFlag";},
                 {},
                 {
                    _unit = (_this select 0);
                    _player = (_this select 1);
                    [_unit,_player] call ENEMY_SEARCHED;
                    
                    _resIntel = [_unit, _player,25] call fnc_GetIntel;
                    if(_resIntel select 0) then {[_player, "HQ, I found some informations !",true] spawn fnc_talk;};
                },{},[],1,nil,true,false] remoteExec ["BIS_fnc_holdActionAdd"];

                [_unit,_killer] call ENEMY_KILLED;
            };
        };
        _unit setVariable["DCW_IsIntel",false];
        _unit setVariable["unit_injured",false];
        _unit call fnc_deleteMarker;

    }
 ];