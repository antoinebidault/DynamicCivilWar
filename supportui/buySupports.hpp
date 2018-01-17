



class ICE_DIALOG
{
    idd = 5000;
    movingenable = true;
    duration = 10e10;

    class Controls
    {

         class ICE_BOX: IGUIBack
         {
          idc = -1;
          text = "";
          x = 0.390476 * safezoneW + safezoneX;
          y = 0.290476 * safezoneH + safezoneY;
          w = 0.236905 * safezoneW;
          h = 0.385238 * safezoneH;
         };
         class ICE_FRAME: RscFrame
         {
          idc = -1;
          text = "";
          x = 0.390476 * safezoneW + safezoneX;
          y = 0.290476 * safezoneH + safezoneY;
          w = 0.236905 * safezoneW;
          h = 0.385238 * safezoneH;
         };
         class ICE_BUTTONARTILLERY: RscButton
         {
          idc = -1;
          text = "ARTILLERY (-400 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.5 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "_nil=[""Artillery"",400] ExecVM ""supportui\choose.sqf""";
        };

        class ICE_BUTTONCAS: RscButton
         {
          idc = -1;
          text = "CAS (-800 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.45 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "_nil=[""CAS_Bombing"",800] ExecVM ""supportui\choose.sqf""";
        };
         class ICE_BUTTONAMMO: RscButton
         {
          idc = -1;
          text = "AMMO (-400 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.4 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "_nil=[""Drop"",400] ExecVM ""supportui\choose.sqf""";
        };
         class ICE_BUTTONTRANSPORT: RscButton
         {
          idc = -1;
          text = "TRANSPORT (-150 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.35 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "_nil=[""Transport"",150]ExecVM ""supportui\choose.sqf""";
        };
         class ICE_BUTTONUAV: RscButton
         {
          idc = -1;
          text = "UAV (-100 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.55 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "_nil=[""UAV"",100]ExecVM ""supportui\choose.sqf""";
        };

        class ICE_BUTTONNO: RscButton
        {
          idc = -1;
          text = "Back";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.625715 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "closeDialog 0;";
        };

        class ICE_TEXT: RscStructuredText
        {
         idc = 12345;
         text = "";
         x = 0.422618 * safezoneW + safezoneX;
         y = 0.3 * safezoneH + safezoneY;
         w = 0.171429 * safezoneW;
         h = 0.0404761 * safezoneH;
        };
       
      

    };



};
