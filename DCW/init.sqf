/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Main components preloading and initialization
 */

if (!isNull player) then {
	titleCut ["", "BLACK FADED",9999];
};

// Need some adjustements
{ 
	[_x,"MOVE"] remoteExec ["disableAI", 2];
	[_x,"FSM"] remoteExec ["disableAI", 2];
 } foreach allUnits;

enableDynamicSimulationSystem true;
"Group" setDynamicSimulationDistance 600;

// CONFIG
fnc_FactionClasses = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionClasses.sqf";
fnc_FactionGetUnits = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionGetUnits.sqf";
fnc_FactionList = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionList.sqf";
fnc_FactionGetSupportUnits =  compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionGetSupportUnits.sqf";
fnc_GetConfigVehicles =  compileFinal preprocessFileLineNumbers "DCW\fnc\System\GetConfigVehicles.sqf";
call(compileFinal preprocessFileLineNumbers  "DCW\config\config-dialog-functions.sqf");
fnc_Dialog =  compileFinal preprocessFileLineNumbers "DCW\config\config-dialog.sqf";
fnc_MissionSetup =  compileFinal preprocessFileLineNumbers "DCW\config\MissionSetup.sqf";

// INTRO 
fnc_CamFollow = compileFinal preprocessFileLineNumbers  "DCW\intro\CamFollow.sqf";
fnc_CompoundsecuredCutScene = compileFinal preprocessFileLineNumbers  "DCW\intro\CompoundsecuredCutScene.sqf";

// SYSTEM
fnc_getClusters = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\GetClusters.sqf";
fnc_isInMarker= compileFinal preprocessFileLineNumbers  "DCW\fnc\System\isinMarker.sqf";
fnc_findBuildings= compileFinal preprocessFileLineNumbers  "DCW\fnc\System\findBuildings.sqf";
fnc_addMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\addMarker.sqf";
fnc_deleteMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\deleteMarker.sqf";
fnc_findNearestMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\findNearestMarker.sqf";
fnc_cachePut = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\CachePut.sqf";
fnc_showIndicator = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\ShowIndicator.sqf"; 
fnc_talk = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\Talk.sqf";
fnc_getVisibility = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\GetVisibility.sqf";
fnc_undercover = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\Undercover.sqf";
fnc_setCompoundState =  compileFinal preprocessFileLineNumbers  "DCW\fnc\System\setCompoundState.sqf";
fnc_setCompoundSupport =  compileFinal preprocessFileLineNumbers  "DCW\fnc\System\setCompoundSupport.sqf";
fnc_surrenderSystem = compile preprocessFileLineNumbers  "DCW\fnc\System\SurrenderSystem.sqf";
fnc_getMarkerById = compile preprocessFileLineNumbers "DCW\fnc\System\getMarkerById.sqf";
fnc_refreshMarkerStats = compile preprocessFileLineNumbers "DCW\fnc\System\refreshMarkerStats.sqf";

//SPAWN
fnc_respawn= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\Respawn.sqf";
fnc_respawndialog= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\RespawnDialog.sqf";
fnc_spawnUnits= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnUnits.sqf";
fnc_spawnAsEnemy = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnAsEnemy.sqf";
fnc_spawnFriendly = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnFriendly.sqf";
fnc_spawnchaser = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnchaser.sqf";
fnc_spawnoutpost = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnoutpost.sqf";
fnc_spawnMeetingPoint = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMeetingPoint.sqf";
fnc_spawnCivil =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCivil.sqf";
fnc_spawnEnemy =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnEnemy.sqf";
fnc_spawnFriendlyOutpost =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnFriendlyOutpost.sqf";
fnc_spawnMortar = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMortar.sqf";
fnc_spawnCars = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCars.sqf";
fnc_spawnMainObjective = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMainObjective.sqf";
fnc_spawnSecondaryObjective= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnSecondaryObjective.sqf";
fnc_spawnConvoy = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnConvoy.sqf";
fnc_spawnPosition = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnPosition.sqf";
fnc_spawnCrashSite = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCrashSite.sqf";
fnc_spawnDefendTask = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnDefendTask.sqf";
fnc_spawnIED = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnIED.sqf";
fnc_spawncrate = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnCrate.sqf";
fnc_SpawnObjects = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnObjects.sqf";
fnc_spawnhumanitaryoutpost = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnhumanitaryoutpost.sqf";
fnc_spawnhumanitar = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnhumanitar.sqf";
fnc_spawnSnipers =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnSnipers.sqf";


