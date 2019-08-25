/*
  Author: 
    Bidass

  Version:
    0.9.1

  Description:
    A new talking 
	["localChief",[""]]

  Parameters:
    0: OBJECT - unit

  Returns:
    OBJECT - unit 
*/
 private ["_file","_talkers","_array","_sentence","_talker","_spectator","_text"];

waitUntil {isNull(uiNamespace getVariable ["BIS_dynamicText",displayNull])};
_file = _this select 0;
_array = _this select 1;
_additionalTalkers = _this select 2;
_filePath = "DCW\voices\" + _file + "\CfgSentences.bikb";
_topic = format["topic-%1-%2", _file,str (random 1000)];
//Add the topics, refer back to the file above
{ 
	_talker = _x select 0;
	if (!(_talker kbHasTopic _topic)) then {
		_talker KbAddTopic [_topic,_filePath]; 
	};
	
	_hearer = _x select 1;
	if (!(_hearer kbHasTopic _topic)) then {
		_hearer KbAddTopic [_topic,_filePath]; 
	};
}foreach _array ;

{
	_talker = _x select 0;
	_spectator = _x select 1;
	_text = _x select 2;
	
	//sleep 3;
	_talker KbTell [_spectator,_topic, _text];
	_sentenceText = getText(missionConfigFile >> "CfgSentences" >> "DCW" >> _file >> "Sentences" >> _text >> "text");
	[_talker, _sentenceText] spawn DCW_fnc_showSubtitle;

	waitUntil {
		_talker kbWasSaid [_spectator, _topic,_text, 3];
	};

	[] call DCW_fnc_hideSubtitle;

	if (!isNull player) then {
		player createDiarySubject ["ConvLog", localize "STR_DCW_conversation_convLog"];
		player createDiaryRecord ["ConvLog", [name _talker, format["%1 %2", date,_text]]];
	};
} forEach _array;


{
	_talker = _x select 0;
	if (_talker kbHasTopic _topic) then {
		_talker kbRemoveTopic _topic; 
	};
	
	_hearer = _x select 1;
	if (_hearer kbHasTopic _topic) then {
		_hearer kbRemoveTopic _topic; 
	};
	
 } foreach _array ;

true;

