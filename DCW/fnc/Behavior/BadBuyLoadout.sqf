/*
  Author: 
    Bidass

  Description:
    Transform a civil in an insurgent with an AK, magazines...
    The unit's gear is randomized

  Parameters:
    0: OBJECT - unit
    0: OBJECT - unit's side

  Returns:
    OBJECT - unit 
*/
params ["_unit","_side"];

[_unit] joinSilent grpNull;
[_unit] joinSilent (createGroup _side);
[_unit,""] remoteExec ["switchMove"];

private _marker = _unit getVariable["marker",""];

if (_side == SIDE_ENEMY) then {
  _unit stop true;
  [_unit, "TakeFlag"] remoteExec ["playActionNow"];
  sleep 1;
};

_unit removeAllEventHandlers "HandleDamage";
_unit removeAllEventHandlers "FiredNear";

// Random weapon loadout
switch (floor(random 3)) do
{
        case 0:
        {       
                _unit addVest "V_BandollierB_khk";
                _unit addMagazines ["30Rnd_545x39_Mag_F", 5];
                _unit addWeapon "arifle_AKS_F"; 
                _unit addMagazine "HandGrenade";
        };
        case 1:
        {
                _unit addVest "V_Chestrig_oli";
                _unit addMagazines ["30Rnd_762x39_Mag_F", 5];
                _unit addWeapon "arifle_AKM_F";
                _unit addMagazine "HandGrenade";
        };
        case 2:
        {
                _unit addMagazines ["30Rnd_762x39_Mag_F", 5];
                _unit addWeapon "arifle_AKM_FL_F";
        };
        case 3:
        {
                _unit addVest "V_BandollierB_oli";
                _unit addMagazines ["30Rnd_762x39_Mag_F", 5];
                _unit addWeapon "arifle_AKM_F";
        };
};
_unit addItem "FirstAidkit";

_unit setskill ["Endurance",1];
_unit setskill ["aimingSpeed",1];
_unit setskill ["aimingAccuracy",1];
_unit setskill ["Endurance",1];
_unit setskill ["general",1];

_unit stop false;

if (_side == SIDE_ENEMY)then{  
  _unit remoteExec ["RemoveAllActions",0];        
  _marker setMarkerColor "ColorRed";
  _unit setVariable["DCW_Type","enemy"];
  sleep 4;
  [_unit, "MountOptic"] remoteExec ["playActionNow"];
  sleep 3;
  _unit SetBehaviour "COMBAT";
}else{
  _marker setMarkerColor "ColorGreen";
  _unit setVariable["DCW_Type","civ"];
};

_unit allowFleeing .1;  

_unit;