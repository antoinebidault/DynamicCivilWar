params["_basebox"];


if (count GEAR_AND_STUFF > 0) exitWith {GEAR_AND_STUFF;};


_unnest = {
		private "_unnested";
		_unnested = [];
			{
				{
					_unnested pushBackUnique _x;
				} foreach _x;
			} forEach _this;

		_unnested
	};



_removex = {

  private "_blacklisted";
  
   // if !(_allowVanilaGear) then {
      _blacklisted = ["", "Throw", "Put", "OPF_F", "OPF_G_F", "BWA3_Faction", "BLU_F", "BLU_G_F", "IND_F", "IND_G_F", "CIV_F", "Virtual_F", "Interactive_F"];
   // } else {
   //   _blacklisted = ["", "Throw", "Put", "BWA3_Faction", "CIV_F", "Virtual_F", "Interactive_F"];
   // };
  
    { 
      if (_x in _blacklisted) then { 
        _this = _this - [_x];
      };
    } foreach _this ; 
    _this
};

_other_bags = [
  "B_O_Parachute_02_F","O_AA_01_weapon_F","O_AT_01_weapon_F","O_Assault_Diver","O_GMG_01_A_weapon_F","O_GMG_01_high_weapon_F","O_GMG_01_weapon_F","O_HMG_01_A_weapon_F","O_HMG_01_high_weapon_F","O_HMG_01_support_F","O_HMG_01_support_high_F","O_HMG_01_weapon_F","O_Mortar_01_support_F","O_Mortar_01_weapon_F","O_Static_Designator_02_weapon_F","O_UAV_01_backpack_F","B_Respawn_Sleeping_bag_blue_F"
];

_other_weapons = [
  "Laserdesignator"
];

_other_mags = [
  "B_IR_Grenade"
];

_other_items = [
  "G_B_Diving","B_UavTerminal","NVGoggles","V_RebreatherB","H_CrewHelmetHeli_B","H_HelmetCrew_B","H_Cap_khaki_specops_UK","H_Cap_tan_specops_US","H_Cap_usblack","H_HelmetB_black","H_HelmetB_camo","H_HelmetB_desert","H_HelmetB_grass","H_HelmetB_light","H_HelmetB_light_black","H_HelmetB_light_desert","H_HelmetB_light_grass","H_HelmetB_light_sand","H_HelmetB_light_snakeskin","H_HelmetB_sand","H_HelmetB_snakeskin","H_HelmetSpecB","H_HelmetSpecB_blk","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_sand","H_HelmetSpecB_snakeskin","H_PilotHelmetFighter_B","H_PilotHelmetHeli_B","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_HeliPilotCoveralls","U_B_PilotCoveralls","U_Rangemaster","U_Competitor","U_B_Wetsuit","U_B_GhillieSuit","U_B_CTRG_2","U_B_survival_uniform","U_B_CTRG_1","U_B_CTRG_3","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_BG_Guerilla1_1","U_BG_leader","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla2_2","U_BG_Guerilla3_1","U_BG_Guerrilla_6_1","U_I_G_Story_Protagonist_F","U_I_G_resistanceLeader_F"
];


