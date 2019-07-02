/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Main components preloading and initialization
 */ 
if (!isNull player) then {
	titleCut ["", "BLACK FADED",9999];
	disableUserInput true; 
	enableSentences false;
	enableRadio false;
}; 
 
// Reload hud
addMissionEventHandler ["Loaded",{ 
    [] spawn {
		hint "mission loaded";
		sleep 4;
		[] call DCW_fnc_displayscore;
		//[] spawn DCW_fnc_SpawnLoop;
    };
}];

// Need some adjustements
{ 
	[_x,"MOVE"] remoteExec ["disableAI", 2];
	[_x,"FSM"] remoteExec ["disableAI", 2];
 } foreach allUnits; 

enableDynamicSimulationSystem true;
"Group" setDynamicSimulationDistance 600;

// CONFIG
DCW_fnc_FactionClasses = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionClasses.sqf";
DCW_fnc_FactionGetUnits = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionGetUnits.sqf";
DCW_fnc_FactionList = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionList.sqf";
DCW_fnc_FactionGetSupportUnits =  compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionGetSupportUnits.sqf";
DCW_fnc_GetConfigVehicles =  compileFinal preprocessFileLineNumbers "DCW\fnc\System\GetConfigVehicles.sqf";
call(compileFinal preprocessFileLineNumbers  "DCW\config\config-dialog-functions.sqf");
DCW_fnc_Dialog =  compileFinal preprocessFileLineNumbers "DCW\config\config-dialog.sqf";
DCW_fnc_MissionSetup =  compileFinal preprocessFileLineNumbers "DCW\config\MissionSetup.sqf";

// INTRO 
DCW_fnc_CamFollow = compileFinal preprocessFileLineNumbers  "DCW\fnc\cutscene\CamFollow.sqf";
DCW_fnc_CompoundsecuredCutScene = compileFinal preprocessFileLineNumbers  "DCW\fnc\cutscene\CompoundsecuredCutScene.sqf";

// SYSTEM
DCW_fnc_getClusters = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\GetClusters.sqf";
DCW_fnc_isInMarker= compileFinal preprocessFileLineNumbers  "DCW\fnc\System\isinMarker.sqf";
DCW_fnc_findBuildings= compileFinal preprocessFileLineNumbers  "DCW\fnc\System\findBuildings.sqf";
DCW_fnc_addMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\addMarker.sqf";
DCW_fnc_deleteMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\deleteMarker.sqf";
DCW_fnc_findNearestMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\findNearestMarker.sqf";
DCW_fnc_cachePut = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\CachePut.sqf";
DCW_fnc_showIndicator = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\ShowIndicator.sqf"; 
DCW_fnc_talk = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\Talk.sqf";
DCW_fnc_getVisibility = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\GetVisibility.sqf";
DCW_fnc_undercover = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\Undercover.sqf";
DCW_fnc_setCompoundState =  compileFinal preprocessFileLineNumbers  "DCW\fnc\System\setCompoundState.sqf";
DCW_fnc_setCompoundSupport =  compileFinal preprocessFileLineNumbers  "DCW\fnc\System\setCompoundSupport.sqf";
DCW_fnc_surrenderSystem = compile preprocessFileLineNumbers  "DCW\fnc\System\SurrenderSystem.sqf";
DCW_fnc_getMarkerById = compile preprocessFileLineNumbers "DCW\fnc\System\getMarkerById.sqf";
DCW_fnc_refreshMarkerStats = compile preprocessFileLineNumbers "DCW\fnc\System\refreshMarkerStats.sqf";
DCW_fnc_teleport = compile preprocessFileLineNumbers  "DCW\fnc\System\teleport.sqf";
DCW_fnc_AddAction = compile preprocessFileLineNumbers "DCW\fnc\system\AddAction.sqf";
DCW_fnc_RemoveAction = compile preprocessFileLineNumbers "DCW\fnc\system\RemoveAction.sqf";
DCW_fnc_allPlayers = compileFinal preprocessFileLineNumbers  "DCW\fnc\system\allPlayers.sqf";

//SPAWN
DCW_fnc_respawn= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\Respawn.sqf";
DCW_fnc_respawndialog= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\RespawnDialog.sqf";
DCW_fnc_spawnUnits= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnUnits.sqf";
DCW_fnc_spawnAsEnemy = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnAsEnemy.sqf";
DCW_fnc_spawnFriendly = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnFriendly.sqf";
DCW_fnc_spawnchaser = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnchaser.sqf";
DCW_fnc_spawnoutpost = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnoutpost.sqf";
DCW_fnc_spawnMeetingPoint = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMeetingPoint.sqf";
DCW_fnc_spawnCivil =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCivil.sqf";
DCW_fnc_spawnEnemy =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnEnemy.sqf";
DCW_fnc_spawnFriendlyOutpost =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnFriendlyOutpost.sqf";
DCW_fnc_spawnMortar = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMortar.sqf";
DCW_fnc_spawnCars = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCars.sqf";
DCW_fnc_spawnMainObjective = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMainObjective.sqf";
DCW_fnc_spawnSecondaryObjective= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnSecondaryObjective.sqf";
DCW_fnc_spawnConvoy = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnConvoy.sqf";
DCW_fnc_spawnPosition = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnPosition.sqf";
DCW_fnc_spawnCrashSite = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCrashSite.sqf";
DCW_fnc_spawnDefendTask = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnDefendTask.sqf";
DCW_fnc_spawnIED = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnIED.sqf";
DCW_fnc_spawncrate = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnCrate.sqf";
DCW_fnc_SpawnObjects = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnObjects.sqf";
DCW_fnc_spawnhumanitaryoutpost = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnhumanitaryoutpost.sqf";
DCW_fnc_spawnhumanitar = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnhumanitar.sqf";
DCW_fnc_spawnSnipers =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnSnipers.sqf";
DCW_fnc_spawnLoop =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnLoop.sqf";

