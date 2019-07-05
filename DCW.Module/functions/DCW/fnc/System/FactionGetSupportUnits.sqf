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

//Adapted from Zonekiller's Array Builder -- Moser 07/18/2014
//http://forums.bistudio.com/showthread.php?109423-Zonekiller-s-Array-Builder
//Determines faction and classname of player, then convert them to strings (strings are easier to work with configs!)



params["_faction","_allowedClass","_type"];


_results = [];

//--------------------------------

//Some config functions
{
	_Vehicle = _x;

	_go = 0;
	{
		if ((configName _Vehicle) isKindOf _x) then {
			
			if (_type == "slingload" ) then {
				if (count (getArray(_Vehicle >> "slingLoadCargoMemoryPoints")) > 0 && getNumber(_Vehicle >> "armor") <= 150 && !((configName _Vehicle) isKindOf "Truck_F")) then {_go = 1;} 
			} else {
				if (count getArray(_Vehicle >> "availableForSupportTypes") > 0 &&  getArray(_Vehicle >> "availableForSupportTypes") find  _type >= 0) then {
					_go = 1;
				};
			};
		
			if (_go == 1) then		
			{
				if (getText(_Vehicle >> "faction") == _faction) then {
					_results = _results + [configName _Vehicle];
				};
			};

			_go = 0;	
		};		

	} foreach _allowedClass;

} foreach CONFIG_VEHICLES;

_results;