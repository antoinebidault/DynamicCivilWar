/**
/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    TODO

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/
_unit = _this;

if (isPlayer _unit)then{
	_unit addAction [format["<t color='#00FF00'>%1</t>",localize "STR_DCW_support_getSupportActionLabel"],{
		if (isNil 'SUPPORT_REQUESTER') exitWith{hint localize "STR_DCW_support_hint1" };
		hint localize "STR_DCW_support_hint2"; 
	  [] call DCW_fnc_displaySupportUiDialog;
	},nil,0.5,false,true,"","true",15,false,""];
};