/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

params["_unit"];
fnc_ActionRest =  {
    _this addAction ["Rest", {
        params["_unit","_asker","_action"];
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
        skipTime .25;
        sleep 3;

        _cam cameraeffect ["terminate", "back"];
        camDestroy _cam;

        [_unit,"Ok, let's go back to work !"] call fnc_Talk;
        _unit setFatigue 0;
        _unit setStamina 1;
        _unit enableStamina false;
        _unit enableFatigue false;

        { deleteVehicle _x; }foreach _newObjs;

        _unit action ["sitdown",_unit];
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