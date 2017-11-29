/*
Add a torch to the unit and force the lights ON
BIDASS
*/
params["_unit"];

_daytime = 0.5 - abs(daytime - 12) / 12;

if (_daytime < 0.5) then {
    _unit unassignItem "NVGoggles";
    _unit removeItem "NVGoggles";
    _unit unlinkItem "NVGoggles_OPFOR"; 
    _unit addPrimaryWeaponItem ENEMY_ATTACHEDLIGHT_CLASS;
    _unit enableGunLights "forceon";
};