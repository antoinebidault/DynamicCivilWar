
params["_item","_player"];

[GROUP_PLAYERS,ceil(_item getVariable["DCW_price",0]/2)] remoteExec ["DCW_fnc_updatescore",2];
deleteVehicle _item;