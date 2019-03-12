/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 *
 * Get all different kinds of items
 */
 
 private ["_items","_elt"];

_gearAndStuffArray = [];
{
     _items =  getUnitLoadout _x;
	if (count _items > 0) then {
		{
			if (typeName _x == "ARRAY" ) then {
				if (count _x > 0) then {
					_gearAndStuffArray pushBackUnique (_x select 0);
				};
			} else {
				_gearAndStuffArray pushBackUnique _x;
			};
		} foreach _items;
	};
}
foreach units (group _this);

_gearAndStuffArray;