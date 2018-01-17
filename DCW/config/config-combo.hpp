


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by dugland, v1.063, #Wokemo)
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)


class PARAMETERS_DIALOG
{
    idd = 5001;
    movingenable = true;
    duration = 10e10;

    class Controls
    {
         class RscFrame_1800: RscFrame
        {
          idc = 1800;
          text = ""; //--- ToDo: Localize;
          x = 0.390476 * safezoneW + safezoneX;
          y = 0.290476 * safezoneH + safezoneY;
          w = 0.236905 * safezoneW;
          h = 0.385238 * safezoneH;
        };
          class RscBox_1801: IGUIBack
         {
          idc = 1801;
          text = "";
          x = 0.390476 * safezoneW + safezoneX;
          y = 0.290476 * safezoneH + safezoneY;
          w = 0.236905 * safezoneW;
          h = 0.385238 * safezoneH;
         };
       
        class RscButtonMenuOK_2600: RscButtonMenuOK
        {
          idc = -1;
          text = ""; 
          x = 32 * GUI_GRID_W + GUI_GRID_X;
          y = 19 * GUI_GRID_H + GUI_GRID_Y;
          w = 6 * GUI_GRID_W;
          h = 2 * GUI_GRID_H;
        };
         class RscText_1002: RscText
        {
            idc = 1002;
            text = "Heure de la journée"; //--- ToDo: Localize;
            x = 17 * GUI_GRID_W + GUI_GRID_X;
            y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 20 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class RscCombo_2100: RscCombo
        {
          idc = 2100;
          text = "Time of the day"; //--- ToDo: Localize;
          x = 17 * GUI_GRID_W + GUI_GRID_X;
          y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
          w = 7 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Time day"; //--- ToDo: Localize;
        };
         class RscText_1003: RscText
        {
            idc = 1003;
            text = "Météo"; //--- ToDo: Localize;
            x = 17 * GUI_GRID_W + GUI_GRID_X;
            y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 20 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
         class RscCombo_2101: RscCombo
        {
          idc = 2101;
          text = "Weather"; //--- ToDo: Localize;
          x = 17 * GUI_GRID_W + GUI_GRID_X;
          y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
          w = 7 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Time weather"; //--- ToDo: Localize;
        };
        
        class ICE_BUTTON_1000: RscButton
        {
          idc = -1;
          text = "OK";
          x = 17 * GUI_GRID_W + GUI_GRID_X;
          y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
          w = 7 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          action = "closeDialog 0;";
        };
    };
};

