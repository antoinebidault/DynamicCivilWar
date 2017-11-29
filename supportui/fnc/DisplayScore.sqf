/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */


_points = _this getVariable["IH_SCORE",0];

("RscStatusBar" call BIS_fnc_rscLayer) cutRsc ["RscStatusBar","PLAIN"];	
	disableSerialization;
	((uiNamespace getVariable "RscStatusBar")displayCtrl 55554) ctrlSetStructuredText
parseText format ["<t shadow='1' shadowColor='#000000' color='#ccc'>Score : %1 points</t>",_points];