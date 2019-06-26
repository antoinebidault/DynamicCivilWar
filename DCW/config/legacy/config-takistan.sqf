
//Global configuration
//GLOBAL
DEBUG = true; //Make all units visible on the map
SHOW_SECTOR = true; //Make every sector colored on the map
SIDE_FRIENDLY = side player; //Side player
NUMBER_RESPAWN = 3;
CIVIL_REPUTATION = 50;
"B_RangeMaster_F" createUnit [[-1000,-1000], createGroup SIDE_FRIENDLY, "this allowDamage false; HQ = this", 0.6, "colonel"];
[]spawn{
	sleep 1;
	HQ setName "HQ";
};

//SPAWNING CONFIG
SPAWN_DISTANCE = 750; //Distance uniuts are spawned
MIN_SPAWN_DISTANCE =  150; //Units can't spawn before this distance

//FRIENDLIES
ALLIED_LIST_UNITS = [player,"Man"] call DCW_fnc_FactionClasses;
ALLIED_LIST_CARS = ["rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_M1220_M153_M2_usarmy_d","rhsusf_M1230_MK19_usarmy_d","rhsusf_M1232_M2_usarmy_d","rhsusf_M1230_MK19_usarmy_d","rhsusf_M1083A1P2_B_M2_D_fmtv_usarmy","rhsusf_m113d_usarmy_M240"];
FRIENDLY_FLAG = "Flag_US_F";
SUPPORT_DRONE_CLASS="rhs_pchela1t_vvsc";

//CIVILIAN
SIDE_CIV = CIVILIAN; // Side civilian
CIV_LIST_UNITS = ["LOP_Tak_Civ_Random","CUP_C_TK_Man_04","CUP_C_TK_Man_04_Jack","CUP_C_TK_Man_04_Waist","CUP_C_TK_Man_07","CUP_C_TK_Man_08_Jack","CUP_C_TK_Man_05_Coat","CUP_C_TK_Man_05_Waist","CUP_C_TK_Man_06_Jack","CUP_C_TK_Man_06_Waist","CUP_C_TK_Man_02","CUP_C_TK_Man_01_Waist","CUP_C_TK_Man_01_Coat","CUP_C_TK_Man_03_Coat","CUP_C_TK_Man_03_Waist"] ;
CIV_LIST_CARS = ["LOP_TAK_Civ_Landrover","LOP_TAK_Civ_Offroad","LOP_TAK_Civ_UAZ","LOP_TAK_Civ_UAZ_Open","LOP_TAK_Civ_Ural","LOP_TAK_Civ_Ural_open","CUP_C_S1203_CIV","CUP_C_Ikarus_TKC","CUP_C_Lada_TK2_CIV","CUP_C_SUV_TK","CUP_C_Volha_Gray_TKCIV","CUP_C_Volha_Limo_TKCIV","CUP_C_V3S_Open_TKC","CUP_C_Volha_Blue_TKCIV"];
HUMANITAR_LIST_CARS = ["LOP_UN_Ural","LOP_UN_Offroad","LOP_UN_UAZ"];
HUMANITAR_LIST_UNITS = ["C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_UAV_06_medical_F","C_IDAP_Man_EOD_01_F","C_IDAP_Man_AidWorker_03_F"];
MAX_RANDOM_CIVILIAN = 7;
MAX_SHEEP_HERD = 3; //Number of sheep herd
RATIO_POPULATION = .7; //Number of unit per building. 0.4 default
RATIO_CARS = .04; //Number of empty cars spawned in a city by buidling
PERCENTAGE_CIVILIAN = 30; //Percentage civilian in a block
PERCENTAGE_FRIENDLIES = 50; //Percentage friendly spawn in patrol
PERCENTAGE_ENEMIES = 70; //Percentage enemies
PERCENTAGE_INSURGENTS = 50; //Percentage of potential insurgents in the civilians. If the civilian are attacked they might join the east or west wether the shot are coming from (And with probabilities rules...)
PERCENTAGE_FRIENDLY_INSURGENTS = 50; //Percentage of potential insurgents joining the west.
PERCENTAGE_SUSPECT = ((PERCENTAGE_INSURGENTS * PERCENTAGE_FRIENDLY_INSURGENTS)/1000);

//ENEMIES
SIDE_ENEMY = EAST; //Enemy side 
AI_SKILLS = 1; //Skills units
PATROL_SIZE = [1,2]; //Size of patrol => [minimum,random additionnals units]
MAX_SPAWNED_UNITS = 60; //Max units to spawn
MAX_CHASERS = 7; //Max hunters who are looking for you !
MAX_RANDOM_PATROL = 10; //Number of units patroling around the player at the same time
MAX_RANDOM_CAR = 2; //Max car spawned.
NUMBER_CHOPPERS = 0; // Number of choppers
ENEMY_LIST_UNITS = ["LOP_AM_OPF_Infantry_SL","LOP_AM_OPF_Infantry_Engineer","LOP_AM_OPF_Infantry_Rifleman_3","LOP_AM_OPF_Infantry_GL","LOP_AM_OPF_Infantry_AT","LOP_AM_OPF_Infantry_Rifleman","LOP_AM_OPF_Infantry_Rifleman_2","LOP_AM_OPF_Infantry_AR","LOP_AM_OPF_Infantry_Marksman","CUP_O_TK_INS_Soldier_GL","CUP_O_TK_INS_Soldier_AR","CUP_O_TK_INS_Soldier","CUP_O_TK_INS_Soldier_Enfield","CUP_O_TK_INS_Soldier_FNFAL"];
ENEMY_SNIPER_UNITS = ["CUP_O_TK_Sniper"];
ENEMY_LIST_CARS = ["LOP_AM_OPF_Landrover_M2","LOP_AM_OPF_Offroad_M2","LOP_AM_OPF_UAZ_DshKM","LOP_AM_OPF_UAZ_SPG","CUP_O_BTR40_MG_TKM","LOP_AM_OPF_BTR60","CUP_O_TT650_TKA","LOP_AM_OPF_Nissan_PKM","CUP_O_TK_INS_Soldier","CUP_O_TK_INS_Soldier","CUP_O_TK_Soldier"];
ENEMY_CHOPPERS = ["CUP_O_UH1H_slick_TKA"];
ENEMY_ATTACHEDLIGHT_CLASS =  "rhs_acc_2dpZenit"; //default : "acc_flashlight"
ENEMY_MORTAR_CLASS = "B_Mortar_01_F"; //Mortar class
NUMBER_TANKS = 5;
ENEMY_LIST_TANKS = ["LOP_TKA_T55","LOP_TKA_T72BA"]; //Tanks
ENEMY_COMMANDER_CLASS = "LOP_TKA_Infantry_Officer"; //commander
ENEMY_CONVOY_CAR_CLASS = "LOP_AM_OPF_Nissan_PKM"; //commander
ENEMY_CONVOY_TRUCK_CLASS = "LOP_TKA_Ural"; //commander
ENEMY_OFFICER_LIST_CARS = ["rhsgref_nat_btr70","rhsgref_BRDM2"];  //car list used by officer

