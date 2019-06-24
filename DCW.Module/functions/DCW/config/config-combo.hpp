


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

        
        
         class RscBox_1801: IGUIBack
         {
          moving = 1;	
          idc = 1801;
          text = "";
          x = -20 * GUI_GRID_W + GUI_GRID_X;
          y =  -3 * GUI_GRID_H;
          w = 28 * GUI_GRID_W;
          h = 27 * GUI_GRID_H;
         };
       
        class RscText_3333: RscText
        {
            idc = 3333;
            text = "DYNAMIC CIVIL WAR";
            sizeEx = .1;
            style = ST_CENTER;
            x = -20 * GUI_GRID_W + GUI_GRID_X;
            y = -2 * GUI_GRID_H;
            w = 28 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;
        };

         class RscText_1002: RscText
        {
            idc = 1002;
            text = "Time of the day";
            x = -19 * GUI_GRID_W + GUI_GRID_X;
            y = 1 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class RscCombo_2100: RscCombo
        {
          idc = 2100;
          text = "Time of the day";
          x = -19 * GUI_GRID_W + GUI_GRID_X;
          y = 2 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Time day";
        };
         class RscText_1003: RscText
        {
            idc = 1003;
            text = "Weather";
            x = -19 * GUI_GRID_W + GUI_GRID_X;
            y = 4 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
         class RscCombo_2101: RscCombo
        {
          idc = 2101;
          text = "Weather";
          x = -19 * GUI_GRID_W + GUI_GRID_X;
          y = 5 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Time weather";
        };

        
     class RscText_1004: RscText
        {
            idc = 1004;
            text = "Enemy compound percentage";
            x = -19 * GUI_GRID_W + GUI_GRID_X;
            y = 7 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2102: RscCombo
        {
          idc = 2102;
          text = "Enemy compound percentage";
          x = -19 * GUI_GRID_W + GUI_GRID_X;
          y = 8 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Enemy compound percentage";
        };

        class RscText_1011: RscText
        {
            idc = 1011;
            text = "Friendly side";
            x = -19 * GUI_GRID_W + GUI_GRID_X;
            y = 10 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2111: RscCombo
        {
          idc = 2111;
          text = "Friendly side";
          x = -19 * GUI_GRID_W + GUI_GRID_X;
          y = 11 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Side";
        };

        class RscText_1005: RscText
        {
            idc = 1005;
            text = "Friendly faction";
            x = -19 * GUI_GRID_W + GUI_GRID_X;
            y = 13 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };

       class RscCombo_2103: RscCombo
        {
          idc = 2103;
          text = "Friendly faction";
          x = -19 * GUI_GRID_W + GUI_GRID_X;
          y = 14 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Faction";
        };


        
        class RscText_1015: RscText
        {
            idc = 1015;
            text = "Allied faction";
            x = -19 * GUI_GRID_W + GUI_GRID_X;
            y = 16 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };

       class RscCombo_2113: RscCombo
        {
          idc = 2113;
          text = "Allied faction";
          x = -19 * GUI_GRID_W + GUI_GRID_X;
          y = 17 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Allied faction";
        };


        class RscText_1006: RscText
        {
            idc = 1006;
            text = "Medevac AI system enabled";
            x = -3 * GUI_GRID_W + GUI_GRID_X;
            y = 16 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2104: RscCheckbox
        {
          idc = 2104;
          x = -5 * GUI_GRID_W + GUI_GRID_X;
          y = 16 * GUI_GRID_H + GUI_GRID_Y;
          w = 1 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Enable AI medevac system";
        };
        class RscText_1007: RscText
        {
            idc = 1007;
            text = "Respawn available";
            x = -3 * GUI_GRID_W + GUI_GRID_X;
            y = 17 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2105: RscCheckbox
        {
          idc = 2105;
          x = -5 * GUI_GRID_W + GUI_GRID_X;
          y = 17 * GUI_GRID_H + GUI_GRID_Y;
          w = 1 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Enable respawn";
        };

        class RscText_1008: RscText
        {
            idc = 1008;
            text = "Restricted arsenal";
            x = -3 * GUI_GRID_W + GUI_GRID_X;
            y = 18 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2106: RscCheckbox
        {
          idc = 2106;
          x = -5 * GUI_GRID_W + GUI_GRID_X;
          y = 18 * GUI_GRID_H + GUI_GRID_Y;
          w = 1 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Enable restricted arsenal";
        };


       class RscText_1009: RscText
        {
            idc = 1009;
            text = "Enemy side";
            x = -5 * GUI_GRID_W + GUI_GRID_X;
            y = 1 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2107: RscCombo
        {
          idc = 2107;
          text = "Enemy side";
          x = -5 * GUI_GRID_W + GUI_GRID_X;
          y = 2 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Side";
        };

       class RscText_1010: RscText
        {
            idc = 1010;
            text = "Enemy faction";
            x = -5 * GUI_GRID_W + GUI_GRID_X;
            y = 4 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2108: RscCombo
        {
          idc = 2108;
          text = "Enemy faction";
          x = -5 * GUI_GRID_W + GUI_GRID_X;
          y = 5 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Faction";
        };
       class RscText_1012: RscText
        {
            idc = 1012;
            text = "Civilian faction";
            x = -5 * GUI_GRID_W + GUI_GRID_X;
            y = 7 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2110: RscCombo
        {
          idc = 2110;
          text = "Civilian faction";
          x = -5 * GUI_GRID_W + GUI_GRID_X;
          y = 8 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Faction";
        };

        class RscText_1014: RscText
        {
            idc = 1014;
            text = "Number of respawn";
            x = -5 * GUI_GRID_W + GUI_GRID_X;
            y = 10 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2112: RscCombo
        {
          idc = 2112;
          text = "Number of respawn";
          x = -5 * GUI_GRID_W + GUI_GRID_X;
          y = 11 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Number of respawn";
        };


        class Button_Submit_1000: RscButton
        {
          idc = 2222;
          text = "Next (Loadout)";
          x = -19 * GUI_GRID_W + GUI_GRID_X;
          y = 22 * GUI_GRID_H + GUI_GRID_Y;
          w = 26 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          action = "[] call fnc_SaveAndGoToLoadoutDialog";
        };

        class RscButton_1601: RscButton
        {
          idc = 1601;
          text = "Choose insertion point"; //--- ToDo: Localize;
          x = -5 * GUI_GRID_W + GUI_GRID_X;
          y = 13 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 2 * GUI_GRID_H;
          action = "[] spawn fnc_ChooseLocation";
        };
        

        class test_map: RscMapControl
        {
          idc = 122;
          text = "#(argb,8,8,3)color(1,1,1,1)";
          x = -21 * GUI_GRID_W + GUI_GRID_X;
          y = -8 * GUI_GRID_H + GUI_GRID_Y;
          w = 80 * GUI_GRID_W;
          h = 40 * GUI_GRID_H;
        };
    };
};

