/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

private ["_unit","_side","_transportHelo","_soldier"];
_transportHelo = _this select 0;
_side = _this select 1;

_interventionGroup = createGroup _side;
_className = SUPPORT_MEDEVAC_CREW_CLASS;// "rhs_vdv_flora_medic";// "rhsusf_socom_marsoc_jtac";

for "_xc" from 0 to 1 do {
	_unit = _interventionGroup createUnit [_className, position _transportHelo, [], 0, "FORM"];
	_unit addMPEventHandler ["MPKilled",{
		 MEDEVAC_State = "aborted"; 
	}];
	[_unit] joinSilent _interventionGroup;
};

{_x moveInCargo _transportHelo; } foreach units _interventionGroup;


_interventionGroup;