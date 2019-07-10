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

// Action preparation
[] call DCW_fnc_PrepareAction; 

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
ACE_ENABLED = if (isClass(configFile >> "CfgPatches" >> "ace_main")) then { true; } else { false; };

if (ACE_ENABLED) then {
    [] call (compileFinal preprocessFileLineNumbers "DCW\config\ace-config.sqf"); 
};

// Wait until everything is ready
waitUntil {count ([] call DCW_fnc_allPlayers) > 0 && time > 0 };


//DCW_STARTED = true;
//titleCut ["", "BLACK IN",1];

// Public variables
call (compileFinal preprocessFileLineNumbers "DCW\variables.sqf"); 

[] execVM "DCW\server.sqf";
[] execVM "DCW\client.sqf";
[] execVM "DCW\headlessClient.sqf";

