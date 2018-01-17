

 
private _ok = createDialog "PARAMETERS_DIALOG"; 
disableSerialization;
private _display = findDisplay 5001;

//Time
private _ctrlListTime = _display displayCtrl 2100;
_ctrlListTime lbAdd "Night";
_ctrlListTime lbSetValue  [0,23];
_ctrlListTime lbAdd  "Early morning";
_ctrlListTime lbSetValue  [1,6.5];
_ctrlListTime lbAdd  "Afternoon";
_ctrlListTime lbSetValue  [2,12];
_ctrlListTime lbAdd "Evening";
_ctrlListTime lbSetValue  [3,19];
_ctrlListTime lbSetCurSel  2;


//Weather
private _ctrlListWeather = _display displayCtrl 2101;
_ctrlListWeather lbAdd "Beautiful";
_ctrlListWeather lbSetValue  [0,0];
_ctrlListWeather lbAdd  "Average";
_ctrlListWeather lbSetValue  [1,0.5];
_ctrlListWeather lbAdd "Bad";
_ctrlListWeather lbSetValue  [2,1];
_ctrlListWeather lbSetCurSel  0;