/*
	Author: 
		Bidass

  Version:
    {VERSION}

	Description:
		Base configuration constant definition
		The multiplayer configuration binding is done here

*/


// If debug enabled, each units will be visible on the map with markers
DEBUG = getMissionConfigValue ["DCW_debug",true]; 
AI_SKILLS = getMissionConfigValue ["DCW_AI_skills",.9];
RESPAWN_ENABLED = true;
MEDEVAC_ENABLED = true; // Reviving
SHOW_SECTOR = true;
NUMBER_RESPAWN = 3;
ENABLE_FILTER = true;
TIME_OF_DAYS = 12;
WEATHER = .2;
ENABLE_DIALOG = true;
POPULATION_INTENSITY = 1;
PERCENTAGE_OF_ENEMY_COMPOUND = 4; 
NUMBER_OFFICERS = 3;

// List of vehicle config, everybody needs this part
CONFIG_VEHICLES = [] call DCW_fnc_getConfigVehicles;

//SPAWNING CONFIG
SIZE_BLOCK =  getMissionConfigValue ["DCW_size_block",400]; // Size of blocks
MAX_CLUSTER_SIZE =  getMissionConfigValue ["DCW_max_cluster_size",200];
SPAWN_DISTANCE = getMissionConfigValue ["DCW_spawn_distance",800]; //Distance units in compounds spawned
MIN_SPAWN_DISTANCE =  350; //Units can't spawn before this distance


// SUPPORT CLASSES
SUPPORT_ARTILLERY_CLASS = ["B_MBT_01_arty_F"];
SUPPORT_BOMBING_AIRCRAFT_CLASS = ["B_Plane_CAS_01_dynamicLoadout_F"];
SUPPORT_DROP_AIRCRAFT_CLASS = ["B_Heli_Transport_03_F"];
SUPPORT_TRANSPORT_CHOPPER_CLASS = ["B_Heli_Transport_01_F"];
SUPPORT_MEDEVAC_CHOPPER_CLASS = ["B_Heli_Transport_01_F"];
SUPPORT_CAS_HELI_CLASS = ["B_Heli_Attack_01_dynamicLoadout_F","B_Heli_Light_01_dynamicLoadout_F"];
SUPPORT_MEDEVAC_CREW_CLASS = "rhsusf_socom_marsoc_sarc";
SUPPORT_DRONE_CLASS = "B_UAV_02_dynamicLoadout_F";
SUPPORT_HEAVY_TRANSPORT_CLASS = ["B_Heli_Transport_03_F"];
SUPPORT_CAR_PARADROP_CLASS = ["B_LSV_01_armed_F"];

//FRIENDLIES
FRIENDLY_LIST_UNITS = ["B_Soldier_SL_F","B_soldier_AR_F","B_Soldier_GL_F","B_soldier_M_F","B_soldier_AT_F","B_soldier_AAT_F","B_Soldier_A_F","B_medic_F","B_Soldier_F","B_soldier_LAT_F","B_Soldier_TL_F"];
ALLIED_LIST_UNITS = ["B_Soldier_SL_F","B_soldier_AR_F","B_Soldier_GL_F","B_soldier_M_F","B_soldier_AT_F","B_soldier_AAT_F","B_Soldier_A_F","B_medic_F","B_Soldier_F","B_soldier_LAT_F","B_Soldier_TL_F"]; //Units of your side
ALLIED_LIST_CARS = ["B_APC_Tracked_01_rcws_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_LSV_01_AT_F"]; //Friendly cars
FRIENDLY_LIST_CARS = ["B_APC_Tracked_01_rcws_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_LSV_01_AT_F"]; //Friendly cars
FRIENDLY_FLAG = "Flag_UNO_F"; //Flag of your side
FRIENDLY_CHOPPER_CLASS = ["B_Heli_Transport_01_F", "B_Heli_Transport_03_F"];
FRIENDLY_LIST_TURRETS = [ "B_Mortar_01_F","B_GMG_01_F","B_GMG_01_high_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"];

