/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Headless client
*/

// Send unit to Headless client
DCW_fnc_sendToHC = {
	_grp = _this;
	if (!isDedicated) exitWith {2};
  if (count HCs == 0) ExitWith{2};
  _sortedHCs = [HCs, [], {(_x call DCW_fnc_countUnitInHC)}, "ASCEND"] call BIS_fnc_sortBy;
  _hc = (_sortedHCs select 0);
	_grp setGroupOwner (owner _hc);
  diag_log format["[HC] group %1 transmitted to %2", str _grp,str _hc];
  (owner _hc);
};

DCW_fnc_countUnitInHC = {
  ({groupOwner _x == owner _this} count allGroups);
};


// Create the HCS
HCs = [];

if (!isDedicated) exitWith{};

// Refresh the HC state
while {true} do {

  for "_i" from 1 to 4 do{ 
    if !(isNil format["HC%1",str _i]) then {
      _hc = (missionNamespace getVariable format["HC%1",str _i]);
      if (HCs find _hc == -1) then {
        HCs pushBackUnique _hc;
        diag_log format["[HC] Connected : %1",str _hc];
      };
    };
  };

  publicVariableServer "HCs";

  // Check the current HCs
  if (count HCs > 0) then {
    for "_i" from 0 to (count HCs - 1) do{ 
      _hc = HCS select _i;
      if (isNull _hc) then {
        diag_log "[HC] Disconnected";
        HCs = HCs - [_hc];
        publicVariableServer "HCs";
      } else {
        diag_log format ["[HC] %1 AI groups currently on %2", _hc call DCW_fnc_countUnitInHC, str _hc]; 
      };
    };
  };

  sleep 30;
};