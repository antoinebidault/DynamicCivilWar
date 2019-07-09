/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Set the respawn camp

  Parameters:
    0: OBJECT - unit

  Returns:
    OBJECT - unit 
*/
params["_unit"];

CAMP_OBJS = [];

CAMP_MARKER = createMarker [format["respawn_camp",toLower str SIDE_FRIENDLY], getPos leader GROUP_PLAYERS];
CAMP_MARKER setMarkerText "Camp";
CAMP_MARKER setMarkerShape "ICON";
CAMP_MARKER setMarkerColor "ColorGreen";
CAMP_MARKER setMarkerType "hd_flag";
CAMP_MARKER setMarkerAlpha 0;

_mp = createMarker ["respawn_bl", getPos leader GROUP_PLAYERS];
_mp setMarkerSize [70,70];
_mp setMarkerShape "ELLIPSE";
_mp setMarkerText "Camp";
_mp setMarkerColor "ColorGreen";
_mp setMarkerAlpha 0;

MARKER_WHITE_LIST pushback _mp;
publicVariable "MARKER_WHITE_LIST";
