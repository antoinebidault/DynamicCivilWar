/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params["_unit"];
fnc_ActionRest =  {
    _this addAction ["Rest (3 hours)", {
        params["_unit","_asker","_action"];
        if((_unit findNearestEnemy _unit) distance _unit < 100)exitWith {[_unit,"Impossible untill there is enemies around",false] call fnc_talk;};
        _unit removeAction _action;
        _newObjs = [getPos _unit,getDir _unit, compo_rest ] call BIS_fnc_ObjectsMapper;
        _camPos = _unit modelToWorld [.3,2.2,2];
        _cam = "camera" camcreate _camPos;
        _cam cameraeffect ["internal", "back"];
        _cam camSetPos _camPos;
        _cam camSetTarget _unit;
        _cam camSetFov 1.05;
        _cam camCommit 30;
        _unit stop true;
        sleep 2;
        _unit action ["sitdown",_unit];
        sleep 3;
        setAccTime 120;
        sleep 25;
        setAccTime 1;
        skipTime 3;
        sleep 3;
        [_unit,"Ok, let's go back to work !",false] call fnc_Talk;
        _unit action ["sitdown",_unit];

        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;

        _unit setFatigue 0;
        _unit setStamina 1;
        _unit enableStamina false;
        _unit enableFatigue false;

        { deleteVehicle _x; }foreach _newObjs;

        sleep 1;
        disableUserInput false;
        sleep 3;

        [_unit,_action]spawn{
            params["_unit","_action"];
            sleep 60;
            _unit enableStamina true;
            _unit enableFatigue true;
            sleep 500;
            _unit call fnc_ActionRest;
        };
    },nil,1.5,false,true,"","if(vehicle(_this) == _this)then{true}else{false};",15,false,""];
 };


_unit call fnc_ActionRest;