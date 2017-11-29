class RscStatusBar
{
        idd = -1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['RscStatusBar', _this select 0];";
        fadein = 0;
        fadeout = 0;
        movingEnable = 0;
        objects[] = {};

      
 
        class controls
        {
                class statusBarText
                {
                        idc = 55554;
                        x = "safezoneX + safezoneW - 1.90";
                        y = "safezoneY + safezoneH - 0.063";
                        w = 1.38;
                        h = 0.06;
                        shadow = 2;
                        size = 0.030;
                        type = 13;
                         style = 2;
                        text = "";
 
                        class Attributes
                        {
                                align="center";
                                color = "#ffffff";
                        };
                };
        };
};