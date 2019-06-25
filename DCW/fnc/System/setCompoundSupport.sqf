params["_marker","_addedPoints","_timeInSeconds"];
_markerID = _marker select 0;
_markerData = [_markerID] call fnc_getMarkerById;
_marker = _markerData select 0;
_markerIndex = _markerData select 1;

_support = _marker select 13;
_support =  (100 min (0 max (_support + _addedPoints)));
_marker set [13, _support]; 

waitUntil {!IN_MARKERS_LOOP; sleep .5;};
MARKERS set [_markerIndex,_marker];

// _timeToSleep = floor(abs(_timeInSeconds/_addedPoints));
// _support = _marker select 13;

// _cursor = if (_addedPoints < 0) then {-1}else{1};


/*
while { abs _addedPoints > 0 } do {
	_support = (100 min (0 max (_support + _cursor)));
	_addedPoints = _addedPoints - _cursor;
	_marker = MARKERS select _markerIndex;
	_marker set [13, _support];


	sleep _timeToSleep;
};*/

_marker;