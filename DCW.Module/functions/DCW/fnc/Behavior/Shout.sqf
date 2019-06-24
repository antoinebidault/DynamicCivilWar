/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params ["_unit"]; 

_deathsound = format ["A3\sounds_f\characters\human-sfx\P0%1\Hit_Max_%2.wss", selectRandom [4,5,6,7,8,9], selectRandom [1,2,3,4,5]];
playSound3D [_deathsound, _unit, false, getPosASL _unit, 1.5, 1, 150];	