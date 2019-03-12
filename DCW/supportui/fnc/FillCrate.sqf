/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 *
 * Fill up wrate with faction weapons
 */

clearmagazinecargo _this; 
clearweaponcargo _this;

["AmmoboxInit",[_this,false,{true}]] spawn BIS_fnc_arsenal;

[_this, CRATE_ITEMS, false, true] call BIS_fnc_addVirtualItemCargo;
[_this, CRATE_ITEMS, false, true] call BIS_fnc_addVirtualWeaponCargo; 
[_this, CRATE_ITEMS, false, true] call BIS_fnc_addVirtualMagazineCargo; 
[_this, CRATE_ITEMS, false, true] call BIS_fnc_addVirtualBackpackCargo;