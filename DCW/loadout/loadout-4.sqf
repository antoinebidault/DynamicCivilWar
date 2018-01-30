
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
_this forceAddUniform "rhs_uniform_vmf_flora_subdued";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_1PN138";
for "_i" from 1 to 2 do {_this addItemToUniform "rhs_10Rnd_762x54mmR_7N1";};
_this addVest "rhs_6b23_digi_6sh92_headset";
for "_i" from 1 to 4 do {_this addItemToVest "FirstAidKit";};
_this addItemToVest "MineDetector";
for "_i" from 1 to 7 do {_this addItemToVest "rhs_10Rnd_762x54mmR_7N1";};
_this addBackpack "rhs_sidor";
for "_i" from 1 to 3 do {_this addItemToBackpack "FirstAidKit";};
_this addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_10Rnd_762x54mmR_7N1";};
_this addItemToBackpack "rhs_mag_9x19_17";
_this addHeadgear "rhs_beanie_green";

comment "Add weapons";
_this addWeapon "rhs_weap_svdp_wd";
_this addPrimaryWeaponItem "rhs_acc_tgpv2";
_this addPrimaryWeaponItem "rhs_acc_pso1m21";
_this addWeapon "rhs_weap_pya";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

comment "Set identity";
_this setFace "GreekHead_A3_10_l";
_this setSpeaker "rhs_male02rus";