//CIVILIAN
SIDE_CIV = CIVILIAN; // Side civilian
CIV_LIST_UNITS = ["C_man_p_beggar_F_euro","C_Man_casual_1_F_euro","C_man_p_fugitive_F_euro","C_Man_casual_6_F_euro","C_man_polo_5_F_euro","C_man_polo_4_F_euro","C_Story_Mechanic_01_F","C_man_hunter_1_F","C_Man_Messenger_01_F","C_Man_casual_4_F","C_Man_Fisherman_01_F"];
CIV_LIST_CARS = ["C_Truck_02_transport_F","C_Offroad_01_F","C_Offroad_02_unarmed_F","C_SUV_01_F"];
CIV_LIST_AIRCRAFTS = ["C_Plane_Civil_01_F"];
HUMANITAR_LIST_CARS = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F","C_IDAP_Van_02_medevac_F"];
HUMANITAR_LIST_UNITS = ["C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_UAV_06_medical_F","C_IDAP_Man_EOD_01_F","C_IDAP_Man_AidWorker_03_F"];
MAX_RANDOM_CIVILIAN =  getMissionConfigValue ["DCW_max_random_civilian",4];
MAX_SHEEP_HERD =  getMissionConfigValue ["DCW_max_sheep_herd",2]; //Number of sheep herd
RATIO_POPULATION =  getMissionConfigValue ["DCW_ratio_population",1.3]; //Number of unit per building. 0.4 default
MAX_POPULATION = getMissionConfigValue ["DCW_max_population",25];
RATIO_CARS =  getMissionConfigValue ["DCW_ratio_cars",.06]; //Number of empty cars spawned in a city by buidling
PERCENTAGE_FRIENDLIES = 25; //Percentage friendly spawn in patrol
PERCENTAGE_CIVILIAN = 30; //Percentage civilian in a block
PERCENTAGE_ENEMIES = 70; //Percentage enemies in occupied compound
PERCENTAGE_INSURGENTS = 50; //Percentage of potential insurgents in the civilians. If the civilian are attacked they might join the east or west wether the shot are coming from (And with probabilities rules...)
PERCENTAGE_FRIENDLY_INSURGENTS = 50; //Percentage of potential insurgents joining the west.
PERCENTAGE_SUSPECT = 38;

//ENEMIES
SIDE_ENEMY = EAST; //Enemy side 
PATROL_SIZE = [1,3]; //Size of patrol => [minimum,random additionnals units]
MAX_SPAWNED_UNITS = getMissionConfigValue ["DCW_max_spawned_units",60] ; //Max units to spawn
MAX_CHASERS = 8; //Max hunters who are looking for you !
MAX_RANDOM_PATROL = getMissionConfigValue ["DCW_max_random_patrol",20]; //Number of units patroling around the player at the same time
MAX_RANDOM_CAR = getMissionConfigValue ["DCW_max_random_car",2]; //Max car spawned.
NUMBER_CHOPPERS = getMissionConfigValue ["DCW_number_choppers",0]; // Number of choppers
MAX_NUMBER_AIRCRAFT = getMissionConfigValue ["DCW_max_number_aircrafts",5]; // Number of choppers
NUMBER_CRASHSITES = getMissionConfigValue ["DCW_number_crashsites",2];
NUMBER_TANKS = getMissionConfigValue ["DCW_number_tanks",2]; //Number of tanks
ENEMY_LIST_UNITS = ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_GL_F","O_soldier_M_F","O_Soldier_AT_F","O_Soldier_AAT_F","O_Soldier_A_F","O_medic_F"];
ENEMY_SNIPER_UNITS = ["O_ghillie_ard_F"];
ENEMY_LIST_CARS = ["O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_LSV_02_armed_F","O_LSV_02_AT_F","O_Truck_03_ammo_F","O_Truck_03_transport_F","O_Truck_02_covered_F"];
ENEMY_CHOPPERS = ["O_Heli_Attack_02_dynamicLoadout_F"];
ENEMY_ATTACHEDLIGHT_CLASS = "acc_flashlight"; // "rhs_acc_2dpZenit"; 
ENEMY_MORTAR_CLASS = "O_Mortar_01_F"; //Mortar class
ENEMY_LIST_TANKS = ["O_MBT_04_cannon_F","O_MBT_02_cannon_F"]; //Tanks
ENEMY_COMMANDER_CLASS = "O_Soldier_SL_F"; //commander
ENEMY_CONVOY_CAR_CLASS = "O_MRAP_02_hmg_F"; //commander
ENEMY_CONVOY_TRUCK_CLASS = ["O_Truck_03_transport_F"]; //commander
ENEMY_OFFICER_LIST_CARS = ["O_APC_Wheeled_02_rcws_v2_F"];  //car list used by officer

