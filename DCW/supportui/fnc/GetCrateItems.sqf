
if (count GEAR_AND_STUFF == 0) then {
  GEAR_AND_STUFF = [];
  _gearAndStuffArray = [];
  { 
    _items =  getUnitLoadout _x;
    if (count _items > 0) then { 
    { 
      if (typeName _x == "ARRAY" ) then { 
        if (count _x > 0) then { 
          {
            if (typeName _x == "STRING") then {
              if (_x != "") then { _gearAndStuffArray pushBackUnique _x;  };
            } else{
              if (typeName _x == "ARRAY" ) then { 
                  if (count _x > 0) then { 
                    {
                      if (typeName _x == "STRING" ) then {
                        if (_x != "") then { _gearAndStuffArray pushBackUnique _x;  };
                      };
                    }foreach _x;
                  }; 
                };
            };
          } foreach _x;
        }; 
      } else { 
        if (typeName _x == "STRING") then {
          if (_x != "") then { _gearAndStuffArray pushBackUnique _x;  };
        };
      }; 
      } foreach _items; 
    }; 
  } foreach FRIENDLY_LIST_UNITS; //units (group (leader GROUP_PLAYERS)); 


  GEAR_AND_STUFF = _gearAndStuffArray;
};

GEAR_AND_STUFF;