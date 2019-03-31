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

["AmmoboxInit",[_box,true]] call BIS_fnc_arsenal;
if (RESTRICTED_AMMOBOX) then {

	[_box,[true],true] call BIS_fnc_removeVirtualItemCargo;
	[_box,[true],true] call BIS_fnc_removeVirtualWeaponCargo;
	[_box,[true],true] call BIS_fnc_removeVirtualBackpackCargo;
	[_box,[true],true] call BIS_fnc_removeVirtualMagazineCargo;

	_items = [] call fnc_getcrateitems;
	[_box, _items, true] call BIS_fnc_addVirtualItemCargo;
	[_box, _items, true] call BIS_fnc_addVirtualWeaponCargo; 
	[_box, _items, true] call BIS_fnc_addVirtualMagazineCargo; 
	[_box, _items, true] call BIS_fnc_addVirtualBackpackCargo;
};
