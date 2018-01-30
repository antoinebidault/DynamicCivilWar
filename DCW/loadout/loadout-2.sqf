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
_this forceAddUniform "rhs_uniform_flora_patchless_alt";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_1PN138";
for "_i" from 1 to 4 do {_this addItemToUniform "SmokeShellGreen";};
_this addVest "rhs_6b13_6sh92_radio";
for "_i" from 1 to 3 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 5 do {_this addItemToVest "rhs_30Rnd_545x39_AK";};
for "_i" from 1 to 3 do {_this addItemToVest "rhs_mag_9x19_17";};
_this addBackpack "rhs_assault_umbts";
_this addItemToBackpack "MineDetector";
_this addItemToBackpack "ToolKit";
_this addItemToBackpack "rhs_rshg2_mag";
for "_i" from 1 to 3 do {_this addItemToBackpack "rhs_30Rnd_545x39_AK";};
_this addHeadgear "rhs_beret_milp";

comment "Add weapons";
_this addWeapon "rhs_weap_ak105_zenitco01_b33_grip1";
_this addPrimaryWeaponItem "rhs_acc_tgpa";
_this addPrimaryWeaponItem "rhs_acc_2dpZenit_ris";
_this addPrimaryWeaponItem "rhs_acc_1p87";
_this addPrimaryWeaponItem "rhs_acc_grip_ffg2";
_this addWeapon "rhs_weap_rshg2";
_this addWeapon "rhs_weap_pya";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
