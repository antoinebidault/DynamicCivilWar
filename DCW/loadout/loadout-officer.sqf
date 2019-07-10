
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
_this forceAddUniform "U_BG_Guerilla2_3";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "10Rnd_9x21_Mag";
_this addItemToUniform "30Rnd_545x39_Mag_F";
_this addVest "V_TacChestrig_cbr_F";
_this addHeadgear "H_Beret_blk";
_this addGoggles "G_Spectacles";

comment "Add weapons";
_this addWeapon "arifle_AKS_F";
_this addWeapon "hgun_Pistol_01_F";
_this addWeapon "Binocular";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

comment "Set identity";
[_this,"GreekHead_A3_03","male01gre"] call BIS_fnc_setIdentity;
