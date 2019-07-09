/*
	Author: 
		Bidass

  Version:
    {VERSION}

	Description:
		Add a torch to the unit and force the lights ON

	Parameters:
		0: OBJECT - unit

	Returns:
		BOOL - true 
*/

params["_unit"];

if (dayTime < 8 || dayTime > 20) then {
    _unit unassignItem "NVGoggles";
    _unit removeItem "NVGoggles";
    _unit unlinkItem "NVGoggles_OPFOR"; 
    _unit addPrimaryWeaponItem ENEMY_ATTACHEDLIGHT_CLASS;
    _unit enableGunLights "forceon";
};

_unit