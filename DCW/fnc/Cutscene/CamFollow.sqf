params["_elt","_modeltoworld","_period"];

private _timer = 0;
_cam camSetPos (_elt modelToWorld _modeltoworld);
_cam camcommit 0;
while { _timer < _period } do {
	_cam camSetPos (_elt modelToWorld _modeltoworld);
	_cam camsettarget _elt modelToWorld[0,0,0];
	_cam camSetFov 1.0;
	_cam camcommit .5;
	sleep .2;
	_timer = _timer + .2;
};
_cam camSetPos (_elt modelToWorld _modeltoworld);
_cam camcommit 0;
sleep 0;