//PATROL
DCW_fnc_enemyCompoundPatrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\CompoundPatrol.sqf";
DCW_fnc_civilianCompoundPatrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\CivilianCompoundPatrol.sqf";
DCW_fnc_simplePatrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\SimplePatrol.sqf";
DCW_fnc_largePatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\LargePatrol.sqf";
DCW_fnc_chase = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\chase.sqf";
DCW_fnc_carPatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\carPatrol.sqf";
DCW_fnc_officerPatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\officerPatrol.sqf";
DCW_fnc_civilianPatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\civilianPatrol.sqf";
DCW_fnc_gotomeeting =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\gotomeeting.sqf";
DCW_fnc_chopperpatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\ChopperPatrol.sqf";
DCW_fnc_humanitarPatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\HumanitarPatrol.sqf";
DCW_fnc_patrolDistributeToHC = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\patrolDistributeToHC.sqf";

//OBJECTIVES
DCW_fnc_getIntel = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\GetIntel.sqf";
DCW_fnc_cache = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\cache.sqf";
DCW_fnc_hostage = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\hostage.sqf";
DCW_fnc_Success = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\Success.sqf";
DCW_fnc_failed = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\Failed.sqf";
DCW_fnc_createtask =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\createtask.sqf";
DCW_fnc_foundCommander =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\foundCommander.sqf";
DCW_fnc_mainObjectiveIntel =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\MainObjectiveIntel.sqf";
DCW_fnc_CompoundSecured =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\CompoundSecured.sqf";

