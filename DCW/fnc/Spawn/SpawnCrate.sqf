/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 *
 * Fill up crate with faction weapons
 */

_box = _this;
clearmagazinecargo _box; 
clearweaponcargo _box;
if (RESTRICTED_AMMOBOX) then {
	_items = [] call DCW_fnc_getCrateItems;
	[_box, _items select 0, false, false] call BIS_fnc_addVirtualWeaponCargo;
	[_box,  _items select 1, false, false] call BIS_fnc_addVirtualMagazineCargo; 
	[_box,  _items select 2, false, false] call BIS_fnc_addVirtualItemCargo;
	[_box,  _items select 3, false, false] call BIS_fnc_addVirtualBackpackCargo;
	[_box,  _items select 4, false] call BIS_fnc_removeVirtualMagazineCargo;
	["AmmoboxInit",[_box,false]] call BIS_fnc_arsenal;
} else {
	["AmmoboxInit",[_box,true]] call BIS_fnc_arsenal;
};