_allside_items = [
  //attachments
  "Zasleh2","muzzle_mzls_H","muzzle_mzls_L","muzzle_mzls_B","muzzle_mzls_vector","muzzle_snds_H","muzzle_snds_L","muzzle_snds_B","muzzle_snds_H_MG","optic_COWS","optic_Arco","optic_Hamr","optic_ACOG","optic_Aco","optic_ACO_grn","optic_srs","optic_Holosight","optic_dcl","optic_NVS","optic_Nightstalker","optic_SOS","optic_Valdada","optic_marksman","optic_tws","optic_tws_mg","optic_tws_sniper","acc_flashlight","acc_flashlight_IR","acc_pointer_IR","acc_pointer_GreenLaser",
  //vests
  "V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_Chestrig_khk","V_Chestrig_oli","V_Chestrig_rgr","V_HarnessOGL_brn","V_HarnessOGL_gry","V_HarnessO_brn","V_HarnessO_gry","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_blk","V_PlateCarrier2_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierH_CTRG","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIAGL_oli","V_PlateCarrierL_CTRG","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_rgr","V_PlateCarrier_Kerry","V_Press_F","V_Rangemaster_belt","V_TacVest_blk","V_TacVest_blk_POLICE","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli",
  //hats
  "H_Bandanna_blu","H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sand","H_Bandanna_sgg","H_Bandanna_surfer","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn","H_Beret_02","H_Beret_Colonel","H_Beret_blk","H_Booniehat_dgtl","H_Booniehat_khk","H_Booniehat_khk_hs","H_Booniehat_mcamo","H_Booniehat_oli","H_Booniehat_tan","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_blk_ION","H_Cap_blk_Raven","H_Cap_blu","H_Cap_brn_SPECOPS","H_Cap_grn","H_Cap_grn_BI","H_Cap_headphones","H_Cap_marshal","H_Cap_oli","H_Cap_oli_hs","H_Cap_police","H_Cap_press","H_Cap_red","H_Cap_surfer","H_Cap_tan","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_HelmetB","H_MilCap_blue","H_MilCap_dgtl","H_MilCap_gry","H_MilCap_mcamo","H_MilCap_ocamo","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive","H_Shemag_olive_hs","H_StrawHat","H_StrawHat_dark","H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_cbr","H_Watchcap_khk",
  //uniforms
  "U_C_Commoner1_1","U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Poor_1","U_C_Poor_2","U_C_WorkerCoveralls","U_C_Scientist","U_C_HunterBody_grn","U_C_Poor_shorts_1","U_C_Commoner_shorts","U_C_ShirtSurfer_shorts","U_C_TeeSurfer_shorts_1","U_C_TeeSurfer_shorts_2","U_C_Journalist","U_OrestesBody","U_NikosBody","U_NikosAgedBody","U_Marshal",
  //glasses
  "G_Spectacles","G_Spectacles_Tinted","G_Combat","G_Lowprofile","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Squares","G_Squares_Tinted","G_Sport_BlackWhite","G_Sport_Blackyellow","G_Sport_Greenblack","G_Sport_Checkered","G_Sport_Red","G_Tactical_Black","G_Aviator","G_Lady_Mirror","G_Lady_Dark","G_Lady_Red","G_Lady_Blue","G_Diving","G_Goggles_VR","G_Balaclava_blk","G_Balaclava_oli","G_Balaclava_combat","G_Balaclava_lowprofile","G_Bandanna_blk","G_Bandanna_oli","G_Bandanna_khk","G_Bandanna_tan","G_Bandanna_beast","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_aviator","G_Shades_Blue","G_Sport_Blackred","G_Tactical_Clear",
  //others
  "FirstAidKit","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch","Medikit","MineDetector","ToolKit","Laserbatteries"
];

_allside_weapons = [
  "Binocular","Rangefinder"
];

_allside_mags = [
  "1Rnd_HE_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_Smoke_Grenade_shell","3Rnd_HE_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell","3Rnd_SmokeGreen_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","3Rnd_SmokeRed_Grenade_shell","3Rnd_SmokeYellow_Grenade_shell","3Rnd_Smoke_Grenade_shell","3Rnd_UGL_FlareCIR_F","3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareWhite_F","3Rnd_UGL_FlareYellow_F","APERSBoundingMine_Range_Mag","APERSMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","DemoCharge_Remote_Mag","SLAMDirectionalMine_Wire_Mag","SatchelCharge_Remote_Mag","UGL_FlareCIR_F","UGL_FlareGreen_F","UGL_FlareRed_F","UGL_FlareWhite_F","UGL_FlareYellow_F","HandGrenade"
];

_allside_packs = [
  "B_AssaultPackG","B_AssaultPack_Kerry","B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg","C_Bergen_blu","C_Bergen_grn","C_Bergen_red","B_BergenC_blu","B_BergenC_grn","B_BergenC_red","B_BergenG","B_Bergen_blk","B_Bergen_mcamo","B_Bergen_rgr","B_Bergen_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_oucamo","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oli","B_FieldPack_oucamo","G_AssaultPack","G_Bergen","B_HuntingBackpack","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_rgr","B_Kitbag_sgg","B_OutdoorPack_blk","B_OutdoorPack_blu","B_OutdoorPack_tan","B_Respawn_TentA_F","B_Respawn_TentDome_F","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"
];