//PATROL
fnc_enemyCompoundPatrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\CompoundPatrol.sqf";
fnc_civilianCompoundPatrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\CivilianCompoundPatrol.sqf";
fnc_simplePatrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\SimplePatrol.sqf";
fnc_largePatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\LargePatrol.sqf";
fnc_chase = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\chase.sqf";
fnc_carPatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\carPatrol.sqf";
fnc_officerPatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\officerPatrol.sqf";
fnc_civilianPatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\civilianPatrol.sqf";
fnc_gotomeeting =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\gotomeeting.sqf";
fnc_chopperpatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\ChopperPatrol.sqf";
fnc_humanitarPatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\HumanitarPatrol.sqf";

//OBJECTIVES
fnc_getIntel = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\GetIntel.sqf";
fnc_cache = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\cache.sqf";
fnc_hostage = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\hostage.sqf";
fnc_Success = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\Success.sqf";
fnc_failed = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\Failed.sqf";
fnc_createtask =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\createtask.sqf";
fnc_foundCommander =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\foundCommander.sqf";
fnc_mainObjectiveIntel =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\MainObjectiveIntel.sqf";
fnc_CompoundSecured =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\CompoundSecured.sqf";

//CUSTOM BEHAVIOR
fnc_mortarBombing = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\MortarBombing.sqf";
fnc_addtorch = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\addtorch.sqf";
fnc_randomAnimation = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\randomAnimation.sqf";
fnc_updateRep =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\UpdateRep.sqf";
fnc_localChief = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\LocalChief.sqf";
fnc_medic = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\Medic.sqf";
fnc_firstAid =  compileFinal preprocessFileLineNumbers "DCW\fnc\Behavior\FirstAid.sqf";
fnc_prepareAction = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\PrepareAction.sqf"; 
fnc_addCivilianAction = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\addCivilianAction.sqf";
fnc_shout = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\Shout.sqf";
fnc_badBuyLoadout = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\BadBuyLoadout.sqf";
fnc_camp =  compileFinal preprocessFileLineNumbers "DCW\fnc\Behavior\Camp.sqf";
fnc_actionCamp =  compileFinal preprocessFileLineNumbers "DCW\fnc\Behavior\ActionCamp.sqf";

//HANDLERS
fnc_handleFiredNear = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleFiredNear.sqf";
fnc_handleDamaged = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleDamaged.sqf";
fnc_handlekill = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleKill.sqf";
fnc_handleAttacked = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleAttacked.sqf";

// Support UI
fnc_supportuiInit = compile preprocessFileLineNumbers  "DCW\supportui\init.sqf";
fnc_updatescore = compile preprocessFileLineNumbers  "DCW\supportui\fnc\UpdateScore.sqf";
fnc_afford = compile preprocessFileLineNumbers  "DCW\supportui\fnc\Afford.sqf";
fnc_supportui = compile preprocessFileLineNumbers  "DCW\supportui\fnc\SupportUI.sqf";
fnc_displayscore = compile preprocessFileLineNumbers  "DCW\supportui\fnc\DisplayScore.sqf";
fnc_getCrateItems = compile preprocessFileLineNumbers  "DCW\supportui\fnc\GetCrateItems.sqf";

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


compos_turrets=  call (compileFinal preprocessFileLineNumbers "DCW\composition\compound\turrets.sqf");
compos_objects =  call (compileFinal preprocessFileLineNumbers "DCW\composition\compound\objects.sqf");
compos_medical =  call (compileFinal preprocessFileLineNumbers "DCW\composition\compound\medical.sqf");

// Switch here the config you need.
[] call (compileFinal preprocessFileLineNumbers format["DCW\config\config-%1.sqf",_this select 0]); 

// Mission introduction function
fnc_intro = compileFinal preprocessFileLineNumbers format["DCW\intro\intro-%1.sqf",_this select 0];

// Base config parameters 
[] call (compileFinal preprocessFileLineNumbers "DCW\config\config-parameters.sqf"); 

// ACE detection
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then { ACE_ENABLED = true; } else { ACE_ENABLED = false; };

if (ACE_ENABLED) then {
    [] call (compileFinal preprocessFileLineNumbers "DCW\config\ace-config.sqf"); 
};

// Global scope variable



// Wait until everything is ready
waitUntil {count allPlayers > 0 &&  time > 0 };

RESISTANCE setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 0];

CIVILIAN setFriend [EAST, 1];
CIVILIAN setFriend [WEST, 1];
CIVILIAN setFriend [RESISTANCE, 1];

//DCW_STARTED = true;
//titleCut ["", "BLACK IN",1];

call (compileFinal preprocessFileLineNumbers "DCW\variables.sqf"); 
[] execVM "DCW\server.sqf";
[] execVM "DCW\client.sqf";

