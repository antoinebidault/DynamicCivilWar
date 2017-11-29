private["_type","_units","_nbPeople","_nbSniper","_nbEnemies","_nbCars","_unitsToRemove","_nbIeds"];
_units = _this select 0;

_nbPeople = 0;
_nbSniper = 0;
_nbEnemies = 0;
_nbCars = 0;
_nbIeds = 0;
_nbHostages = 0;
_nbCaches = 0;
_nbMortars = 0;
_nbOutpost = 0;
_unitsToRemove = [];

{
    _type = _x getVariable["IH_type",""];
    
    
    //If dead, we remove him
    if (!alive _x)then{
        if (DEBUG)then{ 
            deleteMarker (_x getVariable["marker",""]);
        };
        _unitsToRemove pushBack _x;
        deleteVehicle _x;
    }else{
        //if (_x distance player > 350)then{
            //Suppression de la tâche
            _x call fnc_failed;
            _unitsToRemove pushBack _x;
            if (_type == "civ")then{
                _nbPeople = _nbPeople+1;
            }else{
                if (_type == "enemy")then{
                    _nbEnemies = _nbEnemies+1;
                }else{
                    if (_type == "sniper")then{
                        _nbSniper = _nbSniper+1;
                    }else{
                        if (_type == "car")then{
                            _nbCars = _nbCars+1;
                        }else{
                            if (_type == "ied")then{
                                _nbIeds = _nbIeds+1;
                            }else{
                                if (_type == "cache")then{
                                    _nbCaches = _nbCaches+1;
                                }else{
                                    if (_type == "hostage")then{
                                        _nbHostages = _nbHostages+1;
                                    }else{
                                        if (_type == "mortar")then{
                                            _nbMortars = _nbMortars+1;
                                        }else{
                                            if (_type == "outpost")then{
                                                _nbOutpost = _nbOutpost+1;
                                            };   
                                        };
                                    };
                                };   
                            };
                        };
                    };
                };
            };
       // };
        if (DEBUG)then{ 
            deleteMarker (_x getVariable["marker",""]);
        };
        deleteVehicle _x;
    };
   
   
    UNITS_SPAWNED = UNITS_SPAWNED - [_x];
}
foreach _units;

[[_nbPeople,_nbSniper,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost],_unitsToRemove];

/*
_unit setVariable["unit_cached",true];
(_unit getVariable["marker",objNull]) setMarkerAlpha 0;
_unit enableSimulationGlobal false;
_unit disableAI "ALL";
_unit hideObjectGlobal true;
UNITS_SPAWNED = UNITS_SPAWNED - [_unit];
UNITS_CACHED pushback _unit;
*/
