/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 *
 * Mission start up
 * https://github.com/bidass/DynamicCivilWar
 * You are free to edit or share it
 */

titleCut ["Loading Mission...", "BLACK FADED", 999];
playMusic "ASOTheme";

[] Spawn {
    _loc =  nearestLocations [getPosWorld player, ["NameVillage","NameCity","NameCityCapital"],10000] select 0;
	
	// Info text
	[worldName, format["%1km from %2", round(((getPos _loc) distance player)/10)/100,text _loc], str(date select 1) + "." + str(date select 2) + "." + str(date select 0)] spawn BIS_fnc_infoText;
	sleep 5;
	"dynamicBlur" ppEffectEnable true;  
	"dynamicBlur" ppEffectAdjust [6];   
	"dynamicBlur" ppEffectCommit 0;     
	"dynamicBlur" ppEffectAdjust [0.0];  
	"dynamicBlur" ppEffectCommit 5;  
	titleCut ["", "BLACK IN", 5];
};

//A little animation for the player
player switchMove "Acts_welcomeOnHUB02_PlayerWalk_3"; 

//Mission loading
nul = [] execVM "functions\playlist.sqf"; //Init the music playlist
nul = [] execVM "DCW\init.sqf"; //Init the insurgents
nul = [player] execVM "medevac\init.sqf"; //Init the medevac system
