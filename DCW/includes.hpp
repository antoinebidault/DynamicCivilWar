
//--------------------------------------------------------------
//---------------------    MUSICS    ---------------------------
//--------------------------------------------------------------

class CfgMusic
{
  	tracks[]=
  	{
      		seal
  	};
    class seal
    {
          name = "seal";
          sound[] = {"\music\seal.ogg", 1, 1.0};
    };
     class axe
    {
          name = "axe";
          sound[] = {"\music\axe.ogg", 1, 1.0};
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

#include "config\mission-parameters.hpp"
#include "supportui\Defines.hpp"
#include "supportui\buySupports.hpp"
#include "config\respawn.hpp"
#include "config\config-combo.hpp"
#include "config\loadout-combo.hpp"
#include "medevac\support.hpp"
//#include "icons\icons.hpp"

class RscTitles {
  #include "supportui\statusBar.hpp"
};