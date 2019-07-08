
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
_this forceAddUniform "U_B_FullGhillie_sard";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 4 do {_this addItemToUniform "20Rnd_762x51_Mag";};
_this addVest "V_BandollierB_oli";
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
_this addItemToVest "SmokeShell";
_this addItemToVest "SmokeShellRed";
for "_i" from 1 to 2 do {_this addItemToVest "Chemlight_red";};
for "_i" from 1 to 4 do {_this addItemToVest "20Rnd_762x51_Mag";};
_this addGoggles "G_Bandanna_khk";

comment "Add weapons";
_this addWeapon "srifle_DMR_06_camo_F";
_this addPrimaryWeaponItem "optic_AMS_snd";
_this addWeapon "hgun_Rook40_F";
_this addWeapon "Binocular";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

comment "Set identity";
[_this,"PersianHead_A3_01","male03per"] call BIS_fnc_setIdentity;
