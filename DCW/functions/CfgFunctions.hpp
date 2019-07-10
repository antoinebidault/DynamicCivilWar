class CfgFunctions
{
	class DCW
	{
		class DCWFunctions
		{
			tag = "DCW"; //Custom tag name
			requiredAddons[] = {"A3_Data_F"}; //Optional requirements of CfgPatches classes. When some addons are missing, functions won't be compiled.
		};

		class Behavior
		{	
			file = "DCW\functions\behavior";
			class actionCamp {};
			class addCivilianAction {};
			class addTorch {};
			class badGuyLoadout {};
			class camp {};
			class discussion {};
			class localChief {};
			class medic {};
			class mortarbombing {};
			class prepareAction {};
			class randomAnimation {};
			class shout {};
			class surrender {};
			class updateRep {};
		};

		class CutScene
		{	
			file = "DCW\functions\cutscene";
			class CamFollow {};
			class CompoundSecuredCutScene {};
		};

		
		class System
		{	
			file = "DCW\functions\system";
			class factionClasses {};
			class factionGetUnits {};
			class factionList {};
			class factionGetSupportUnits {};
			class getConfigVehicles {};
			class getClusters {};
			class isInMarker {};
			class findBuildings {};
			class addMarker {};
			class deleteMarker {};
			class findNearestMarker {};
			class cachePut {};
			class showIndicator {};
			class talk {};
			class getVisibility {};
			class undercover {};
			class setCompoundState {};
			class setCompoundSupport {};
			class surrenderSystem {};
			class captured {};
			class getMarkerById {};
			class refreshMarkerStats {};
			class teleport {};
			class addAction {};
			class removeAction {};
			class allPlayers {};
			class fillClusters {};
		};
			
		class Spawn
		{	
			file = "DCW\functions\spawn";
			class respawn {};
			class respawnDialog {};
			class spawnUnits {};
			class spawnAsEnemy {};
			class spawnchaser {};
			class spawnoutpost {};
			class spawnMeetingPoint {};
			class spawnCivil {};
			class spawnEnemy {};
			class spawnFriendlyOutpost {};
			class spawnMortar {};
			class spawnCars {};
			class spawnMainObjective {};
			class spawnSecondaryObjective {};
			class spawnConvoy {};
			class spawnPosition {};
			class spawnCrashSite {};
			class spawnDefendTask {};
			class spawnIED {};
			class spawncrate {};
			class spawnhumanitaryoutpost {};
			class SpawnObjects {};
			class spawnhumanitar {};
			class spawnSnipers {};
			class spawnSheep {};
			class spawnRandomEnemies {};
			class spawnRandomCivilian {};
			class spawnRandomCar {};
			class spawnChopper {};
			class spawnLoop {};
		};

		class Patrol
		{	
			file = "DCW\functions\patrol";
			class enemyCompoundPatrol {};
			class civilianCompoundPatrol {};
			class simplePatrol {};
			class largePatrol {};
			class chase {};
			class carPatrol {};
			class officerPatrol {};
			class civilianPatrol {};
			class gotomeeting {};
			class chopperpatrol {};
			class humanitarPatrol {};
			class patrolDistributeToHC {};
		};

	    class Objective
		{	
			file = "DCW\functions\objective";
			class getIntel {};
			class cache {};
			class hostage {};
			class success {};
			class failed {};
			class createtask {};
			class mainObjectiveIntel {};
			class compoundSecured {};
		};

	    class Handler
		{	
			file = "DCW\functions\handler";
			class HandleFiredNear {};
			class HandleDamaged {};
			class HandleKill {};
			class HandleAttacked {};
		};

		
	    class SupportUI
		{	
			file = "DCW\functions\supportui";
			class SupportInit {};
			class addSupportUi {};
			class UpdateScore {};
			class Afford {};
			class displaySupportUiDialog {};
			class DisplayScore {};
			class GetCrateItems {};
			class TriggerSupport {};
			class vehicleLift {};
		};

		class Medical
		{	
			file = "DCW\functions\medical";
			class medicalInit{};
			class SpawnHelo {};
			class SpawnHeloCrew {};
			class SpawnHeloReplacement {};
			class HandleDamage {};
			class HandleKilled {};
			class heal {};
			class carry {};
			class chopperpath {};
			class calculateTimeToHeal {};
			class spawnHealEquipement {};
			class spawnObject {};
			class dropInHelo {};
			class help {};
			class removeFAKS {};
			class deleteMedevac {};
			class caller {};
			class FirstAid {};
			class injured {};
			class removeActionHeal {};
			class addActionHeal {};
			class resetState {};
		};
	};
};