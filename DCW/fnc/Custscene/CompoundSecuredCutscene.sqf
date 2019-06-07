parasm["_units"];

//Execute a little animation
[[ (_units select { typeOf _x == FRIENDLY_FLAG }) select 0 ],{ 
	params["_flag"];
	if (isServer) exitWith{};
	_asker = player;
	showCinemaBorder true;
	_cam = "camera" camcreate (_flag modelToWorld [-10,-0.2,2.9]);
	_cam cameraeffect ["internal", "back"];
	_cam camSetTarget  (_flag modelToWorld [0,0,5]); 
	_cam camCommit 0;
	_cam camSetFov 1;
	_cam camSetPos (_flag modelToWorld [-20,-0.2,3.2]);
	_cam camCommit 10;
	
	titleCut ["6 hours later...", "BLACK OUT", 3];
	sleep 3;
	titleCut ["6 hours later...", "BLACK FADED", 999];
	
	if (!isMultiplayer) then {
		skipTime 6;
	};

	sleep 1;
	titleCut ["6 hours later...", "BLACK IN", 4];
	sleep 10;

	showCinemaBorder false;
	_cam cameraeffect ["terminate", "back"];
	camDestroy _cam;

}] remoteExec["spawn"];