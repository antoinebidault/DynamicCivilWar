/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 * Update marker statistics data
 */

_nbSecured = 0;
_nbBastion = 0;
_total = 0;
_nbMassacred = 0;
_compoundReputationTotal = 0;

{
	_compoundState = _x select 12;	

	if (_compoundState == "secured"  || _compoundState == "humanitary") then {
		_nbSecured = _nbSecured + 1;
	};
	
	if (_compoundState == "bastion") then {
		_nbBastion = _nbBastion + 1;
	};
	
	if (_compoundState == "massacred") then {
		_nbMassacred = _nbMassacred + 1;
	};

	_compoundReputationTotal = _compoundReputationTotal + (_x select 13);

	_total = _total + 1;

} foreach MARKERS;

STAT_COMPOUND_TOTAL = _total;
STAT_COMPOUND_SECURED = _nbSecured;
STAT_COMPOUND_BASTION = _nbBastion;
STAT_COMPOUND_MASSACRED = _nbMassacred;
STAT_SUPPORT = round(_compoundReputationTotal/_total);
