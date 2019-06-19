params["_cam","_elt","_modeltoworld","_period"];

private _timer = 0;
_cam camSetPos (_elt modelToWorld _modeltoworld);
_cam camcommit 0;
while { _timer < _period } do {
	_cam camSetPos (_elt modelToWorld _modeltoworld);
	_cam camsettarget _elt modelToWorld[0,0,0];
	_cam camSetFov 1.0;
	if (_timer <= .02) then {
		_cam camcommit .01;
		sleep .01;
		_timer = _timer + .01;
	}else{
		_cam camcommit .4;
		sleep .4;
		_timer = _timer + .4;
	};
};
_cam camSetPos (_elt modelToWorld _modeltoworld);
_cam camcommit 0;