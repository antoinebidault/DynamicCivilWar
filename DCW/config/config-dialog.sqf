disableSerialization;


// List of vehicle config
CONFIG_VEHICLES = [] call fnc_GetConfigVehicles;

titleCut ["", "BLACK FADED", 999];

_anims = ["Acts_millerCamp_A","Acts_ShieldFromSun_loop","Acts_millerCamp_C","Acts_AidlPercMstpSloWWrflDnon_warmup_7_loop","Acts_AidlPercMstpSloWWrflDnon_warmup_8_loop","Acts_AidlPercMstpSloWWrflDnon_warmup_6_loop","acts_millerIdle","Acts_Briefing_SA_Loop","Acts_Briefing_SB_Loop"];
UNIT_SHOWCASE = player; 
{
	if (!isPlayer _x) then {
		[_x,"MOVE"] remoteExec ["disableAI", 2] ;
		[_x,"FSM"] remoteExec ["disableAI", 2] ;
	};
	_anim = _anims select 0;
	_anims = _anims - [_anim];
    [_x,_anim] remoteExec ["switchMove", 0];
	_x setDir (direction player);
}
foreach units group player;


titleCut ["", "BLACK IN", 7];
[] call fnc_initCamera;

_ok = createDialog "PARAMETERS_DIALOG"; 
_display = findDisplay 5001;
_noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

//Time
private _ctrlListTime = _display displayCtrl 2100;
_ctrlListTime lbAdd "Night";
_ctrlListTime lbSetValue  [0,23];
_ctrlListTime lbAdd  "Early morning";
_ctrlListTime lbSetValue  [1,7];
_ctrlListTime lbAdd  "Afternoon";
_ctrlListTime lbSetValue  [2,12];
_ctrlListTime lbAdd "Evening";
_ctrlListTime lbSetValue  [3,19];
_ctrlListTime lbSetCurSel  2;


//Weather
private _ctrlListWeather = _display displayCtrl 2101;
_ctrlListWeather lbAdd "Beautiful";
_ctrlListWeather lbSetValue  [0,0];
_ctrlListWeather lbAdd "Clouds";
_ctrlListWeather lbSetValue  [1,25];
_ctrlListWeather lbAdd  "Average";
_ctrlListWeather lbSetValue  [2,50];
_ctrlListWeather lbAdd "Storm";
_ctrlListWeather lbSetValue  [3,70];
_ctrlListWeather lbAdd "Rain";
_ctrlListWeather lbSetValue  [4,100];
_ctrlListWeather lbSetCurSel  1;

//Population
private _ctrlListPopulation = _display displayCtrl 2102;
_ctrlListPopulation lbAdd "High (25%)";
_ctrlListPopulation lbSetValue  [0,25];
_ctrlListPopulation lbAdd  "Standard (5%)";
_ctrlListPopulation lbSetValue  [1,5];
_ctrlListPopulation lbAdd "Low (3%)";
_ctrlListPopulation lbSetValue  [2,3];
_ctrlListPopulation lbSetCurSel  1;


//Weather
private _ctrlListResp = _display displayCtrl 2112;
_ctrlListResp lbAdd "None";
_ctrlListResp lbSetValue  [0,0];
_ctrlListResp lbAdd  "4";
_ctrlListResp lbSetValue  [1,4];
_ctrlListResp lbAdd "10";
_ctrlListResp lbSetValue  [2,10];
_ctrlListResp lbAdd "40";
_ctrlListResp lbSetValue  [3,40];
_ctrlListResp lbAdd "Infinite";
_ctrlListResp lbSetValue  [4,-1];
_ctrlListResp lbSetCurSel  1;

//Data
private _ctrlReviveOn = _display displayCtrl 2104;
_ctrlReviveOn cbSetChecked true;

//Respawn
private _ctrlRespawnOn = _display displayCtrl 2105;
_ctrlRespawnOn cbSetChecked true;

//Respawn
private _ctrlAmmoOn = _display displayCtrl 2106;
_ctrlAmmoOn cbSetChecked true;

[SIDE_FRIENDLY,2111,[2103,2113]] call fnc_rendersideselect;

[SIDE_ENEMY,2107,[2108]] call fnc_rendersideselect;

[SIDE_ENEMY,2108] call fnc_renderfactionselect ;

_factionSelect = [SIDE_FRIENDLY,2103] call fnc_renderfactionselect ;
_factionSelect ctrlAddEventHandler ["LBSelChanged","[ctrlIDC(_this select 0),_this select 1] spawn fnc_SwitchFaction"];

_factionSelectFr = [SIDE_FRIENDLY,2113] call fnc_renderfactionselect;
_factionSelectFr lbSetCurSel 1; // Select FIA by default

[SIDE_CIV,2110] call fnc_renderfactionselect ;

[] call fnc_DisplayChopper;