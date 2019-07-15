if (isNull player) exitWith{};

_index = lbCurSel 1500;

_shopPrice = (BUILD_ITEMS select _index) select 0;
_shopName  = (BUILD_ITEMS select _index) select 1;
_shopClass = (BUILD_ITEMS select _index) select 2;
_shopDir   = (BUILD_ITEMS select _index) select 3;
_VecRadius = (BUILD_ITEMS select _index) select 4;

if (!([GROUP_PLAYERS,_shopPrice] call DCW_fnc_afford)) exitWith {hint "Can't buy this item"; };

_obj = _shopClass createVehicle [0,0,0];

closeDialog 0;

sleep .1;

// If it's a container, make sure it's empty
clearItemCargoGlobal _obj;
clearWeaponCargoGlobal _obj;
clearMagazineCargoGlobal _obj;
clearBackpackCargoGlobal _obj;

[_obj, player, [0,_VecRadius + 1.5,0.02], _shopDir] call DCW_fnc_grabObject;