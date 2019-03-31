
_gearAndStuffArray = [];
{ 
  _items =  getUnitLoadout _x; 
 if (count _items > 0) then { 
 { 
   if (typeName _x == "ARRAY" ) then { 
    if (count _x > 0) then { 
     if ( count _x == 3) then { 
      if (_x select 1 != "") then { 
       _gearAndStuffArray pushBackUnique (_x select 1); 
      }; 
       
      if (_x select 2 != "") then { 
       _gearAndStuffArray pushBackUnique (_x select 2); 
      }; 
      if (_x select 3 != "") then { 
      	_gearAndStuffArray pushBackUnique (_x select 3); 
      }; 
     };
     _gearAndStuffArray pushBackUnique (_x select 0); 
    }; 
   } else { 
    _gearAndStuffArray pushBackUnique _x; 
   }; 
  } foreach _items; 
 }; 
} foreach units (group (leader GROUP_PLAYERS)); 
 
 _gearAndStuffArray;
