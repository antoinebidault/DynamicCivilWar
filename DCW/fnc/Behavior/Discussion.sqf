/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */


 private ["_file","_talkers","_array","_sentence","_talker","_spectator","_text"];

_file = _this select 0;
_talkers = _this select 1;
_array = _this select 2;

			
	//Add the topics, refer back to the file above
{ _x KbAddTopic [_file,_file,"",""];	}foreach _talkers;

{
	_text = _x select 0;
	_talker = _x select 1;
	_spectator = _x select 2;
   _talker lookAt _spectator;
   _spectator lookAt _talker;
	
	//sleep 3;
	_talker KbTell [_spectator,_file,_text];
	[name vehicle _talker,_text] call BIS_fnc_showSubtitle;
	waitUntil {
		_talker kbWasSaid [_spectator, _file,_text, 3];
	};

} forEach _array;


{ _x kbRemoveTopic _file;	} foreach _talkers;

true;