// List of items 
BUILD_ITEMS = [
  [2,  "TyreBarrier_01_black_F", 0, 1.5,nil],
  [2,  "Land_BagFence_Short_F",  0, 1.5,nil],
  [4, "Land_BagFence_Long_F",   0, 1.5,nil],
  [2,  "Land_BagFence_Corner_F", 0, 1.5,nil],
  [4, "Land_BagFence_Round_F",  0, 1.5,nil],
  [14, "Land_SandbagBarricade_01_half_F", 0, 1.5,nil],
  [16, "Land_SandbagBarricade_01_hole_F", 0, 1.5,nil],
  [4,  "Land_HBarrier_1_F",    0, 2,nil],
  [12,  "Land_HBarrier_3_F",    0, 2,nil],
  [20, "Land_HBarrierWall4_F",   0, 4,nil],
  [100,  "Land_HBarrierTower_F",    0, 3,nil],
  [5,  "Land_Mil_WallBig_4m_F",  0, 2,nil],
  [30,  "CamoNet_BLUFOR_F", 0, 1.5,nil],
  [2,  "Land_CampingChair_V2_F", 0 , 1.5, { params["_obj"]; _obj call DCW_fnc_addActionSitOnChair;}],
  [2,  "Land_CampingTable_small_F", 0 , 1.5,nil],
  [2, "Land_PortableLight_double_F",   180, 1,nil],
  [2, "Land_Barricade_01_4m_F", 0, 1.5,nil],
  [5, "Land_DomeDebris_01_hex_green_F",  180, 1.5,nil],
  [5,  "Land_CncShelter_F",    0, 1,nil],
  [5,  "Land_GH_Platform_F",   0, 3.5,nil],
  [10,  "Land_CncBarrierMedium4_F", 0, 3,nil],
  [10,  "Land_PierLadder_F",    0, 1,nil],
  [150, "Box_NATO_Support_F",   0, 1,{ params["_obj"]; _obj call DCW_fnc_spawnCrate; }],
  [75, "Land_BagBunker_Small_F", 180, 3,nil],
  [75, "Land_Cargo_Patrol_V3_F",  0, 3.5,nil],
  [2,"Campfire_burning_F", 0 , 1,nil],
  [5,"Land_TentDome_F",0, 2,{ params["_obj"]; _obj remoteExec ["DCW_fnc_actionRest",0]; }]
];

RESTRICTED_AMMOBOX = true;
publicVariable "RESTRICTED_AMMOBOX";

if (count paramsArray > 0 && isMultiplayer && !DEBUG) then 
{
	// Shared parameter
	AI_SKILLS = [0.1, 0.5, 1] select (paramsArray select 0);
	DEBUG = if (paramsArray select 1 == 1) then {true}else{false};
	RESPAWN_ENABLED = if (paramsArray select 2 == 1) then {true}else{false};
	MEDEVAC_ENABLED = if (paramsArray select 3 == 1) then {true}else{false};

	// Not shared => each client has his own value
	NUMBER_RESPAWN = paramsArray select 4;
};

REMAINING_RESPAWN = NUMBER_RESPAWN;