

//SPAWNING CONFIG
SIZE_BLOCK = 500; // Size of blocks
MAX_CLUSTER_SIZE = 200;
SPAWN_DISTANCE = 650; //Distance uniuts are spawned
MIN_SPAWN_DISTANCE =  350; //Units can't spawn before this distance
RADIO_CHAT_LIST=["rhs_usa_land_rc_1","rhs_usa_land_rc_2","rhs_usa_land_rc_3","rhs_usa_land_rc_4","rhs_usa_land_rc_5","rhs_usa_land_rc_6","rhs_usa_land_rc_7","rhs_usa_land_rc_7"];


// SUPPORT CLASSES
SUPPORT_ARTILLERY_CLASS = ["RHS_M119_D"];
SUPPORT_BOMBING_AIRCRAFT_CLASS = ["RHS_A10"];
SUPPORT_DROP_AIRCRAFT_CLASS = ["RHS_C130J"];
SUPPORT_TRANSPORT_CHOPPER_CLASS = ["RHS_UH60M_d"];
SUPPORT_MEDEVAC_CHOPPER_CLASS = ["RHS_UH60M_d"];
SUPPORT_CAS_HELI_CLASS = ["RHS_AH64D"];
SUPPORT_MEDEVAC_CREW_CLASS = "rhsusf_socom_marsoc_sarc";
SUPPORT_DRONE_CLASS = "B_UAV_02_dynamicLoadout_F";
SUPPORT_HEAVY_TRANSPORT_CLASS = ["RHS_CH_47F"];
SUPPORT_CAR_PARADROP_CLASS = "rhsusf_M1078A1R_SOV_M2_D_fmtv_socom";



//FRIENDLIES
FRIENDLY_LIST_UNITS = ["rhsgref_cdf_un_grenadier_rpg","rhsgref_cdf_un_engineer","rhsgref_cdf_un_machinegunner","rhsgref_cdf_un_medic","rhsgref_cdf_un_officer","rhsgref_cdf_un_rifleman","rhsgref_cdf_un_grenadier","rhsgref_cdf_un_rifleman_lite","rhsgref_cdf_un_squadleader"]; //Units of your side
FRIENDLY_LIST_CARS = ["rhsgref_un_btr70"]; //Friendly cars
FRIENDLY_FLAG = "Flag_UNO_F"; //Flag of your side
FRIENDLY_CHOPPER_CLASS = ["RHS_CH_47F","RHS_UH60M_d","RHS_AH64D"];

//CIVILIAN
SIDE_CIV = CIVILIAN; // Side civilian
CIV_LIST_UNITS = ["C_man_p_beggar_F_euro","C_Man_casual_1_F_euro","C_man_p_fugitive_F_euro","C_Man_casual_6_F_euro","C_man_polo_5_F_euro","C_man_polo_4_F_euro","C_Story_Mechanic_01_F","C_man_hunter_1_F","C_Man_Messenger_01_F","C_Man_casual_4_F","C_Man_Fisherman_01_F"];
CIV_LIST_CARS = ["RHS_Ural_Open_Civ_01","C_Truck_02_transport_F","C_Offroad_01_F","C_Offroad_02_unarmed_F","C_SUV_01_F"];
HUMANITAR_LIST_CARS = ["LOP_UN_Ural","LOP_UN_Offroad","LOP_UN_UAZ"];
HUMANITAR_LIST_UNITS = ["C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_UAV_06_medical_F","C_IDAP_Man_EOD_01_F","C_IDAP_Man_AidWorker_03_F"];
MAX_RANDOM_CIVILIAN = 4;
MAX_SHEEP_HERD = 2; //Number of sheep herd
RATIO_POPULATION =  1.3; //Number of unit per building. 0.4 default
MAX_POPULATION = 18;
RATIO_CARS =  .1; //Number of empty cars spawned in a city by buidling
PERCENTAGE_FRIENDLIES = 25; //Percentage friendly spawn in patrol
PERCENTAGE_CIVILIAN = 40; //Percentage civilian in a block
PERCENTAGE_ENEMIES = 60; //Percentage enemies
PERCENTAGE_INSURGENTS = 50; //Percentage of potential insurgents in the civilians. If the civilian are attacked they might join the east or west wether the shot are coming from (And with probabilities rules...)
PERCENTAGE_FRIENDLY_INSURGENTS = 50; //Percentage of potential insurgents joining the west.
PERCENTAGE_SUSPECT = ((PERCENTAGE_INSURGENTS * PERCENTAGE_FRIENDLY_INSURGENTS)/100);

//ENEMIES
SIDE_ENEMY = EAST; //Enemy side 
PATROL_SIZE = [1,3]; //Size of patrol => [minimum,random additionnals units]
MAX_SPAWNED_UNITS = 60; //Max units to spawn
MAX_CHASERS = 8; //Max hunters who are looking for you !
MAX_RANDOM_PATROL = 11; //Number of units patroling around the player at the same time
MAX_RANDOM_CAR = 2; //Max car spawned.
NUMBER_CHOPPERS = 0; // Number of choppers
NUMBER_CRASHSITES = 2;
ENEMY_LIST_UNITS = ["rhsgref_ins_g_medic","rhsgref_ins_g_spotter","rhsgref_cdf_ngd_squadleader","rhsgref_nat_specialist_aa","rhsgref_nat_grenadier_rpg","rhsgref_nat_commander","rhsgref_nat_hunter","rhsgref_nat_machinegunner","rhsgref_nat_medic","rhsgref_nat_militiaman_kar98k","rhsgref_nat_rifleman_akms","rhsgref_nat_rifleman_aks74","rhsgref_nat_grenadier","rhsgref_nat_rifleman","rhsgref_nat_rifleman_m92","rhsgref_nat_saboteur","rhsgref_nat_scout","rhsgref_nat_pmil_saboteur","rhsgref_nat_pmil_rifleman_m92","rhsgref_nat_pmil_rifleman","rhsgref_nat_pmil_grenadier","rhsgref_nat_pmil_rifleman_aksu","rhsgref_nat_pmil_medic","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_hunter","rhsgref_nat_pmil_commander","rhsgref_nat_pmil_grenadier_rpg","rhsgref_nat_pmil_specialist_aa","rhsgref_nat_pmil_scout"];
ENEMY_SNIPER_UNITS = ["rhsgref_ins_g_sniper","rhsgref_cdf_para_marksman"];
ENEMY_LIST_CARS = ["rhsgref_nat_btr70","rhsgref_nat_uaz_dshkm","rhsgref_BRDM2","rhsgref_nat_uaz_open","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_spg9"];
ENEMY_CHOPPERS = ["rhs_uh1h_hidf_gunship"];
ENEMY_ATTACHEDLIGHT_CLASS = "acc_flashlight"; // "rhs_acc_2dpZenit"; 
ENEMY_MORTAR_CLASS = "rhsgref_nat_2b14"; //Mortar class
NUMBER_TANKS = 4; //Number of tanks
ENEMY_LIST_TANKS = ["rhsgref_ins_g_t72ba","rhsgref_ins_g_bmp2e"]; //Tanks
ENEMY_COMMANDER_CLASS = "rhsgref_nat_warlord"; //commander
ENEMY_CONVOY_CAR_CLASS = "rhsgref_nat_uaz_dshkm"; //commander
ENEMY_CONVOY_TRUCK_CLASS = ["rhsgref_nat_ural"]; //commander
ENEMY_OFFICER_LIST_CARS = ["rhsgref_nat_btr70","rhsgref_BRDM2"];  //car list used by officer