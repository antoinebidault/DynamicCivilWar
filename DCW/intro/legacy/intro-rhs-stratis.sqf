if (didJIP) exitWith{ false };

playMusic "seal";


sleep 3;
titleCut ["", "BLACK IN", 5];

[] spawn {
	sleep 3;
	nul = ["Bidass presents",.3,.7,6] spawn BIS_fnc_dynamicText;
	sleep 11;
	nul = ["An arma III scenario",.3,.2,6] spawn BIS_fnc_dynamicText;
	sleep 14;
	nul = ["Dynamic Civil War",-1,-1,5,1,0] spawn BIS_fnc_dynamicText;
};
 