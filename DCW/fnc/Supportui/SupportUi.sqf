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

private _unit = _this;
private _points = DCW_SCORE;

private["_ok","_ctrlList"];
_ok = createDialog "DCW_DIALOG";
disableSerialization;
/*
_ctrlList = findDisplay 5000 displayCtrl 12345; 
_ctrlList ctrlSetStructuredText parseText format["<t shadow='1' shadowColor='#000000' color='#ccc'>Score : %1 points</t>",_points];
*/