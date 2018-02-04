comment "Exported from Arsenal by dugland";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "rhs_uniform_mvd_izlom";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_1PN138";
for "_i" from 1 to 4 do {_this addItemToUniform "SmokeShellGreen";};
_this addVest "rhs_6b13_EMR_6sh92_radio";
for "_i" from 1 to 3 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_rgd5";};
_this addItemToVest "rhs_mag_rgn";
for "_i" from 1 to 4 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 4 do {_this addItemToVest "rhs_30Rnd_545x39_AK";};
_this addBackpack "rhs_assault_umbts_engineer_empty";
_this addItemToBackpack "MineDetector";
_this addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_mine_pmn2_mag";};
_this addItemToBackpack "rhs_mag_rgd5";
_this addItemToBackpack "SmokeShellGreen";
_this addItemToBackpack "rhs_30Rnd_545x39_AK";
_this addHeadgear "rhs_altyn_bala";

comment "Add weapons";
_this addWeapon "rhs_weap_ak74m_npz";
_this addPrimaryWeaponItem "rhs_acc_dtk";
_this addPrimaryWeaponItem "rhs_acc_perst1ik";
_this addPrimaryWeaponItem "rhs_acc_rakursPM";
_this addWeapon "rhs_weap_rshg2";
_this addWeapon "rhs_weap_pya";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";


comment "Set identity";
_this setFace "GreekHead_A3_10_l";
_this setSpeaker "rhs_male02rus";
