/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Global scope variable
 */

 if (didJIP) exitWith {};

waitUntil {count allPlayers > 0};

// True if the mission is set up and started up.
DCW_STARTED = false;
publicVariable "DCW_STARTED";

// Triggered when the admin is on the loadout panel
DCW_LOADOUT = false;
publicVariable "DCW_LOADOUT";

GROUP_PLAYERS = group (allPlayers select 0); 
publicVariable "GROUP_PLAYERS";

SIDE_FRIENDLY = side(allPlayers select 0); //Side player
publicVariable "SIDE_FRIENDLY";

// True when triggered
CHASER_TRIGGERED = false;
publicVariable "CHASER_TRIGGERED";

// True if the chase is triggered by any friendly player
CHASER_VIEWED = false;
publicVariable "CHASER_VIEWED";

// Score store
DCW_SCORE = 150;
publicVariable "DCW_SCORE";

CHOPPER_INTRO = objNull;
publicVariable "DCW_SCORE";

CAMP_RESPAWN_POSITION = [];
publicVariable "CAMP_RESPAWN_POSITION";

// Respawn position id
CAMP_RESPAWN_POSITION_ID = [];
publicVariable "CAMP_RESPAWN_POSITION_ID";

// List of player's marker
PLAYER_MARKER_LIST = []; 
publicVariable "PLAYER_MARKER_LIST";

// List of ieds object spawned on the map
IEDS = [];
publicVariable "IEDS";

// List of markers to exclude from enemy & civilian path
MARKER_WHITE_LIST = []; 
publicVariable "MARKER_WHITE_LIST";