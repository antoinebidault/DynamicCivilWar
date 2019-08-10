/*
  Author: 
    Bidass

  Version:
    0.9.1

  Description:
    Get a clean compound state label

  Parameters:
    0: OBJECT - TODO

  Returns:
    BOOL - true 
*/

_name = localize "STR_DCW_GetCompoundStateLabel_secured";
if (_this == "secured") then{
	_name = localize "STR_DCW_GetCompoundStateLabel_secured";
}else{
	if (_this == "neutral") then {
		_name = localize "STR_DCW_GetCompoundStateLabel_neutral";
	}else {
		if (_this == "bastion") then {
			_name = localize "STR_DCW_GetCompoundStateLabel_eniBastion";
		}else {
			if (_this == "humanitary") then {
				_name = localize "STR_DCW_GetCompoundStateLabel_humanitary";
			} else {
				if (_this == "massacred") then {
					_name = localize "STR_DCW_GetCompoundStateLabel_civilianMassacred";
				} else {
					if (_this == "resistance") then {
						_name = localize "STR_DCW_GetCompoundStateLabel_resistance";
					}
				};
			};
		};
	};
};


_name;




