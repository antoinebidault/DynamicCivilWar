/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Make a unit shout (Using vanilla sound)

  Parameters:
    0: OBJECT - unit who is shouting

  Returns:
    BOOL - true 
*/

params ["_unit"]; 

_deathsound = format ["A3\sounds_f\characters\human-sfx\P0%1\Hit_Max_%2.wss", selectRandom [4,5,6,7,8,9], selectRandom [1,2,3,4,5]];
playSound3D [_deathsound, _unit, false, getPosASL _unit, 1.5, 1, 150];	