

ENEMY_SKILLS = 1;
DEBUG = false;
RESPAWN_ENABLED = true;
REVIVE_ENABLED = true; //Reviving
RESPAWN_ENABLED =  true; //Respawn when hit
SHOW_SECTOR = true;
NUMBER_RESPAWN = 3;

if (count paramsArray > 0) then 
{
	// Shared parameter
	ENEMY_SKILLS = [0.1, 0.5, 1] select (paramsArray select 0);
	DEBUG = if (paramsArray select 1 == 1) then {true}else{false};
	RESPAWN_ENABLED = if (paramsArray select 2 == 1) then {true}else{false};
	REVIVE_ENABLED = if (paramsArray select 3 == 1) then {true}else{false};

	// Not shared => each client has his own value
	NUMBER_RESPAWN = paramsArray select 4;
};

REMAINING_RESPAWN = NUMBER_RESPAWN;