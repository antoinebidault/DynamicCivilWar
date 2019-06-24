
comment "Exported from Arsenal by dugland";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _this) exitWith {};

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
_this forceAddUniform "U_I_C_Soldier_Bandit_3_F";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "10Rnd_9x21_Mag";
_this addVest "V_TacChestrig_grn_F";
for "_i" from 1 to 4 do {_this addItemToVest "10Rnd_9x21_Mag";};
for "_i" from 1 to 7 do {_this addItemToVest "50Rnd_570x28_SMG_03";};
_this addHeadgear "H_MilCap_gry";
_this addGoggles "G_Aviator";

comment "Add weapons";
_this addWeapon "SMG_03C_black";
_this addWeapon "hgun_Pistol_01_F";
_this addWeapon "Binocular";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

comment "Set identity";
[_this,"Ioannou","male06gre"] call BIS_fnc_setIdentity;