//CUSTOM BEHAVIOR
DCW_fnc_mortarBombing = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\MortarBombing.sqf";
DCW_fnc_addtorch = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\addtorch.sqf";
DCW_fnc_randomAnimation = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\randomAnimation.sqf";
DCW_fnc_updateRep =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\UpdateRep.sqf";
DCW_fnc_localChief = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\LocalChief.sqf";
DCW_fnc_medic = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\Medic.sqf";
call(compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\PrepareAction.sqf");
DCW_fnc_addCivilianAction = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\addCivilianAction.sqf";
DCW_fnc_shout = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\Shout.sqf";
DCW_fnc_badBuyLoadout = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\BadBuyLoadout.sqf";
DCW_fnc_camp =  compileFinal preprocessFileLineNumbers "DCW\fnc\Behavior\Camp.sqf";
DCW_fnc_actionCamp =  compileFinal preprocessFileLineNumbers "DCW\fnc\Behavior\ActionCamp.sqf";
DCW_fnc_surrender =  compileFinal preprocessFileLineNumbers "DCW\fnc\Behavior\Surrender.sqf";

//HANDLERS
DCW_fnc_handleFiredNear = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleFiredNear.sqf";
DCW_fnc_handleDamaged = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleDamaged.sqf";
DCW_fnc_handlekill = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleKill.sqf";
DCW_fnc_handleAttacked = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleAttacked.sqf";

// Support UI
DCW_fnc_addSupportUi = compile preprocessFileLineNumbers  "DCW\fnc\supportui\addSupportUi.sqf";
DCW_fnc_updatescore = compile preprocessFileLineNumbers  "DCW\fnc\supportui\UpdateScore.sqf";
DCW_fnc_afford = compile preprocessFileLineNumbers  "DCW\fnc\supportui\Afford.sqf";
DCW_fnc_supportui = compile preprocessFileLineNumbers  "DCW\fnc\supportui\SupportUI.sqf";
DCW_fnc_displayscore = compile preprocessFileLineNumbers  "DCW\fnc\supportui\DisplayScore.sqf";
DCW_fnc_getCrateItems = compile preprocessFileLineNumbers  "DCW\fnc\supportui\GetCrateItems.sqf";
DCW_fnc_triggerSupport = compile preprocessFileLineNumbers  "DCW\fnc\supportui\TriggerSupport.sqf";

// MEDEVAC
DCW_fnc_spawnHelo = compile preprocessFileLineNumbers  "DCW\fnc\medevac\SpawnHelo.sqf";
DCW_fnc_SpawnHeloCrew = compile preprocessFileLineNumbers  "DCW\fnc\medevac\SpawnHeloCrew.sqf";
DCW_fnc_SpawnHeloReplacement = compile preprocessFileLineNumbers  "DCW\fnc\medevac\SpawnHeloReplacement.sqf";
DCW_fnc_HandleDamage = compile preprocessFileLineNumbers  "DCW\fnc\medevac\HandleDamage.sqf";
DCW_fnc_HandleKilled = compile preprocessFileLineNumbers  "DCW\fnc\medevac\HandleKilled.sqf";
DCW_fnc_Heal = compile preprocessFileLineNumbers "DCW\fnc\medevac\heal.sqf";
DCW_fnc_Carry = compile preprocessFileLineNumbers "DCW\fnc\medevac\carry.sqf";
DCW_fnc_ChopperPath = compile preprocessFileLineNumbers "DCW\fnc\medevac\chopperpath.sqf";
DCW_fnc_calculateTimeToHeal = compile preprocessFileLineNumbers "DCW\fnc\medevac\calculateTimeToHeal.sqf";
DCW_fnc_spawnHealEquipement = compile preprocessFileLineNumbers "DCW\fnc\medevac\spawnHealEquipement.sqf";
DCW_fnc_spawnObject = compile preprocessFileLineNumbers "DCW\fnc\medevac\spawnObject.sqf";
DCW_fnc_dropInHelo = compile preprocessFileLineNumbers "DCW\fnc\medevac\dropInHelo.sqf";
DCW_fnc_help = compile preprocessFileLineNumbers "DCW\fnc\medevac\help.sqf";
DCW_fnc_removeFAKS = compile preprocessFileLineNumbers "DCW\fnc\medevac\removeFAKS.sqf";
DCW_fnc_deleteMedevac = compile preprocessFileLineNumbers "DCW\fnc\medevac\deleteMedevac.sqf";
DCW_fnc_caller = compile preprocessFileLineNumbers "DCW\fnc\medevac\caller.sqf";
DCW_fnc_firstAid =  compileFinal preprocessFileLineNumbers "DCW\fnc\medevac\FirstAid.sqf";
DCW_fnc_injured = compile preprocessFileLineNumbers "DCW\fnc\medevac\injured.sqf";
DCW_fnc_removeActionHEal =  compileFinal preprocessFileLineNumbers "DCW\fnc\medevac\removeActionHEal.sqf";
DCW_fnc_addActionHeal = compile preprocessFileLineNumbers "DCW\fnc\medevac\addActionHeal.sqf";
DCW_fnc_resetState = compile preprocessFileLineNumbers "DCW\fnc\medevac\resetState.sqf";
 
//composition
compo_camp1 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp1.sqf");
compo_camp2 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp2.sqf");
compo_camp3 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp3.sqf");
compo_camp4 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp4.sqf");
compo_camp5 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp5.sqf");
compo_commander1 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\commander1.sqf");
compo_commander2 =  call (compileFinal preprocessFileLineNumbers "DCW\composition\commander2.sqf");
compos = [compo_camp1,compo_camp2,compo_camp3,compo_camp4,compo_camp5];
compo_rest =  call (compileFinal preprocessFileLineNumbers "DCW\composition\rest.sqf");
compo_camp =  call (compileFinal preprocessFileLineNumbers "DCW\composition\camp.sqf");
compo_captured =  call (compileFinal preprocessFileLineNumbers "DCW\composition\captured.sqf");
compo_startup =  call (compileFinal preprocessFileLineNumbers "DCW\composition\startup-composition.sqf");
compos_turrets=  call (compileFinal preprocessFileLineNumbers "DCW\composition\compound\turrets.sqf");
compos_objects =  call (compileFinal preprocessFileLineNumbers "DCW\composition\compound\objects.sqf");
compos_medical =  call (compileFinal preprocessFileLineNumbers "DCW\composition\compound\medical.sqf");
 

// Default configuration is called here
[] call (compileFinal preprocessFileLineNumbers "DCW\config\config-default.sqf"); 

// Mission introduction function
DCW_fnc_intro = compileFinal preprocessFileLineNumbers "DCW\intro\intro.sqf";

// Base config parameters 
[] call (compileFinal preprocessFileLineNumbers "DCW\config\config-parameters.sqf"); 

// ACE detection
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then { ACE_ENABLED = true; } else { ACE_ENABLED = false; };

if (ACE_ENABLED) then {
    [] call (compileFinal preprocessFileLineNumbers "DCW\config\ace-config.sqf"); 
};

// Wait until everything is ready
waitUntil {count ([] call DCW_fnc_allPlayers) > 0 && time > 0 };

RESISTANCE setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 0];

CIVILIAN setFriend [EAST, 1];
CIVILIAN setFriend [WEST, 1];
CIVILIAN setFriend [RESISTANCE, 1];

//DCW_STARTED = true;
//titleCut ["", "BLACK IN",1];

// Public variables
call (compileFinal preprocessFileLineNumbers "DCW\variables.sqf"); 


[] execVM "DCW\server.sqf";
[] execVM "DCW\client.sqf";
[] execVM "DCW\headlessClient.sqf";

