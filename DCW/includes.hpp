class Header
{
	gameType =  Coop;	// Game type
	minPlayers =  1;	// minimum number of players the mission supports
	maxPlayers = 10;	// maximum number of players the mission supports
};

disabledAI= 1;
enableDebugConsole[] = {"76561197974435552"};
allowFunctionsLog = 1;
author = "Bidass";
briefing = 0;
briefingName = "Dynamic Civil War {WORLD_NAME}";
onLoadMission = "Your objective is to stop the insurgency propagation and locate the enemy commander. (DCW v{VERSION})";
loadScreen = "images\loadscreen.paa"; 
overviewPicture = "images\loadscreen.paa"; 
overviewText = "Your primary objective is to locate and kill the enemy commander. You'll have to prevent the insurgency to spread across the country. The sector is full of insurgents and you'll have to make your way through all types of danger : IED, mortars, convoy, enemy patrol, disguised civilian... Keep the civilian on your side because they can become hostiles.";
overviewTextLocked = "Your primary objective is to locate and kill the enemy commander. You'll have to prevent the insurgency to spread across the country.The sector is full of insurgents and you'll have to make your way through all types of danger : IED, mortars, convoy, enemy patrol, disguised civilian... Keep the civilian on your side because they can become hostiles.";
wreckManagerMode = 2;
wreckRemovalMinTime = 12;
wreckRemovalMaxTime = 13;
wreckLimit = 15;
respawnOnStart = -1;
corpseManagerMode = 1;
corpseLimit = 18; 
ReviveMode = 0;                         //0: disabled, 1: enabled, 2: controlled by player attributes
ReviveUnconsciousStateMode = 0;         //0: basic, 1: advanced, 2: realistic
ReviveRequiredTrait = 0;                //0: none, 1: medic trait is required
ReviveRequiredItems = 2;                //0: none, 1: medkit, 2: medkit or first aid kit
ReviveRequiredItemsFakConsumed = 1;     //0: first aid kit is not consumed upon revive, 1: first aid kit is consumed
ReviveDelay = 10;                        //time needed to revive someone (in secs)
ReviveMedicSpeedMultiplier = 2;         //speed multiplier for revive performed by medic
ReviveForceRespawnDelay = 3;            //time needed to perform force respawn (in secs)
ReviveBleedOutDelay = 120;              //unconscious state duration (in secs)
keys[] = {"key1"};
keysLimit = 1;
taskManagement_propagate = 1;

//--------------------------------------------------------------
//---------------------    MUSICS    ---------------------------
//--------------------------------------------------------------

class CfgMusic
{
  	tracks[]=
  	{
      		seal,axe
  	};
    class seal
    {
          name = "seal";
          sound[] = {"\music\seal.ogg", 1, 1.0};
    };
     class axe
    {
          name = "axe";
          sound[] = {"\music\axe.ogg", 1, 1.0};
    };
};



#include "config\mission-parameters.hpp"
#include "fnc\supportui\Defines.hpp"
#include "fnc\supportui\buySupports.hpp"
#include "fnc\supportui\notification.hpp"
#include "config\respawn.hpp"
#include "config\config-combo.hpp"
#include "config\loadout-combo.hpp"

class RscTitles {
  #include "fnc\supportui\statusBar.hpp"
};