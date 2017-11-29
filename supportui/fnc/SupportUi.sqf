/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

_unit = _this;
_points = _this getVariable["IH_SCORE",0];

private["_ok","_ctrlList"];
_ok = createDialog "ICE_DIALOG";
disableSerialization;
_ctrlList = findDisplay 5000 displayCtrl 12345; 
_ctrlList ctrlSetStructuredText parseText format["<t shadow='1' shadowColor='#000000' color='#ccc'>Score : %1 points</t>",_points];
