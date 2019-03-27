/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

params["_helo"];

unit removeAction MEDEVAC_action;
if(!isNull _helo)then{
	{ deleteVehicle _x ;} forEach units interventionGroup;
	{ deleteVehicle _x ;} forEach crew _helo;
	deleteVehicle _helo;
};