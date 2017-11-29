//execVM "civilian\init.sqf";
//[position player, 100] execVM "wreck\init.sqf";
//0 = [50,5] execvm "tpw_furniture.sqf";



[("... Loading Mission")] spawn BIS_fnc_infoText;
titleCut ["", "BLACK FADED", 999];
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
	titleCut ["", "BLACK IN", 3];
};

player switchMove "Acts_welcomeOnHUB02_PlayerWalk_3"; 

MUSICS = [
	"beast",
	"mhDown",
	"axe",
	"seal",
	"summit",
	"bhdown",
	"bhdown2"
];
ehID = addMusicEventHandler ["MusicStop", {MUSIC_PLAYING = false}];
MUSIC_PLAYING = true;
fnc_playList = {
	params["_musics"];
	while {count _musics > 0} do
	{
		MUSIC_PLAYING = true;
		_music = _musics call BIS_fnc_selectRandom;
		playMusic _music;
		_musics = _musics - [_music];
		waitUntil{sleep 5;!MUSIC_PLAYING};
	};
	[MUSICS] spawn fnc_playList;
};

[MUSICS] spawn fnc_playList;


nul = [] execVM "insurgent_hunt\init.sqf";
nul = [player] execVM "medevac\init.sqf";