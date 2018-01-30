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
_this forceAddUniform "rhsgref_uniform_og107";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_30Rnd_762x39mm";
_this addVest "rhs_6b5_officer_khaki";
for "_i" from 1 to 3 do {_this addItemToVest "FirstAidKit";};
_this addItemToVest "rhs_mag_f1";
for "_i" from 1 to 5 do {_this addItemToVest "rhs_30Rnd_762x39mm";};
_this addHeadgear "rhssaf_beret_red";
_this addGoggles "G_Aviator";

comment "Add weapons";
_this addWeapon "rhs_weap_m92";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

comment "Set identity";
_this setFace "WhiteHead_18";
_this setSpeaker "rhs_male01cz";