_blacklist_mags = [
  "IEDLandBig_Remote_Mag","IEDLandSmall_Remote_Mag","IEDUrbanBig_Remote_Mag","IEDUrbanSmall_Remote_Mag"
];

_uniforms = [];
_linkeditems = [];
_weapons = [];
_magazines = [];
_backpacks = [];
_items = [];

{

  _uniforms pushBackUnique (getText (configFile >> "CfgVehicles" >> _x >> "uniformClass"));
  _linkeditems pushBackUnique (getArray (configFile >> "CfgVehicles" >> _x >> "linkedItems"));
  _weapons pushBackUnique (getArray (configFile >> "CfgVehicles" >> _x >> "weapons"));
  _magazines pushBackUnique (getArray (configfile >> "CfgVehicles" >> _x >> "magazines"));
  _backpacks pushBackUnique (getText (configFile >> "CfgVehicles" >> _x >> "backpack"));
  _items pushBackUnique (getArray (configfile >> "CfgVehicles" >> _x >> "Items"));
      
} forEach FRIENDLY_LIST_UNITS;

_linkeditems = _linkeditems call _unnest;
_weapons = _weapons call _unnest;
_magazines = _magazines call _unnest;
_items = _items call _unnest;

_uniforms = _uniforms call _removex;
_linkeditems = _linkeditems call _removex;
_weapons = _weapons call _removex;
_magazines = _magazines call _removex;
_backpacks = _backpacks call _removex;
_items = _items call _removex;

_items =  _items + _linkeditems + _uniforms;

  _gathereditems = _other_items + _allside_items;
  _gatheredweapons = _other_weapons + _allside_weapons;
  _gatheredmags = _other_mags + _allside_mags;
  _gatheredpacks = _other_bags + _allside_packs;

  {_items pushBackUnique _x} foreach _gathereditems;
  {_weapons pushBackUnique _x} foreach _gatheredweapons;
  {_magazines pushBackUnique _x} forEach _gatheredmags;
  {_backpacks pushBackUnique _x} foreach _gatheredpacks;

GEAR_AND_STUFF = [_weapons,_magazines,_items,_backpacks,_blacklist_mags];

GEAR_AND_STUFF;
/*
if (count GEAR_AND_STUFF == 0) then {
  GEAR_AND_STUFF = [];
  _gearAndStuffArray = [];
  { 
    _items =  getUnitLoadout _x;
    if (count _items > 0) then { 
    { 
      if (typeName _x == "ARRAY" ) then { 
        if (count _x > 0) then { 
          {
            if (typeName _x == "STRING") then {
              if (_x != "") then { _gearAndStuffArray pushBackUnique _x;  };
            } else{
              if (typeName _x == "ARRAY" ) then { 
                  if (count _x > 0) then { 
                    {
                      if (typeName _x == "STRING" ) then {
                        if (_x != "") then { _gearAndStuffArray pushBackUnique _x;  };
                      };
                    }foreach _x;
                  }; 
                };
            };
          } foreach _x;
        }; 
      } else { 
        if (typeName _x == "STRING") then {
          if (_x != "") then { _gearAndStuffArray pushBackUnique _x;  };
        };
      }; 
      } foreach _items; 
    }; 
  } foreach FRIENDLY_LIST_UNITS;

  
  _weapons = configFile >> "CfgVehicles";

  for "_i" from 1 to ((count _weapons) - 1) do 
  {
    _weapon = _weapons select _i;

    if (isClass _weapon && (configName _weapon) isKindOf "Bag_Base" ) then 
    {
     _gearAndStuffArray pushback (configName _weapon);
    };
  };
  
  GEAR_AND_STUFF = _gearAndStuffArray;
};

GEAR_AND_STUFF;
*/