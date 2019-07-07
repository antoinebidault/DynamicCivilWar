// Reset all the unit's specific states
// Corrected player rating
if (rating _this < 0) then {
	_this addRating ((-(rating _this)) + 1000);
};

_this remoteExec ["RemoveAllActions"];
detach _this;
_this setDamage 0;
_this enableAI "ALL";
_this stop false;
_this setCaptive false;
_this setUnconscious false;
if (vehicle _this == _this) then {
	[_this,""] remoteExec["switchMove"];
};
_this call DCW_fnc_removeActionHeal;
[_this,"DCW_fnc_carry"] call DCW_fnc_removeAction; 
_this setVariable["DCW_fnc_carry",-1,true];
_this setVariable["DCW_this_injured",false,true];
_this setVariable["DCW_this_dragged",false,true];
_this setVariable["DCW_healer",objNull,true];
_this getVariable["DCW_marker_injured",""] setMarkerPos (getPos _this);
if (ACE_ENABLED) then {
	[objNull, _this] remoteExec ["ace_medical_DCW_fnc_treatmentAdvanced_fullHealLocal"];
};


//Default trait
_this setUnitTrait ["explosiveSpecialist",true];



if (isPlayer _this && (leader GROUP_PLAYERS) == _this) then {
	_this remoteExec ["removeAllActions"];
	sleep .3;
	_this call DCW_fnc_actionCamp;
	_this call DCW_fnc_addSupportUi;
};

if (isPlayer _this && DEBUG) then {
	_this call DCW_fnc_teleport;
};