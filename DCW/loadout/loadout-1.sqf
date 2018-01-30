
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
_this forceAddUniform "rhs_uniform_vmf_flora";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_1PN138";
_this addVest "rhs_6b23_digi_6sh92_Vog_Spetsnaz";
for "_i" from 1 to 4 do {_this addItemToVest "FirstAidKit";};
_this addItemToVest "rhs_mag_9x19_17";
_this addItemToVest "rhs_mag_fakel";
for "_i" from 1 to 3 do {_this addItemToVest "rhs_mag_rgn";};
_this addItemToVest "DemoCharge_Remote_Mag";
for "_i" from 1 to 3 do {_this addItemToVest "rhs_30Rnd_545x39_AK";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
_this addBackpack "rhs_assault_umbts_engineer_empty";
_this addItemToBackpack "MineDetector";
_this addItemToBackpack "ToolKit";
for "_i" from 1 to 4 do {_this addItemToBackpack "rhs_30Rnd_545x39_AK";};
_this addHeadgear "rhs_altyn_novisor_bala";

comment "Add weapons";
_this addWeapon "rhs_weap_ak74m_zenitco01";
_this addPrimaryWeaponItem "rhs_acc_tgpa";
_this addPrimaryWeaponItem "rhs_acc_2dpZenit_ris";
_this addPrimaryWeaponItem "rhs_acc_pkas";
_this addPrimaryWeaponItem "rhs_acc_grip_ffg2";
_this addWeapon "rhs_weap_pya";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

comment "Set identity";
_this setFace "WhiteHead_22_sa";
_this setSpeaker "rhs_male05rus";
