params["_object"];

_object addAction [
	'<t color="#ffffff">Sell</t>',
	{[_this select 0, _this select 1] call DCW_fnc_sellObject;}
	,nil,2.5,false,true,"","true",20,false,""];

_object addAction [
	'<t color="#ffffff">Grab</t>',
	{
		[_this select 0, _this select 1] call DCW_fnc_grabObject;
	},nil,2.5,false,true,"","true",20,false,""];
