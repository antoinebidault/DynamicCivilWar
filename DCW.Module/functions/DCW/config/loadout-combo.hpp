


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

class LOADOUT_DIALOG
{
    idd = 5002;
    movingenable = true;
    duration = 10e10;

    class Controls
    {

        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT START (by dugland, v1.063, #Vagiwy)
        ////////////////////////////////////////////////////////

        class RscText_3333: RscText
        {
          idc = 3333;
          style = 2;
          sizeEx = .1;
          text = "DYNAMIC CIVIL WAR"; //--- ToDo: Localize;
          x = 3.5 * GUI_GRID_W + GUI_GRID_X;
          y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
          w = 29 * GUI_GRID_W;
          h = 2 * GUI_GRID_H;
        };
        class RscText_4444: RscText
        {
          idc = 4444;
          style = 2;
          x = 6.35 * GUI_GRID_W + GUI_GRID_X;
          y = 18.08 * GUI_GRID_H + GUI_GRID_Y;
          w = 27.1515 * GUI_GRID_W;
          h = 1.29462 * GUI_GRID_H;
        };
        class ICE_BUTTON_1000: RscButton
        {
          idc = 1000;
          action = "[] call DCW_fnc_SaveAndCloseConfigDialog";
          text = "Start mission"; //--- ToDo: Localize;
          x = 7 * GUI_GRID_W + GUI_GRID_X;
          y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
          w = 26 * GUI_GRID_W;
          h = 1.5 * GUI_GRID_H;
        };
        class ICE_BUTTON_1001: RscButton
        {
          idc = 1001;
          action = "[""prev""] call DCW_fnc_switchUnit;";
          text = "Previous unit"; //--- ToDo: Localize;
          x = 0 * GUI_GRID_W + GUI_GRID_X;
          y = 20 * GUI_GRID_H + GUI_GRID_Y;
          w = 9 * GUI_GRID_W;
          h = 2 * GUI_GRID_H;
        };
        class ICE_BUTTON_1003: RscButton
        {
          idc = 1002;
          action = "[] call DCW_fnc_editloadout;";

          text = "Edit loadout"; //--- ToDo: Localize;
          x = 12 * GUI_GRID_W + GUI_GRID_X;
          y = 20 * GUI_GRID_H + GUI_GRID_Y;
          w = 16 * GUI_GRID_W;
          h = 2 * GUI_GRID_H;
        };
        class ICE_BUTTON_1002: RscButton
        {
          idc = 1003;
          action = "[""next""] call DCW_fnc_switchUnit;";

          text = "Next unit"; //--- ToDo: Localize;
          x = 31 * GUI_GRID_W + GUI_GRID_X;
          y = 20 * GUI_GRID_H + GUI_GRID_Y;
          w = 9.5 * GUI_GRID_W;
          h = 2 * GUI_GRID_H;
        };
        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT END
        ////////////////////////////////////////////////////////

    };
};

