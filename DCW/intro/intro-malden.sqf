
sleep 1;
titleCut ["", "BLACK IN",3];

playMusic "seal";

[player, "All units deployed on the insertion points", 150, 250, 75, 1, [], 0, false] call BIS_fnc_establishingShot;

[] spawn {
	sleep 13;
	nul = ["Bidass presents",.3,.7,6] spawn BIS_fnc_dynamicText;
	sleep 11;
	nul = ["An arma III scenario",.3,.2,6] spawn BIS_fnc_dynamicText;
	sleep 14;
	nul = ["Dynamic Civil War",-1,-1,5,1,0] spawn BIS_fnc_dynamicText;
};