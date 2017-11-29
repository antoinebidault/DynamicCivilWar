params["_unit","_score"];

_startScore = _unit getVariable["IH_friendliness",50];
_unit setVariable["IH_friendliness",(0 max (100 min (_startScore + _score)))];
