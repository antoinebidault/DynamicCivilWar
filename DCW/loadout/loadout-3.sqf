
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
_this addVest "rhs_6b23_6sh116_vog";
for "_i" from 1 to 4 do {_this addItemToVest "FirstAidKit";};
_this addItemToVest "rhs_mag_9x19_17";
_this addItemToVest "rhs_mag_fakel";
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_rgn";};
for "_i" from 1 to 10 do {_this addItemToVest "rhs_VOG25";};
for "_i" from 1 to 6 do {_this addItemToVest "rhs_30Rnd_545x39_AK";};
_this addBackpack "rhs_rpg_empty";
_this addItemToBackpack "MineDetector";
for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
_this addItemToBackpack "rhs_rpg7_PG7V_mag";
_this addItemToBackpack "rhs_rpg7_PG7VL_mag";
_this addItemToBackpack "rhs_rpg7_OG7V_mag";
_this addHeadgear "rhs_altyn";

comment "Add weapons";
_this addWeapon "rhs_weap_ak74n_2_gp25";
_this addPrimaryWeaponItem "rhs_acc_dtk";
_this addPrimaryWeaponItem "rhs_acc_pkas";
_this addWeapon "rhs_weap_rpg7";
_this addWeapon "rhs_weap_pya";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

comment "Set identity";
_this setFace "GreekHead_A3_10_sa";
_this setSpeaker "rhs_male02rus";
