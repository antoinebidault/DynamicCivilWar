/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Main components preloading and initialization
 */

 
// CONFIG
fnc_FactionClasses = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionClasses.sqf";
fnc_FactionGetUnits = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionGetUnits.sqf";
fnc_FactionList = compileFinal preprocessFileLineNumbers "DCW\fnc\System\FactionList.sqf";
fnc_dialog =  compileFinal preprocessFileLineNumbers "DCW\config\config-dialog.sqf";

// INTRO 
fnc_CamFollow = compileFinal preprocessFileLineNumbers  "DCW\intro\CamFollow.sqf";

// SYSTEM
fnc_GetClusters = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\GetClusters.sqf";
fnc_isInMarker= compileFinal preprocessFileLineNumbers  "DCW\fnc\System\isinMarker.sqf";
fnc_findBuildings= compileFinal preprocessFileLineNumbers  "DCW\fnc\System\findBuildings.sqf";
fnc_addMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\addMarker.sqf";
fnc_deleteMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\deleteMarker.sqf";
fnc_findNearestMarker = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\findNearestMarker.sqf";
fnc_CachePut = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\CachePut.sqf";
fnc_ShowIndicator = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\ShowIndicator.sqf"; 
fnc_Talk = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\Talk.sqf";
fnc_GetVisibility = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\GetVisibility.sqf";
fnc_Undercover = compileFinal preprocessFileLineNumbers  "DCW\fnc\System\Undercover.sqf";

//SPAWN
fnc_Respawn= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\Respawn.sqf";
fnc_respawndialog= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\RespawnDialog.sqf";
fnc_SpawnUnits= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnUnits.sqf";
fnc_SpawnAsEnemy = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnAsEnemy.sqf";
fnc_SpawnFriendly = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnFriendly.sqf";
fnc_spawnchaser = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnchaser.sqf";
fnc_spawnoutpost = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnoutpost.sqf";
fnc_SpawnMeetingPoint = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMeetingPoint.sqf";
fnc_SpawnCivil =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCivil.sqf";
fnc_SpawnEnemy =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnEnemy.sqf";
fnc_SpawnFriendlyOutpost =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnFriendlyOutpost.sqf";
fnc_SpawnMortar = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMortar.sqf";
fnc_SpawnCars = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCars.sqf";
fnc_SpawnMainObjective = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnMainObjective.sqf";
fnc_SpawnSecondaryObjective= compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnSecondaryObjective.sqf";
fnc_SpawnConvoy = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnConvoy.sqf";
fnc_SpawnPosition = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnPosition.sqf";
fnc_SpawnCrashSite = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnCrashSite.sqf";
fnc_SpawnIED = compileFinal preprocessFileLineNumbers  "DCW\fnc\Spawn\SpawnIED.sqf";
fnc_spawncrate = compile preprocessFileLineNumbers  "DCW\fnc\Spawn\spawnCrate.sqf";

//PATROL
fnc_Patrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\CompoundPatrol.sqf";
fnc_SimplePatrol= compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\SimplePatrol.sqf";
fnc_LargePatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\LargePatrol.sqf";
fnc_chase = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\chase.sqf";
fnc_carPatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\carPatrol.sqf";
fnc_officerPatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\officerPatrol.sqf";
fnc_civilianPatrol = compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\civilianPatrol.sqf";
fnc_gotomeeting =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Patrol\gotomeeting.sqf";
fnc_chopperpatrol = compile preprocessFileLineNumbers  "DCW\fnc\Patrol\ChopperPatrol.sqf";

//OBJECTIVES
fnc_GetIntel = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\GetIntel.sqf";
fnc_cache = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\cache.sqf";
fnc_Hostage = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\hostage.sqf";
fnc_Success = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\Success.sqf";
fnc_failed = compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\Failed.sqf";
fnc_createtask =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\createtask.sqf";
fnc_foundCommander =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\foundCommander.sqf";
fnc_MainObjectiveIntel =  compileFinal preprocessFileLineNumbers  "DCW\fnc\objective\MainObjectiveIntel.sqf";

//CUSTOM BEHAVIOR
fnc_MortarBombing = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\MortarBombing.sqf";
fnc_addtorch = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\addtorch.sqf";
fnc_randomAnimation = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\randomAnimation.sqf";
fnc_UpdateRep =  compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\UpdateRep.sqf";
fnc_LocalChief = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\LocalChief.sqf";
fnc_Medic = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\Medic.sqf";
fnc_PrepareAction = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\PrepareAction.sqf"; 
fnc_AddCivilianAction = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\addCivilianAction.sqf";
fnc_shout = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\Shout.sqf";
fnc_BadBuyLoadout = compileFinal preprocessFileLineNumbers  "DCW\fnc\Behavior\BadBuyLoadout.sqf";
fnc_Rest =  compileFinal preprocessFileLineNumbers "DCW\fnc\Behavior\Rest.sqf";
fnc_Camp =  compileFinal preprocessFileLineNumbers "DCW\fnc\Behavior\Camp.sqf";



//HANDLERS
fnc_HandleFiredNear = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleFiredNear.sqf";
fnc_HandleDamaged = compileFinal preprocessFileLineNumbers  "DCW\fnc\Handler\HandleDamaged.sqf";
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

//Switch here the config you need.
[] call (compileFinal preprocessFileLineNumbers format["DCW\config\config-%1.sqf",_this select 0]); 

// INTRO
fnc_intro = compileFinal preprocessFileLineNumbers format["DCW\intro\intro-%1.sqf",_this select 0];

[] call (compileFinal preprocessFileLineNumbers "DCW\config\config-parameters.sqf"); 

[] execVM "DCW\server.sqf";
[] execVM "DCW\client.sqf";