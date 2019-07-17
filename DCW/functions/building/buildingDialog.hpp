
class building_Dialog
{
    idd = 9999;
    movingEnabled = true;

    class controls
    {
        class building_rscPicture: RscPicture
        {
            idc = 1200;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,0.8)";
            x = 0.3 * safezoneW + safezoneX;
            y = 0.25 * safezoneH + safezoneY;
            w = 0.4 * safezoneW;
            h =  0.55 * safezoneH;
        };

        class building_buildList: RscListbox
        {
            idc = 1500;
            x = 0.31 * safezoneW + safezoneX;
            y = 0.27 * safezoneH + safezoneY;
            w = 0.370 * safezoneW;
            h = 0.43 * safezoneH;
            rowHeight = .12;
        };
		
        class building_okButton: RscButton
        {
            idc = 1600;
            text = "Buy object";
            x = 0.309 * safezoneW + safezoneX;
            y = 0.70 * safezoneH + safezoneY;
            w = 0.370 * safezoneW;
            h = 0.04 * safezoneH;
            action = "[] spawn DCW_fnc_affordObject";
        };
		
        class building_cancelButton: RscButton
        {
            idc = 1601;
            text = "Cancel";
            x = 0.309 * safezoneW + safezoneX;
            y = 0.75 * safezoneH + safezoneY;
            w = 0.370 * safezoneW;
            h = 0.04 * safezoneH;
            action = "CloseDialog 0;";
        };

  };
};