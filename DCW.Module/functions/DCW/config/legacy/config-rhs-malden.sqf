
//Global configuration
//GLOBAL
DEBUG = false; //Make all units visible on the map
SHOW_SECTOR = true; //Make every sector colored on the map
SIDE_FRIENDLY = side player; //Side player
NUMBER_RESPAWN = 3;
CIVIL_REPUTATION = 50;
"B_RangeMaster_F" createUnit [[-1000,-1000], createGroup SIDE_FRIENDLY, "this allowDamage false; HQ = this; ", 0.6, "colonel"];
[]spawn{
	sleep 1;
	HQ setName "HQ";
};

//SPAWNING CONFIG
SPAWN_DISTANCE = 750; //Distance uniuts are spawned
MIN_SPAWN_DISTANCE =  550; //Units can't spawn before this distance

//FRIENDLIES
ALLIED_LIST_UNITS = [player,"Man"] call DCW_fnc_FactionClasses; //Units of your side
ALLIED_LIST_CARS = ["rhs_tigr_sts_3camo_vmf"]; //Friendly cars
FRIENDLY_FLAG = "rhs_Flag_Russia_F";//Flag of your side
SUPPORT_DRONE_CLASS="rhs_pchela1t_vvsc";

//CIVILIAN
SIDE_CIV = CIVILIAN; // Side civilian
CIV_LIST_UNITS = ["C_man_p_beggar_F_euro","C_Man_casual_1_F_euro","C_man_p_fugitive_F_euro","C_Man_casual_6_F_euro","C_man_polo_5_F_euro","C_man_polo_4_F_euro","C_Story_Mechanic_01_F","C_man_hunter_1_F","C_Man_Messenger_01_F","C_Man_casual_4_F","C_Man_Fisherman_01_F"];
CIV_LIST_CARS = ["RHS_Ural_Open_Civ_01","C_Truck_02_transport_F","C_Offroad_01_F","C_Offroad_02_unarmed_F","C_SUV_01_F"];
HUMANITAR_LIST_CARS = ["LOP_UN_Ural","LOP_UN_Offroad","LOP_UN_UAZ"];
HUMANITAR_LIST_UNITS = ["C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_UAV_06_medical_F","C_IDAP_Man_EOD_01_F","C_IDAP_Man_AidWorker_03_F"];
MAX_RANDOM_CIVILIAN = POPULATION_INTENSITY * 14;
MAX_SHEEP_HERD = 2; //Number of sheep herd
RATIO_POPULATION = POPULATION_INTENSITY * .5; //Number of unit per building. 0.4 default
RATIO_CARS = POPULATION_INTENSITY * .1; //Number of empty cars spawned in a city by buidling
PERCENTAGE_FRIENDLIES = 50; //Percentage friendly spawn in patrol
PERCENTAGE_CIVILIAN = 60; //Percentage civilian in a block
PERCENTAGE_ENEMIES = 40; //Percentage enemies
PERCENTAGE_INSURGENTS = 50; //Percentage of potential insurgents in the civilians. If the civilian are attacked they might join the east or west wether the shot are coming from (And with probabilities rules...)
PERCENTAGE_FRIENDLY_INSURGENTS = 50; //Percentage of potential insurgents joining the west.
PERCENTAGE_SUSPECT = ((PERCENTAGE_INSURGENTS * PERCENTAGE_FRIENDLY_INSURGENTS)/100);

//ENEMIES
SIDE_ENEMY = RESISTANCE; //Enemy side 
AI_SKILLS = 1; //Skills units
PATROL_SIZE = [2,2]; //Size of patrol => [minimum,random additionnals units]
MAX_SPAWNED_UNITS = 65; //Max units to spawn
MAX_CHASERS = POPULATION_INTENSITY*12; //Max hunters who are looking for you !
MAX_RANDOM_PATROL = 10; //Number of units patroling around the player at the same time
MAX_RANDOM_CAR = 2; //Max car spawned.
NUMBER_CHOPPERS = 0; // Number of choppers
ENEMY_LIST_UNITS = ["rhsgref_ins_g_medic","rhsgref_ins_g_spotter","rhsgref_cdf_ngd_squadleader","rhsgref_nat_specialist_aa","rhsgref_nat_grenadier_rpg","rhsgref_nat_commander","rhsgref_nat_hunter","rhsgref_nat_machinegunner","rhsgref_nat_medic","rhsgref_nat_militiaman_kar98k","rhsgref_nat_rifleman_akms","rhsgref_nat_rifleman_aks74","rhsgref_nat_grenadier","rhsgref_nat_rifleman","rhsgref_nat_rifleman_m92","rhsgref_nat_saboteur","rhsgref_nat_scout","rhsgref_nat_pmil_saboteur","rhsgref_nat_pmil_rifleman_m92","rhsgref_nat_pmil_rifleman","rhsgref_nat_pmil_grenadier","rhsgref_nat_pmil_rifleman_aksu","rhsgref_nat_pmil_medic","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_hunter","rhsgref_nat_pmil_commander","rhsgref_nat_pmil_grenadier_rpg","rhsgref_nat_pmil_specialist_aa","rhsgref_nat_pmil_scout"];
ENEMY_SNIPER_UNITS = ["rhsgref_ins_g_sniper","rhsgref_cdf_para_marksman"];
ENEMY_LIST_CARS = ["rhsgref_nat_btr70","rhsgref_nat_uaz_dshkm","rhsgref_BRDM2","rhsgref_nat_uaz_open","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_spg9"];
ENEMY_CHOPPERS = ["rhsgref_cdf_Mi35","rhsgref_cdf_reg_Mi17Sh"];
ENEMY_ATTACHEDLIGHT_CLASS =  "rhs_acc_2dpZenit"; //default : "acc_flashlight"
ENEMY_MORTAR_CLASS = "rhsgref_nat_2b14"; //Mortar class
NUMBER_TANKS = 0; //Number of tanks
ENEMY_LIST_TANKS = ["rhsgref_ins_g_t72ba","rhsgref_ins_g_bmp2e","rhsgref_ins_g_crew","rhsgref_ins_g_crew"]; //Tanks
ENEMY_COMMANDER_CLASS = "rhsgref_nat_warlord"; //commander
ENEMY_CONVOY_CAR_CLASS = "rhsgref_nat_uaz_dshkm"; //commander
ENEMY_CONVOY_TRUCK_CLASS = "rhsgref_nat_ural"; //commander
ENEMY_OFFICER_LIST_CARS = ["rhsgref_nat_btr70","rhsgref_BRDM2"];  //car list used by officer