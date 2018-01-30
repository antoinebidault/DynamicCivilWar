/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

/*
Add a torch to the unit and force the lights ON
BIDASS
*/
params["_unit"];

if (dayTime < 8 || dayTime > 20) then {
    _unit unassignItem "NVGoggles";
    _unit removeItem "NVGoggles";
    _unit unlinkItem "NVGoggles_OPFOR"; 
    _unit addPrimaryWeaponItem ENEMY_ATTACHEDLIGHT_CLASS;
    _unit enableGunLights "forceon";
};