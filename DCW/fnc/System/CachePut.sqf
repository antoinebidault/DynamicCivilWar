/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

/*
Put a compound with all associated units in cache
The precise number of units remained is kept in memory in an array
The main purpose is to keep the same effective as before with just a randomization on the spawnng positions.
BIDASS
*/

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
_nbFriendlies = 0;
_unitsToRemove = [];

{
    _type = _x getVariable["DCW_Type",""];

    if (_type == "") then{
        _x call fnc_deleteMarker;
        deleteVehicle _x;
    }else{
        
        //If dead, we remove him
        if (!alive _x)then{
             _x call fnc_deleteMarker;
            _unitsToRemove pushBack _x;
            deleteVehicle _x;
        }else{
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
                                                }else{
                                                    if (_type == "friendly")then{
                                                        _nbFriendlies = _nbFriendlies+1;
                                                    };
                                                };   
                                            };
                                        };
                                    };   
                                };
                            };
                        };
                    };
                };

            // If it's a vehicle
            if (vehicle _x != _x) then {
                { _x call fnc_deletemarker; deletevehicle _x; } foreach crew _x;
            };
             _x call fnc_deleteMarker;
            deleteVehicle _x;
        };
   };
   
    UNITS_SPAWNED = UNITS_SPAWNED - [_x];
}
foreach _units;

// Clean up objNull ied
_tmpIEDs = IEDS;
{
    if (isNull (_x select 0)) then {
        _tmpIEDs = _tmpIEDs - [_x]; 
    };
} foreach IEDS;
IEDS = _tmpIEDs;
publicVariable "IEDS";

[[_nbPeople,_nbSniper,_nbEnemies,_nbCars,_nbIeds,_nbCaches,_nbHostages,_nbMortars,_nbOutpost,_nbFriendlies],_unitsToRemove];


