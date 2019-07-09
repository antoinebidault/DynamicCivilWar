/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Main components preloading and initialization
*/


if (!isNull player) then {
	titleCut ["", "BLACK FADED",9999];
	enableSentences false;
	enableRadio false;
}; 

enableDynamicSimulationSystem true;
"Group" setDynamicSimulationDistance 600;

// CONFIG
call(compileFinal preprocessFileLineNumbers  "DCW\config\config-dialog-functions.sqf");
DCW_fnc_dialog =  compileFinal preprocessFileLineNumbers "DCW\config\config-dialog.sqf";
DCW_fnc_missionSetup =  compileFinal preprocessFileLineNumbers "DCW\config\MissionSetup.sqf";

// INTRO 
/*
DCW_fnc_camFollow = compileFinal preprocessFileLineNumbers  "DCW\functions\cutscene\CamFollow.sqf";
DCW_fnc_compoundsecuredCutScene = compileFinal preprocessFileLineNumbers  "DCW\functions\cutscene\CompoundsecuredCutScene.sqf";
*/
// SYSTEM
DCW_fnc_factionClasses = compileFinal preprocessFileLineNumbers "DCW\functions\System\FactionClasses.sqf";
DCW_fnc_factionGetUnits = compileFinal preprocessFileLineNumbers "DCW\functions\System\FactionGetUnits.sqf";
DCW_fnc_factionList = compileFinal preprocessFileLineNumbers "DCW\functions\System\FactionList.sqf";
DCW_fnc_factionGetSupportUnits =  compileFinal preprocessFileLineNumbers "DCW\functions\System\FactionGetSupportUnits.sqf";
DCW_fnc_getConfigVehicles =  compileFinal preprocessFileLineNumbers "DCW\functions\System\GetConfigVehicles.sqf";
DCW_fnc_getClusters = compileFinal preprocessFileLineNumbers  "DCW\functions\System\GetClusters.sqf";
DCW_fnc_isInMarker= compileFinal preprocessFileLineNumbers  "DCW\functions\System\isinMarker.sqf";
DCW_fnc_findBuildings= compileFinal preprocessFileLineNumbers  "DCW\functions\System\findBuildings.sqf";
DCW_fnc_addMarker = compileFinal preprocessFileLineNumbers  "DCW\functions\System\addMarker.sqf";
DCW_fnc_deleteMarker = compileFinal preprocessFileLineNumbers  "DCW\functions\System\deleteMarker.sqf";
DCW_fnc_findNearestMarker = compileFinal preprocessFileLineNumbers  "DCW\functions\System\findNearestMarker.sqf";
DCW_fnc_cachePut = compileFinal preprocessFileLineNumbers  "DCW\functions\System\CachePut.sqf";
DCW_fnc_showIndicator = compileFinal preprocessFileLineNumbers  "DCW\functions\System\ShowIndicator.sqf"; 
DCW_fnc_talk = compileFinal preprocessFileLineNumbers  "DCW\functions\System\Talk.sqf";
DCW_fnc_getVisibility = compileFinal preprocessFileLineNumbers  "DCW\functions\System\GetVisibility.sqf";
DCW_fnc_undercover = compileFinal preprocessFileLineNumbers  "DCW\functions\System\Undercover.sqf";
DCW_fnc_setCompoundState =  compileFinal preprocessFileLineNumbers  "DCW\functions\System\setCompoundState.sqf";
DCW_fnc_setCompoundSupport =  compileFinal preprocessFileLineNumbers  "DCW\functions\System\setCompoundSupport.sqf";
DCW_fnc_surrenderSystem = compile preprocessFileLineNumbers  "DCW\functions\System\SurrenderSystem.sqf";
DCW_fnc_captured = compileFinal preprocessFileLineNumbers  "DCW\functions\System\Captured.sqf";
DCW_fnc_getMarkerById = compile preprocessFileLineNumbers "DCW\functions\System\getMarkerById.sqf";
DCW_fnc_refreshMarkerStats = compile preprocessFileLineNumbers "DCW\functions\System\refreshMarkerStats.sqf";
DCW_fnc_teleport = compile preprocessFileLineNumbers  "DCW\functions\System\teleport.sqf";
DCW_fnc_addAction = compile preprocessFileLineNumbers "DCW\functions\system\AddAction.sqf";
DCW_fnc_removeAction = compile preprocessFileLineNumbers "DCW\functions\system\RemoveAction.sqf";
DCW_fnc_allPlayers = compileFinal preprocessFileLineNumbers  "DCW\functions\system\AllPlayers.sqf";
DCW_fnc_fillClusters = compileFinal preprocessFileLineNumbers  "DCW\functions\system\FillClusters.sqf";

