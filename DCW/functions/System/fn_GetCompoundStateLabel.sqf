/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Get a clean compound state label

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

_name = "Secured";
if (_this == "secured") then{
	_name = "Secured";
}else{
	if (_this == "neutral") then {
		_name = "Neutral settlement";
	}else {
		if (_this == "bastion") then {
			_name = "Enemy bastion";
		}else {
			if (_this == "humanitary") then {
				_name = "Humanitary mission";
			} else {
				if (_this == "massacred") then {
					_name = "Civilian massacred";
				} else {
					if (_this == "resistance") then {
						_name = "Resistance settlement";
					}
				};
			};
		};
	};
};


_name;


