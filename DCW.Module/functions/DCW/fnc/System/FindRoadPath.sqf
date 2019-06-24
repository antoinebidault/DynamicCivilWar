/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Credits goes to Spiderswine
 * https://forums.bohemia.net/forums/topic/216970-navigation-system-featuring-dijkstra-algorithm/
 * Works but not used
 */

// Create Road Map 
_startPos = _this select 0;
_destPos = _this select 1;

_roadMap = [];
_nextRoads = [];		
_finishedRoads = [];

_startRoads = _startPos nearRoads 10;
_firstRoad = _startRoads select 0;
_nextRoads pushBack _firstRoad;
	
_iterationCounter = 0;

while {_iterationCounter < 5000} do
{	
	_nextRoad = _nextRoads deleteAt 0;	
	_connectedRoads = roadsConnectedTo _nextRoad;
	
	{
		_distance = _x distance _nextRoad;
		_roadMap pushBack [_nextRoad, _x, _distance];

		if((_finishedRoads find _x) == -1) then
		{
			_nextRoads pushBack _x;
		};
		
	} foreach _connectedRoads;
	
	_finishedRoads pushBack _nextRoad;	
	_iterationCounter = _iterationCounter +1;
};



// Run the Dijkstra Algorithm
_startRoads = _startPos nearRoads 10;
_startRoad = _startRoads select 0;

// Init Distances
_distanceArray = [];
_workQueue = [];

_distanceArray pushBack [_startRoad, 0, null];

_visitedRoads = [];
_visitedRoads pushBack _startRoad;
_workQueue pushBack [0, _startRoad];

while { count _workQueue > 0} do
{
	_workItem = _workQueue deleteAt 0;
	_actualRoad = _workItem select 1;

	// Get the connected Roads out the RoadMap
	{
		_road = _x select 0;
		_connRoad = _x select 1;
		_connDistance = _x select 2;
		
		if ((_road == _actualRoad) && !(_connRoad in _visitedRoads)) then	// Find Connected Roads, not yet visited
		{
			_visitedRoads pushBack _connRoad;					// Save connected road as visited
			
			// Calculate Distance between the Roads
			_roadDistance = _connDistance;
			
			// Search for Parent in Distance Array and get his Distance
			{
				_parentRoad = _x select 0;
				_parentDistance = _x select 1;
				_parentParent = _x select 2;
				
				if(_parentRoad == _road) then 
				{
					_roadDistance = _roadDistance + _parentDistance;		// Add distance of parent to new distance
				};
				
			} foreach _distanceArray;
			
			// Save new Road in Distance Array
			_distanceArray pushBack [_connRoad, _roadDistance, _road];	// Add connected road to Distance Array
			_workQueue pushBack [_roadDistance, _connRoad];				// Add connected road to queue
		};
	} forEach _roadMap;
	
	if(count _workQueue  > 0) then {_workQueue sort true;};
};



// Now Finding the Shortest Path to Destination
_destinationPath = [];
_destinationLength = 0;

_startNode = _distanceArray select 0;

_nearestDestinationRoad = (_destPos nearRoads 10) select 0;

_selectedNode = [];

// Find DestinationRoad in Array
{
	_nodeRoadx = _x select 0;
	
	if(_nodeRoadx == _nearestDestinationRoad) then
	{
		_selectedNode = _x;
	}
} foreach _distanceArray;

// Get the Distance to Destination
_destinationLength = _selectedNode select 1;

diag_log format ["StartNode: %1, SelectNode: %2, DestinationLength: %3", _startNode, _selectedNode, _destinationLength];

// Get the Path to Destination
while{!(_selectedNode isEqualTo _startNode)} do
{
	_nodeRoad = _selectedNode select 0;			// Select the Road in the Node
	_destinationPath pushBack _nodeRoad;		// Save the Road in the Path
	_nodeParent = _selectedNode select 2;		// Node Parent to find	
	
	// Find Node Parent in Distance Array
	{
		_nodeRoadx = _x select 0;
		
		if(_nodeRoadx == _nodeParent) then
		{
			_selectedNode = _x;
		}
	} foreach _distanceArray;
};

_destinationPath pushBack (_startNode select 0);


// Create Local Markers to navigate to the path
_markers = [];
{
	 _mapMarker = createMarker [format["mkr-convoy-pa-%1",str _foreachIndex] ,getPos _x];
	 _mapMarker setMarkerShape "ICON";
     _mapMarker setMarkerType "mil_dot";
     _mapMarker setMarkerColor "ColorRed";
	 _markers pushBack _marker;
} foreach _destinationPath;

_markers;