//SPAWN
DCW_fnc_respawn= compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\Respawn.sqf";
DCW_fnc_respawndialog= compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\RespawnDialog.sqf";
DCW_fnc_spawnUnits= compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnUnits.sqf";
DCW_fnc_spawnAsEnemy = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnAsEnemy.sqf";
DCW_fnc_spawnFriendly = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnFriendly.sqf";
DCW_fnc_spawnchaser = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\spawnchaser.sqf";
DCW_fnc_spawnoutpost = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\spawnoutpost.sqf";
DCW_fnc_spawnMeetingPoint = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnMeetingPoint.sqf";
DCW_fnc_spawnCivil =  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnCivil.sqf";
DCW_fnc_spawnEnemy =  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnEnemy.sqf";
DCW_fnc_spawnFriendlyOutpost =  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnFriendlyOutpost.sqf";
DCW_fnc_spawnMortar = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnMortar.sqf";
DCW_fnc_spawnCars = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnCars.sqf";
DCW_fnc_spawnMainObjective = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnMainObjective.sqf";
DCW_fnc_spawnSecondaryObjective= compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnSecondaryObjective.sqf";
DCW_fnc_spawnConvoy = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnConvoy.sqf";
DCW_fnc_spawnPosition = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnPosition.sqf";
DCW_fnc_spawnCrashSite = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnCrashSite.sqf";
DCW_fnc_spawnDefendTask = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnDefendTask.sqf";
DCW_fnc_spawnIED = compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnIED.sqf";
DCW_fnc_spawncrate = compile preprocessFileLineNumbers  "DCW\functions\Spawn\spawnCrate.sqf";
DCW_fnc_SpawnObjects = compile preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnObjects.sqf";
DCW_fnc_spawnhumanitaryoutpost = compile preprocessFileLineNumbers  "DCW\functions\Spawn\spawnhumanitaryoutpost.sqf";
DCW_fnc_spawnhumanitar = compile preprocessFileLineNumbers  "DCW\functions\Spawn\spawnhumanitar.sqf";
DCW_fnc_spawnSnipers =  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnSnipers.sqf";
DCW_fnc_spawnSheep =  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnSheep.sqf";
DCW_fnc_spawnTank =  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnTank.sqf";
DCW_fnc_spawnRandomEnemies=  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\spawnRandomEnemies.sqf";
DCW_fnc_spawnRandomCar=  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\spawnRandomCar.sqf";
DCW_fnc_spawnRandomCivilian=  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\spawnRandomCivilian.sqf";
DCW_fnc_spawnChopper=  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\spawnChopper.sqf";
DCW_fnc_spawnLoop =  compileFinal preprocessFileLineNumbers  "DCW\functions\Spawn\SpawnLoop.sqf";

