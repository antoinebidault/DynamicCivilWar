
//Global configuration
//GLOBAL
DEBUG = false; //Make all units visible on the map
SHOW_SECTOR = true; //Make every sector colored on the map
SIDE_CURRENT_PLAYER = side player; //Side player
NUMBER_RESPAWN = 3;
CIVIL_REPUTATION = 50;
"B_RangeMaster_F" createUnit [[-1000,-1000], createGroup SIDE_CURRENT_PLAYER, "this allowDamage false; HQ = this; ", 0.6, "colonel"];
[]spawn{
	sleep 1;
	HQ setName "HQ";
};

//SPAWNING CONFIG
SIZE_BLOCK = 500; // Size of blocks
MAX_CLUSTER_SIZE = 200;
SPAWN_DISTANCE = 650; //Distance uniuts are spawned
MIN_SPAWN_DISTANCE =  350; //Units can't spawn before this distance

// SUPPORT CLASSES
SUPPORT_ARTILLERY_CLASS = "RHS_M119_D";
SUPPORT_BOMBING_AIRCRAFT_CLASS = "RHS_A10";
SUPPORT_DROP_AIRCRAFT_CLASS = "RHS_C130J";
SUPPORT_TRANSPORT_CHOPPER_CLASS = "UK3CB_BAF_Merlin_HC3_18_GPMG_MTP";
SUPPORT_MEDEVAC_CHOPPER_CLASS = "UK3CB_BAF_Merlin_HC3_18_GPMG_MTP";
SUPPORT_MEDEVAC_CREW_CLASS = "UK3CB_BAF_Medic_MTP_RM_H";
SUPPORT_DRONE_CLASS = "B_UAV_02_dynamicLoadout_F";

//FRIENDLIES
FRIENDLY_LIST_UNITS = [player,"Man"] call fnc_FactionClasses; //Units of your side
FRIENDLY_LIST_CARS = ["UK3CB_BAF_LandRover_WMIK_GMG_FFR_Green_A_MTP"]; //Friendly cars
FRIENDLY_FLAG = "Flag_UK_F";//Flag of your side

//CIVILIAN
CIV_SIDE = CIVILIAN; // Side civilian
CIV_LIST_UNITS = ["C_man_p_beggar_F_euro","C_Man_casual_1_F_euro","C_man_p_fugitive_F_euro","C_Man_casual_6_F_euro","C_man_polo_5_F_euro","C_man_polo_4_F_euro","C_Story_Mechanic_01_F","C_man_hunter_1_F","C_Man_Messenger_01_F","C_Man_casual_4_F","C_Man_Fisherman_01_F"];
CIV_LIST_CARS = ["RHS_Ural_Open_Civ_01","C_Truck_02_transport_F","C_Offroad_01_F","C_Offroad_02_unarmed_F","C_SUV_01_F"];
HUMANITAR_LIST_CARS = ["LOP_UN_Ural","LOP_UN_Offroad","LOP_UN_UAZ"];
HUMANITAR_LIST_UNITS = ["C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_UAV_06_medical_F","C_IDAP_Man_EOD_01_F","C_IDAP_Man_AidWorker_03_F"];
MAX_RANDOM_CIVILIAN = 5;
MAX_SHEEP_HERD = 2; //Number of sheep herd
RATIO_POPULATION = .07; //Number of unit per building. 0.4 default
RATIO_CARS = .03;  //Number of empty cars spawned in a city by buidling
PERCENTAGE_CIVILIAN = 30; //Percentage civilian in a block
PERCENTAGE_FRIENDLIES = 30; //Percentage friendly spawn in patrol
PERCENTAGE_ENEMIES = 70; //Percentage enemies
PERCENTAGE_INSURGENTS = 50; //Percentage of potential insurgents in the civilians. If the civilian are attacked they might join the east or west wether the shot are coming from (And with probabilities rules...)
PERCENTAGE_FRIENDLY_INSURGENTS = 50; //Percentage of potential insurgents joining the west.
PERCENTAGE_SUSPECT = ((PERCENTAGE_INSURGENTS * PERCENTAGE_FRIENDLY_INSURGENTS)/100);

//ENEMIES
ENEMY_SIDE = RESISTANCE; //Enemy side 
ENEMY_SKILLS = 1; //Skills units
PATROL_SIZE = [1,4]; //Size of patrol => [minimum,random additionnals units]
MAX_SPAWNED_UNITS = 40; //Max units to spawn
MAX_CHASERS = 12; //Max hunters who are looking for you !
MAX_RANDOM_PATROL = 8; //Number of units patroling around the player at the same time
MAX_RANDOM_CAR = 1; //Max car spawned.
NUMBER_CHOPPERS = 1; // Number of choppers
ENEMY_LIST_UNITS = ["rhsgref_ins_g_medic","rhsgref_ins_g_spotter","rhsgref_cdf_ngd_squadleader","rhsgref_nat_specialist_aa","rhsgref_nat_grenadier_rpg","rhsgref_nat_commander","rhsgref_nat_hunter","rhsgref_nat_machinegunner","rhsgref_nat_medic","rhsgref_nat_militiaman_kar98k","rhsgref_nat_rifleman_akms","rhsgref_nat_rifleman_aks74","rhsgref_nat_grenadier","rhsgref_nat_rifleman","rhsgref_nat_rifleman_m92","rhsgref_nat_saboteur","rhsgref_nat_scout","rhsgref_nat_pmil_saboteur","rhsgref_nat_pmil_rifleman_m92","rhsgref_nat_pmil_rifleman","rhsgref_nat_pmil_grenadier","rhsgref_nat_pmil_rifleman_aksu","rhsgref_nat_pmil_medic","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_hunter","rhsgref_nat_pmil_commander","rhsgref_nat_pmil_grenadier_rpg","rhsgref_nat_pmil_specialist_aa","rhsgref_nat_pmil_scout"];
ENEMY_SNIPER_UNITS = ["rhsgref_ins_g_sniper","rhsgref_cdf_para_marksman"];
ENEMY_LIST_CARS = ["rhsgref_nat_btr70","rhsgref_nat_uaz_dshkm","rhsgref_BRDM2","rhsgref_nat_uaz_open","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_spg9"];
ENEMY_CHOPPERS = ["rhs_uh1h_hidf_gunship"];
ENEMY_ATTACHEDLIGHT_CLASS =  "rhs_acc_2dpZenit"; //default : "acc_flashlight"
ENEMY_MORTAR_CLASS = "rhsgref_nat_2b14"; //Mortar class
NUMBER_TANKS = 5; //Number of tanks
ENEMY_LIST_TANKS = ["rhsgref_ins_g_t72ba","rhsgref_ins_g_bmp2e"]; //Tanks
ENEMY_COMMANDER_CLASS = "rhsgref_nat_warlord"; //commander
ENEMY_CONVOY_CAR_CLASS = "rhsgref_nat_uaz_dshkm"; //commander
ENEMY_CONVOY_TRUCK_CLASS = "rhsgref_nat_ural"; //commander
ENEMY_LEUTNANT_LIST_CARS = ["rhsgref_nat_btr70","rhsgref_BRDM2"];  //car list used by leutnant