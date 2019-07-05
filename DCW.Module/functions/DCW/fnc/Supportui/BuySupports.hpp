



class DCW_DIALOG
{
    idd = 5000;
    movingenable = false;
    duration = 10e10;

    class Controls
    {

         class DCW_BOX: IGUIBack
         {
          idc = -1;
          text = "";
          x = 0.390476 * safezoneW + safezoneX;
          y = 0.290476 * safezoneH + safezoneY;
          w = 0.236905 * safezoneW;
          h = 0.5 * safezoneH;
         };
         class DCW_FRAME: RscFrame
         {
          idc = -1;
          text = "";
          x = 0.390476 * safezoneW + safezoneX;
          y = 0.290476 * safezoneH + safezoneY;
          w = 0.236905 * safezoneW;
          h = 0.5 * safezoneH;
         };

         class DCW_BUTTONARTILLERY: RscButton
         {
          idc = -1;
          text = "ARTILLERY (-300 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.5 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "closeDialog 0;_nil=[""Artillery"",300] remoteExec [""DCW_fnc_triggerSupport"",2]";
        };

        class DCW_BUTTONCAS: RscButton
         {
          idc = -1;
          text = "CAS Helicopter (-400 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.45 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "closeDialog 0;_nil=[""CAS_Heli"",400] remoteExec [""DCW_fnc_triggerSupport"",2]";
        };
         class DCW_BUTTONAMMO: RscButton
         {
          idc = -1;
          text = "AMMO (-100 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.4 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "closeDialog 0;_nil=[""Drop"",100] remoteExec [""DCW_fnc_triggerSupport"",2]";
        };
         class DCW_BUTTONTRANSPORT: RscButton
         {
          idc = -1;
          text = "TRANSPORT (-150 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.35 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "closeDialog 0;_nil=[""Transport"",150] remoteExec [""DCW_fnc_triggerSupport"",2]";
        };
       
         class DCW_BUTTONUAV: RscButton
         {
          idc = -1;
          text = "UAV MQ-9 (-1000 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.55 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "closeDialog 0;_nil=[""UAV"",1000] remoteExec [""DCW_fnc_triggerSupport"",2]";
        };


           class DCW_BUTTONVEHICLE: RscButton
         {
          idc = -1;
          text = "vehicle paradrop (-150 points)";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.6 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "closeDialog 0;_nil=[""vehicle"",150] remoteExec [""DCW_fnc_triggerSupport"",2]";
        };

        class DCW_BUTTONNO: RscButton
        {
          idc = -1;
          text = "Back";
          x = 0.4 * safezoneW + safezoneX;
          y = 0.7 * safezoneH + safezoneY;
          w = 0.22 * safezoneW;
          h = 0.0404761 * safezoneH;
          action = "closeDialog 0;";
        };

        class DCW_TEXT: RscStructuredText
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
