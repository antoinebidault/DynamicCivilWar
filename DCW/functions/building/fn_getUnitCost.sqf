 params["_class"];
 
 _base = getNumber (configFile >> "CfgVehicles" >> _class >> "cost");
if (_base == 0) then {
    120;
};
((round(_base/1500)) max 120);