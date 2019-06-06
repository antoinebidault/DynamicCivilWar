params["_marker","_state"];

if (!isServer) exitWith { hint "setCompoundState executed on client"};

_markerID = _marker select 0;
_markerData = [_markerID] call fnc_getMarkerById;
_marker = _markerData select 0;
_markerIndex = _markerData select 1;

_marker set [12,_state];

_icon = _markerID + "-icon";

_markerID setMarkerBrush "Solid";

// Set the marker state
if (_state == "secured") then{
		_markerID setMarkerColor "ColorGreen";
		_icon setMarkerColor "ColorGreen";
		_icon setMarkerType "loc_Ruin";
	}else{
		if (_state == "neutral") then {
			_markerID setMarkerColor "ColorWhite";
			_icon setMarkerColor "ColorBlack";
			_icon setMarkerType "loc_tourism";
		}else {
			if (_state == "bastion") then {
				_markerID setMarkerColor "ColorRed";
				_icon setMarkerColor "ColorRed";
				_icon setMarkerType "loc_Ruin";
			}else {
				if (_state == "humanitary") then {
					_markerID setMarkerColor "ColorBlue";
					_icon setMarkerColor "ColorBlue";
					_icon setMarkerType "loc_Hospital";
				} else {
					if (_state == "massacred") then {
						_markerID setMarkerColor "ColorBlack";
						_icon setMarkerColor "ColorBlack";
						_icon setMarkerType "loc_Cross";
					} else {
						if (_state == "supporting") then {
							_markerID setMarkerColor "ColorGreen";
							_markerID setMarkerBrush "FDiagonal";
							_icon setMarkerColor "ColorGreen";
							_icon setMarkerType "loc_tourism";
						}
					};
				};
			};
		};
	};


// Add the respawn position if secured only
if (_state == "secured" ) then{
	_marker set [15, [SIDE_FRIENDLY, getMarkerPos _markerID, _marker select 14] call BIS_fnc_addRespawnPosition];
} else {
	if (!((_marker select 15) isEqualTo [])) then {
		(_marker select 15) remoteExec ["BIS_fnc_RemoveRespawnPosition",0]; 
	};
};


if (_state == "bastion")then{
	_marker select 0 setMarkerColor "ColorRed";
	if (DEBUG) then {HQ sideChat format["%1 is occupied by enemy",_marker select 14];};
} else {
	if (_state == "massacred") then {
		_marker select 0 setMarkerBrush "BDiagonal";
		_marker select 0 setMarkerColor "ColorBlack";
		[_marker] spawn {
			params["_marker"];
			// Let time to officer to leave the area
			sleep 120;
			[getMarkerPos (_marker select 0), _marker select 4, 456, []] call BIS_fnc_destroyCity;
			if (DEBUG) then {HQ sideChat format["Civilian slaughtered in %1",_marker select 14];};
		};
	 	
	} else{
		if (_state == "humanitary") then {
			_marker select 0 setMarkerBrush "BDiagonal";
			_marker select 0 setMarkerColor "ColorGrey",
			if (DEBUG) then {HQ sideChat format["The humanitary will be deployed in %1",_marker select 14];};
		};
	};
};

MARKERS set [_markerIndex,_marker];

[] call fnc_refreshMarkerStats;

_marker;