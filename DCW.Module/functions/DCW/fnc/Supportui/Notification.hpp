class CfgCommunicationMenu
{
	class Attack;
	class Medevac: Attack
	{
		text = "Medevac and reinforcement";
		expression = "MEDEVAC_State = ""map"";";
		icon = "\a3\ui_f\data\map\markers\nato\b_med.paa";
		removeAfterExpressionCall = 1;
	};

	class TransportParadrop
    {
        text = "Transport paradrop"; // Text displayed in the menu and in a notification
        submenu = "#USER:TRANSPORTPARADROP_MENU"; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "player call DCW_fnc_TranportParadrop"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
       // removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };
};