//PATROL
DCW_fnc_enemyCompoundPatrol= compileFinal preprocessFileLineNumbers  "DCW\functions\Patrol\CompoundPatrol.sqf";
DCW_fnc_civilianCompoundPatrol= compileFinal preprocessFileLineNumbers  "DCW\functions\Patrol\CivilianCompoundPatrol.sqf";
DCW_fnc_simplePatrol= compileFinal preprocessFileLineNumbers  "DCW\functions\Patrol\SimplePatrol.sqf";
DCW_fnc_largePatrol = compileFinal preprocessFileLineNumbers  "DCW\functions\Patrol\LargePatrol.sqf";
DCW_fnc_chase = compileFinal preprocessFileLineNumbers  "DCW\functions\Patrol\chase.sqf";
DCW_fnc_carPatrol = compileFinal preprocessFileLineNumbers  "DCW\functions\Patrol\carPatrol.sqf";
DCW_fnc_officerPatrol = compile preprocessFileLineNumbers  "DCW\functions\Patrol\officerPatrol.sqf";
DCW_fnc_civilianPatrol = compileFinal preprocessFileLineNumbers  "DCW\functions\Patrol\civilianPatrol.sqf";
DCW_fnc_gotomeeting =  compileFinal preprocessFileLineNumbers  "DCW\functions\Patrol\gotomeeting.sqf";
DCW_fnc_chopperpatrol = compile preprocessFileLineNumbers  "DCW\functions\Patrol\ChopperPatrol.sqf";
DCW_fnc_humanitarPatrol = compile preprocessFileLineNumbers  "DCW\functions\Patrol\HumanitarPatrol.sqf";
DCW_fnc_patrolDistributeToHC = compile preprocessFileLineNumbers  "DCW\functions\Patrol\patrolDistributeToHC.sqf";

//OBJECTIVES
DCW_fnc_getIntel = compileFinal preprocessFileLineNumbers  "DCW\functions\objective\GetIntel.sqf";
DCW_fnc_cache = compileFinal preprocessFileLineNumbers  "DCW\functions\objective\cache.sqf";
DCW_fnc_hostage = compileFinal preprocessFileLineNumbers  "DCW\functions\objective\hostage.sqf";
DCW_fnc_Success = compileFinal preprocessFileLineNumbers  "DCW\functions\objective\Success.sqf";
DCW_fnc_failed = compileFinal preprocessFileLineNumbers  "DCW\functions\objective\Failed.sqf";
DCW_fnc_createtask =  compileFinal preprocessFileLineNumbers  "DCW\functions\objective\createtask.sqf";
DCW_fnc_foundCommander =  compileFinal preprocessFileLineNumbers  "DCW\functions\objective\foundCommander.sqf";
DCW_fnc_mainObjectiveIntel =  compileFinal preprocessFileLineNumbers  "DCW\functions\objective\MainObjectiveIntel.sqf";
DCW_fnc_CompoundSecured =  compileFinal preprocessFileLineNumbers  "DCW\functions\objective\CompoundSecured.sqf";

//CUSTOM BEHAVIOR
[] call DCW_fnc_PrepareAction; 

/*
DCW_fnc_mortarBombing = compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\MortarBombing.sqf";
DCW_fnc_addtorch = compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\addtorch.sqf";
DCW_fnc_randomAnimation = compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\randomAnimation.sqf";
DCW_fnc_updateRep =  compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\UpdateRep.sqf";
DCW_fnc_localChief = compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\LocalChief.sqf";
DCW_fnc_medic = compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\Medic.sqf";
call(compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\PrepareAction.sqf");
DCW_fnc_addCivilianAction = compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\addCivilianAction.sqf";
DCW_fnc_shout = compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\Shout.sqf";
DCW_fnc_badGuyLoadOut = compileFinal preprocessFileLineNumbers  "DCW\functions\Behavior\badGuyLoadOut.sqf";
DCW_fnc_camp =  compileFinal preprocessFileLineNumbers "DCW\functions\Behavior\Camp.sqf";
//DCW_fnc_actionCamp =  compileFinal preprocessFileLineNumbers "DCW\functions\Behavior\ActionCamp.sqf";
DCW_fnc_surrender =  compileFinal preprocessFileLineNumbers "DCW\functions\Behavior\Surrender.sqf";
*/

//HANDLERS
DCW_fnc_handleFiredNear = compileFinal preprocessFileLineNumbers  "DCW\functions\Handler\HandleFiredNear.sqf";
DCW_fnc_handleDamaged = compileFinal preprocessFileLineNumbers  "DCW\functions\Handler\HandleDamaged.sqf";
DCW_fnc_handlekill = compileFinal preprocessFileLineNumbers  "DCW\functions\Handler\HandleKill.sqf";
DCW_fnc_handleAttacked = compileFinal preprocessFileLineNumbers  "DCW\functions\Handler\HandleAttacked.sqf";

