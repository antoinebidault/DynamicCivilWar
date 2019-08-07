



class RESPAWN_DIALOG
{
    idd = 5002;
    movingenable = true;
    duration = 10e10;

    class Controls
    {

         class RESPAWNBOX: IGUIBack
         {
          idc = -1;
          text = "";
          x = 0.390476 * safezoneW + safezoneX;
          y = 0.290476 * safezoneH + safezoneY;
          w = 0.236905 * safezoneW;
          h = 0.385238 * safezoneH;
         };
         class RESPAWNFRAME: RscFrame
         {
          idc = -1;
          text = $STR_DCW_respawn_respawnOptions;
          x = 0.390476 * safezoneW + safezoneX;
          y = 0.290476 * safezoneH + safezoneY;
          w = 0.236905 * safezoneW;
          h = 0.385238 * safezoneH;
         };
         
         class BUTTONRESPAWN_CAMP: RscButton
         {
          idc = 4101;
          text = $STR_DCW_respawn_camp;
          x = 0.4 * safezoneW + safezoneX;
          y = 0.5 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "RESPAWN_CHOICE = ""camp"";closeDialog 0;";
        };

        class BUTTONRESPAWNBASE: RscButton
         {
          idc = 4102;
          text = $STR_DCW_respawn_base;
          x = 0.4 * safezoneW + safezoneX;
          y = 0.45 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "RESPAWN_CHOICE = ""base"";closeDialog 0;";
        };
        
    };

};
