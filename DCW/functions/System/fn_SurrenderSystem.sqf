/*
  Author: 
    Bidass

  Version:
    {VERSION}

  Description:
    Player's surrendering system (Including a loop)

  Parameters:
    0: OBJECT - player

  Returns:
    BOOL - true 
*/

params["_player"];

sleep 15;

_actionId = -1;
_timer = time;
while { true } do {

	// If player is in bad situation
	if ( alive player 
	&& !(player getVariable ["dcw_surrender_action", false]) 
	&& (damage player > .3 || morale player < -0.5)
	&& (player findNearestEnemy player) distance player < 60 
	&& { _x distance player < 100 } count units GROUP_PLAYERS == 1
	&& _actionId == -1
	) then {
		[player] call DCW_fnc_shout;
		_timer = time;
		if (_actionId == -1) then {
			playMusic "axe";
			_actionId = player addAction ["<t color='#cd8700'>Surrender</t>",{
				params ["_target", "_caller", "_actionId", "_arguments"];
				_caller removeAction _actionId;
				[_caller] spawn DCW_fnc_captured;
			},nil,1,true,true];
		};
	} else {
		if (time > _timer + 60) then {
			if (_actionId != -1) then {
				player removeAction _actionId;
			};
			_actionId = -1;
		};
	};
	sleep 5;
};

