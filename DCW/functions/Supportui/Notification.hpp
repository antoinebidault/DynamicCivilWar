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
        expression = "player call DCW_fnc_tranportParadrop"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
       // removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };

    	class OutpostBuildingKit
    {
        text = "Outpost building kit"; // Text displayed in the menu and in a notification
        expression = "[] spawn DCW_fnc_buildingKit"; // Code executed upon activation
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\defend_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1"; // Simple expression condition for enabling the item
       // removeAfterExpressionCall = 1; // 1 to remove the item after calling
    };
};


class CfgNotifications
{

  class Default
  {
    title = ""; // Tile displayed as text on black background. Filled by arguments.
    iconPicture = ""; // Small icon displayed in left part. Colored by "color", filled by arguments.
    iconText = ""; // Short text displayed over the icon. Colored by "color", filled by arguments.
    description = ""; // Brief description displayed as structured text. Colored by "color", filled by arguments.
    color[] = {1,1,1,1}; // Icon and text color
    duration = 5; // How many seconds will the notification be displayed
    priority = 0; // Priority; higher number = more important; tasks in queue are selected by priority
    difficulty[] = {}; // Required difficulty settings. All listed difficulties has to be enabled
  };
 
  // Examples
  class TaskAssigned
  {
    title = "TASK ASSIGNED";
    iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa";
    description = "%1";
    priority = 7;
  };

  //Score
  class ScoreAdded
  {
    title = "Score update";
    iconText = "%3%2";
    description = "%1";
    color[] = {1,1,1,1};
    priority = 7;
  };
};  