// Support UI
DCW_fnc_supportInit = compile preprocessFileLineNumbers  "DCW\functions\supportui\init.sqf";
DCW_fnc_addSupportUi = compile preprocessFileLineNumbers  "DCW\functions\supportui\addSupportUi.sqf";
DCW_fnc_updatescore = compile preprocessFileLineNumbers  "DCW\functions\supportui\UpdateScore.sqf";
DCW_fnc_afford = compile preprocessFileLineNumbers  "DCW\functions\supportui\Afford.sqf";
DCW_fnc_displaySupportUiDialog = compile preprocessFileLineNumbers  "DCW\functions\supportui\displaySupportUiDialog.sqf";
DCW_fnc_displayscore = compile preprocessFileLineNumbers  "DCW\functions\supportui\DisplayScore.sqf";
DCW_fnc_getCrateItems = compile preprocessFileLineNumbers  "DCW\functions\supportui\GetCrateItems.sqf";
DCW_fnc_triggerSupport = compile preprocessFileLineNumbers  "DCW\functions\supportui\TriggerSupport.sqf";

// MEDEVAC
DCW_fnc_spawnHelo = compile preprocessFileLineNumbers  "DCW\functions\medevac\SpawnHelo.sqf";
DCW_fnc_SpawnHeloCrew = compile preprocessFileLineNumbers  "DCW\functions\medevac\SpawnHeloCrew.sqf";
DCW_fnc_SpawnHeloReplacement = compile preprocessFileLineNumbers  "DCW\functions\medevac\SpawnHeloReplacement.sqf";
DCW_fnc_HandleDamage = compile preprocessFileLineNumbers  "DCW\functions\medevac\HandleDamage.sqf";
DCW_fnc_HandleKilled = compile preprocessFileLineNumbers  "DCW\functions\medevac\HandleKilled.sqf";
DCW_fnc_Heal = compile preprocessFileLineNumbers "DCW\functions\medevac\heal.sqf";
DCW_fnc_Carry = compile preprocessFileLineNumbers "DCW\functions\medevac\carry.sqf";
DCW_fnc_ChopperPath = compile preprocessFileLineNumbers "DCW\functions\medevac\chopperpath.sqf";
DCW_fnc_calculateTimeToHeal = compile preprocessFileLineNumbers "DCW\functions\medevac\calculateTimeToHeal.sqf";
DCW_fnc_spawnHealEquipement = compile preprocessFileLineNumbers "DCW\functions\medevac\spawnHealEquipement.sqf";
DCW_fnc_spawnObject = compile preprocessFileLineNumbers "DCW\functions\medevac\spawnObject.sqf";
DCW_fnc_dropInHelo = compile preprocessFileLineNumbers "DCW\functions\medevac\dropInHelo.sqf";
DCW_fnc_help = compile preprocessFileLineNumbers "DCW\functions\medevac\help.sqf";
DCW_fnc_removeFAKS = compile preprocessFileLineNumbers "DCW\functions\medevac\removeFAKS.sqf";
DCW_fnc_deleteMedevac = compile preprocessFileLineNumbers "DCW\functions\medevac\deleteMedevac.sqf";
DCW_fnc_caller = compile preprocessFileLineNumbers "DCW\functions\medevac\caller.sqf";
DCW_fnc_firstAid =  compileFinal preprocessFileLineNumbers "DCW\functions\medevac\FirstAid.sqf";
DCW_fnc_injured = compile preprocessFileLineNumbers "DCW\functions\medevac\injured.sqf";
DCW_fnc_removeActionHEal =  compileFinal preprocessFileLineNumbers "DCW\functions\medevac\removeActionHEal.sqf";
DCW_fnc_addActionHeal = compile preprocessFileLineNumbers "DCW\functions\medevac\addActionHeal.sqf";
DCW_fnc_resetState = compile preprocessFileLineNumbers "DCW\functions\medevac\resetState.sqf";
 
// Loadout
DCW_fnc_loadoutSniper = compileFinal preprocessFileLineNumbers  "DCW\Loadout\Loadout-sniper.sqf";
DCW_fnc_loadoutSpotter = compileFinal preprocessFileLineNumbers  "DCW\Loadout\Loadout-spotter.sqf";

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

