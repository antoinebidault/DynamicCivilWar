

ENEMY_SKILLS = 1;
DEBUG = false;
RESPAWN_ENABLED = true;
MEDEVAC_ENABLED = true; //Reviving
SHOW_SECTOR = true;
NUMBER_RESPAWN = 3;
ENABLE_FILTER = true;
TIME_OF_DAYS = 12;
WEATHER = .2;
ENABLE_DIALOG = true;
POPULATION_INTENSITY = 1;
RESTRICTED_AMMOBOX = true;
publicVariable "RESTRICTED_AMMOBOX";

if (count paramsArray > 0 && isMultiplayer && !DEBUG) then 
{
	// Shared parameter
	ENEMY_SKILLS = [0.1, 0.5, 1] select (paramsArray select 0);
	DEBUG = if (paramsArray select 1 == 1) then {true}else{false};
	RESPAWN_ENABLED = if (paramsArray select 2 == 1) then {true}else{false};
	MEDEVAC_ENABLED = if (paramsArray select 3 == 1) then {true}else{false};

	// Not shared => each client has his own value
	NUMBER_RESPAWN = paramsArray select 4;
};

REMAINING_RESPAWN = NUMBER_RESPAWN;