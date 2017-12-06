/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

/*
Playlist script
Bidass
*/


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

//Playlist
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