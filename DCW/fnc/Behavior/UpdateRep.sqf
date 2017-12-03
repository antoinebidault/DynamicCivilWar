/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

params["_unit","_score"];

_startScore = _unit getVariable["DCW_Friendliness",50];
_unit setVariable["DCW_Friendliness",(0 max (100 min (_startScore + _score)))];
