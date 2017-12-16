/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


private _points = _this getVariable["DCW_SCORE",0];
private _colorChaser = "";
private _labelChaser = "";

if (CHASER_TRIGGERED) then{
	_colorChaser = "#e46b6b";
	_labelChaser = "Arriving";
} else{
	_colorChaser = "#2f9581";
	_labelChaser = "Standby";
};



("RscStatusBar" call BIS_fnc_rscLayer) cutRsc ["RscStatusBar","PLAIN"];	
	disableSerialization;
	((uiNamespace getVariable "RscStatusBar")displayCtrl 55554) ctrlSetStructuredText
parseText format ["<t shadow='1' shadowColor='#000000' color='#FFFFFF'>Score : %1 points | Reinforcements : <t color='%2'>%3</t></t>",_points,_colorChaser,_labelChaser];