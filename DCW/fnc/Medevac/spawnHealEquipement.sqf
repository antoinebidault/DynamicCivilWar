/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

//credits:psycho
params [
	"_healer",
	"_injured",
	"_time"
];
if (!local _healer) exitWith {};

sleep 2;

medequip_array =[];
// spawn defi and a bloodbag
_defi_pos = _healer modelToWorld [-0.5,0.2,0];
_defi = "MedicalGarbage_01_Packaging_F" createVehicle _defi_pos;
[_defi, [_defi_pos select 0, _defi_pos select 1, 0]] call fnc_spawnObject;
_defi setDir (getDir _healer - 180);
medequip_array pushBack [1,_defi];
    
if (damage _injured >= 0.5 && {(random 2) >= 1}) then {
    _bb_pos = _healer modelToWorld [0.4,(0.2 - (random 0.5)),0];
    _bb = "MedicalGarbage_01_Injector_F" createVehicle _bb_pos;
    [_bb, [_bb_pos select 0, _bb_pos select 1, 0]] call fnc_spawnObject;
    _bb setDir (random 359);
    medequip_array pushBack [0,_bb];
};

// spawn bandages
for "_i" from 1 to (1 + (round random 3)) do {
	_band_pos = _healer modelToWorld [(random 1.3),(0.8 + (random 0.6)),0];
	_band = "Land_Bandage_F" createVehicle _band_pos;
	[_band, [_band_pos select 0, _band_pos select 1, 0]] call fnc_spawnObject;
	_band setDir (random 359);
	if (_i > 1) then {
		medequip_array pushBack [0,_band];
	} else {
		medequip_array pushBack [1,_band];
	};
};

// spawn antibioticum
if (random 2 >= 1) then {
	_ab_pos = _healer modelToWorld [-0.8,(0.6 - (random 0.4)),0];
	_ab = "MedicalGarbage_01_Bandage_F" createVehicle _ab_pos;
	[_ab, [_ab_pos select 0, _ab_pos select 1, 0]] call fnc_spawnObject;
	_ab setDir (random 359);
	medequip_array pushBack [0,_ab];
};

sleep _time ;
{deleteVehicle (_x select 1); sleep 1;}foreach medequip_array ;


true