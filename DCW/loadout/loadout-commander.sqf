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
_this forceAddUniform "rhsgref_uniform_altis_lizard_olive";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhsgref_30rnd_556x45_m21";
_this addVest "rhs_6b5_officer_ttsko";
for "_i" from 1 to 8 do {_this addItemToVest "rhsgref_30rnd_556x45_m21";};
for "_i" from 1 to 2 do {_this addItemToVest "APERSMine_Range_Mag";};
_this addHeadgear "rhssaf_beret_black";
_this addGoggles "G_Spectacles";

comment "Add weapons";
_this addWeapon "rhs_weap_m21s";
_this addPrimaryWeaponItem "rhs_acc_pkas";
_this addWeapon "Binocular";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

comment "Set identity";
_this setFace "GreekHead_A3_13";
_this setSpeaker "male03gre";
