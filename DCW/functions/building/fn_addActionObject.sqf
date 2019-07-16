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

_object addAction [
	'<t color="#ffffff">Rotate</t>',
	{
		(_this select 0) enableSimulation false;
		(_this select 0) setDir (getDir(_this select 0) + 5);
	},nil,1,false,false,"","true",20,false,""];

_object addAction [
	'<t color="#ffffff">Raise</t>',
	{
		(_this select 0) enableSimulation false;
		_pos = getPos(_this select 0);
		_pos set [2,((_pos select 2) + 0.2)];
		(_this select 0) setPosATL _pos;
	},nil,1,false,false,"","true",20,false,""];
	
_object addAction [
	'<t color="#ffffff">Lower</t>',
	{
		(_this select 0) enableSimulation false;
		_pos = getPos(_this select 0);
		_pos set [2,((_pos select 2) - 0.2)];
		(_this select 0) setPos _pos;
	},nil,1,false,false,"","true",20,false,""];


