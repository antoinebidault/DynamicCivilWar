/**
/*
  Author: 
    Bidass

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/
_unit = _this;

if (isPlayer _unit)then{
	_unit addAction ["<t color='#00FF00'>Get supports</t>",{
		if (isNil 'SUPPORT_REQUESTER') exitWith{hint "wait the mission has finished to load..."};
		hint "With this user interface, you can order supports with your points ! Interrogating civilian, destroying weapons caches, eliminating patrols will give you extra points."; 
		(_this select 0) call DCW_fnc_supportui;
	},nil,0.5,false,true,"","true",15,false,""];
};