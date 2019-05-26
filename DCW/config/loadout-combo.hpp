


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
    movingenable = false;
    duration = 10e10;

    class Controls
    {


        class RscText_3333: RscText
        {
            idc = 3333;
            text = "DYNAMIC CIVIL WAR";
            sizeEx = .1;
            style = ST_CENTER;
            x = 4 * GUI_GRID_W + GUI_GRID_X;
            y = -4 * GUI_GRID_H;
            w = 28 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;
        };

       class RscText_4444: RscText
        {
            idc = 4444;
            text = "";
            sizeEx = .05;
            style = ST_CENTER;
            x = -11 * GUI_GRID_W + GUI_GRID_X;
            y = 28 * GUI_GRID_H;
            w = 28 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };

        class ICE_BUTTON_1000: RscButton
        {
          idc = 1000;
          text = "OK";
          x = 26 * GUI_GRID_W + GUI_GRID_X;
          y = 30 * GUI_GRID_H + GUI_GRID_Y;
          w = 26 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          action = "[] call fnc_SaveAndCloseConfigDialog";
        };

        
        class ICE_BUTTON_1001: RscButton
        {
          idc = 1001;
          text = "Previous unit";
          x = -19 * GUI_GRID_W + GUI_GRID_X;
          y = 30 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          action = "[""prev""] call fnc_switchUnit;";
        };

        
        class ICE_BUTTON_1003: RscButton
        {
          idc = 1002;
          text = "Edit loadout";
          x = -7 * GUI_GRID_W + GUI_GRID_X;
          y = 30 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          action = "[] call fnc_editloadout;";
        };

        class ICE_BUTTON_1002: RscButton
        {
          idc = 1003;
          text = "Next unit";
          x = 5 * GUI_GRID_W + GUI_GRID_X;
          y = 30 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          action = "[""next""] call fnc_switchUnit;";
        };



    };
};

