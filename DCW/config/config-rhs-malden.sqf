
//Global configuration
//GLOBAL
DEBUG = true; //Make all units visible on the map
SHOW_SECTOR = true; //Make every sector colored on the map
SIDE_CURRENT_PLAYER = side player; //Side player
NUMBER_RESPAWN = 3;
CIVIL_REPUTATION = 50;
HQ = (createGroup (side player)) createUnit ["B_RangeMaster_F", [-1000,-1000], [], 0, "FORM"];
HQ setName  ["Major Andrew Lewis","Andrew","Major Lewis"];

//SPAWNING CONFIG
SIZE_BLOCK = 350; // Size of blocks
MARKER_WHITE_LIST = ["marker_base"]; //Pass list of marker white list name
SPAWN_DISTANCE = 750; //Distance uniuts are spawned
MIN_SPAWN_DISTANCE =  150; //Units can't spawn before this distance

//FRIENDLIES
FRIENDLY_LIST_UNITS = [player,"Man"] call fnc_FactionClasses; //Units of your side
FRIENDLY_LIST_CARS = ["rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_M1220_M153_M2_usarmy_d","rhsusf_M1230_MK19_usarmy_d","rhsusf_M1232_M2_usarmy_d","rhsusf_M1230_MK19_usarmy_d","rhsusf_M1083A1P2_B_M2_D_fmtv_usarmy","rhsusf_m113d_usarmy_M240"]; //Cars US
FRIENDLY_FLAG = "Flag_US_F"; //Flag of your side

//CIVILIAN
CIV_SIDE = CIVILIAN; // Side civilian
CIV_LIST_UNITS = ["C_man_p_beggar_F_euro","C_Man_casual_1_F_euro","C_man_p_fugitive_F_euro","C_Man_casual_6_F_euro","C_man_polo_5_F_euro","C_man_polo_4_F_euro","C_Story_Mechanic_01_F","C_man_hunter_1_F","C_Man_Messenger_01_F","C_Journalist_01_War_F","C_Man_casual_4_F","C_Man_Fisherman_01_F"];
CIV_LIST_CARS = ["RHS_Ural_Open_Civ_01","C_Truck_02_transport_F","C_Offroad_01_F","C_Offroad_02_unarmed_F","C_SUV_01_F"];
HUMANITAR_LIST_CARS = ["LOP_UN_Ural","LOP_UN_Offroad","LOP_UN_UAZ"];
HUMANITAR_LIST_UNITS = ["C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_UAV_06_medical_F","C_IDAP_Man_EOD_01_F","C_IDAP_Man_AidWorker_03_F"];
MAX_RANDOM_CIVILIAN = 7;
MAX_SHEEP_HERD = 2; //Number of sheep herd
RATIO_POPULATION = 1; //Number of unit per building. 0.4 default
RATIO_CARS = .02; //Number of empty cars spawned in a city by buidling
PERCENTAGE_CIVILIAN = 60; //Percentage civilian in a block
PERCENTAGE_ENEMIES = 40; //Percentage enemies
PERCENTAGE_INSURGENTS = 50; //Percentage of potential insurgents in the civilians. If the civilian are attacked they might join the east or west wether the shot are coming from (And with probabilities rules...)
PERCENTAGE_FRIENDLY_INSURGENTS = 50; //Percentage of potential insurgents joining the west.
PERCENTAGE_SUSPECT = ((PERCENTAGE_INSURGENTS * PERCENTAGE_FRIENDLY_INSURGENTS)/1000);

//ENEMIES
ENEMY_SIDE = RESISTANCE; //Enemy side 
ENEMY_SKILLS = 1; //Skills units
PATROL_SIZE = [1,2]; //Size of patrol => [minimum,random additionnals units]
MAX_SPAWNED_UNITS = 65; //Max units to spawn
MAX_CHASERS = 10; //Max hunters who are looking for you !
MAX_RANDOM_PATROL = 17; //Number of units patroling around the player at the same time
MAX_RANDOM_CAR = 2; //Max car spawned.
NUMBER_CHOPPERS = 0; // Number of choppers
ENEMY_LIST_UNITS = ["rhsgref_nat_specialist_aa","rhsgref_nat_grenadier_rpg","rhsgref_nat_commander","rhsgref_nat_crew","rhsgref_nat_hunter","rhsgref_nat_machinegunner","rhsgref_nat_medic","rhsgref_nat_militiaman_kar98k","rhsgref_nat_rifleman_akms","rhsgref_nat_rifleman_aks74","rhsgref_nat_grenadier","rhsgref_nat_rifleman","rhsgref_nat_rifleman_m92","rhsgref_nat_saboteur","rhsgref_nat_scout","rhsgref_nat_pmil_saboteur","rhsgref_nat_pmil_rifleman_m92","rhsgref_nat_pmil_rifleman","rhsgref_nat_pmil_grenadier","rhsgref_nat_pmil_rifleman_aksu","rhsgref_nat_pmil_medic","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_hunter","rhsgref_nat_pmil_commander","rhsgref_nat_pmil_grenadier_rpg","rhsgref_nat_pmil_specialist_aa","rhsgref_nat_pmil_scout","rhsgref_nat_pmil_crew"];
ENEMY_SNIPER_UNITS = ["CUP_O_TK_Sniper"];
ENEMY_LIST_CARS = ["rhsgref_nat_btr70","rhsgref_nat_uaz_dshkm","rhsgref_nat_uaz_open","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_spg9","rhsgref_nat_crew","rhsgref_nat_crew"];
ENEMY_CHOPPERS = ["rhsgref_cdf_Mi35","rhsgref_cdf_reg_Mi17Sh"];
ENEMY_ATTACHEDLIGHT_CLASS =  "rhs_acc_2dpZenit"; //default : "acc_flashlight"
ENEMY_MORTAR_CLASS = "rhsgref_nat_2b14"; //Mortar class
NUMBER_TANKS = 5;
ENEMY_LIST_TANKS = ["rhsgref_ins_g_t72ba","rhsgref_ins_g_bmp2e","rhsgref_ins_g_crew","rhsgref_ins_g_crew"]; //Tanks
ENEMY_COMMANDER_CLASS = "rhsgref_nat_warlord"; //commander
ENEMY_CONVOY_CAR_CLASS = "rhsgref_nat_uaz_dshkm"; //commander
ENEMY_CONVOY_TRUCK_CLASS = "rhsgref_nat_ural"; //commander


