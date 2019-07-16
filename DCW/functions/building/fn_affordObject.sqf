if (isNull player) exitWith{};

_index = lbCurSel 1500;

_shopPrice = (BUILD_ITEMS select _index) select 0;
_shopClass = (BUILD_ITEMS select _index) select 1;
_shopDir   = (BUILD_ITEMS select _index) select 2;
_vecRadius = (BUILD_ITEMS select _index) select 3;
_initField = (BUILD_ITEMS select _index) select 4;

if (!([GROUP_PLAYERS,_shopPrice] call DCW_fnc_afford)) exitWith {hint "Can't buy this item"; };

_obj = _shopClass createVehicle [0,0,0];

closeDialog 0;

sleep .1;

if (!isNil '_initField') then{
	_obj setVariable["DCW_initField",_initField,true];
};
_obj setVariable["DCW_price",_shopPrice,true];
[_obj, player, [0,_vecRadius + 1.5,0.02], _shopDir] call DCW_fnc_grabObject; 