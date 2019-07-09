/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: Bidass

  Version:
    {VERSION}
 * License : GNU (GPL)
 * Detect if an element is in a rounded or rectangular marker
 */

 private ["_p","_m", "_px", "_py", "_mpx", "_mpy", "_msx", "_msy", "_rpx", "_rpy", "_xmin", "_xmax", "_ymin", "_ymax", "_ma", "_res", "_ret"];

   _p = _this select 0; // object
   _m = _this select 1; // marker
   _off = if (count _this > 2) then { _this select 2; }else{0;}; // offset
   
    if (typeName _p == "ARRAY") then {
     _px = _p select 0;
     _py = _p select 1;
   } else{
	   if (typeName _p == "OBJECT") then {
	     _px = position _p select 0;
	     _py = position _p select 1;
	   } else {
	     _px = getMarkerPos _p select 0;
	     _py = getMarkerPos _p select 1;
	   };
	};

   _mpx = getMarkerPos _m select 0;
   _mpy = getMarkerPos _m select 1;
   _msx = ((getMarkerSize _m select 0) + _off);
   _msy = ((getMarkerSize _m select 1) + _off);
   _ma = -markerDir _m;
   _rpx = ( (_px - _mpx) * cos(_ma) ) + ( (_py - _mpy) * sin(_ma) ) + _mpx;
   _rpy = (-(_px - _mpx) * sin(_ma) ) + ( (_py - _mpy) * cos(_ma) ) + _mpy;
   if ((markerShape _m) == "RECTANGLE") then {
     _xmin = _mpx - _msx;_xmax = _mpx + _msx;_ymin = _mpy - _msy;_ymax = _mpy + _msy;
     if (((_rpx > _xmin) && (_rpx < _xmax)) && ((_rpy > _ymin) && (_rpy < _ymax))) then { _ret=true; } else { _ret=false; };
   } else {
     if (_msx == 0 || _msy == 0) then{_ret = false;}else{
       _res = (((_rpx-_mpx)^2)/(_msx^2)) + (((_rpy-_mpy)^2)/(_msy^2));
       if ( _res < 1 ) then{ _ret=true; }else{ _ret=false; };
     };
   };
   _ret;
