/*
  Author: 
    Bidass

  Description:
    Display the dialog for choosing the type of vehicle needed

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