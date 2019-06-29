/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

 params["_unit"];
 if (!isNull player) then {
    _unit doWatch player;
};

if (!stopped _unit) then {
    _unit stop true;
};

sleep .4;
_anim = "";
 if(random 1 < .33)then{
       _anim = "Acts_JetsMarshallingClear_in";
        sleep 1.49;
       _anim = "Acts_JetsMarshallingClear_loop";
        sleep 10;
       _anim = "Acts_JetsMarshallingClear_out";
        sleep 1.49;
    }else{
        if(random 1 < .5)then{
           _anim = "Acts_JetsMarshallingEmergencyStop_in";
            sleep .866;
           _anim = "Acts_JetsMarshallingEmergencyStop_loop";
            sleep 10;
           _anim = "Acts_JetsMarshallingEmergencyStop_out";
            sleep .880;
        }else{
              if(random 1 < .5)then{
               _anim = "Acts_JetsMarshallingEmergencyStop_in";
                sleep .866;
               _anim = "Acts_JetsMarshallingEmergencyStop_loop";
                sleep 10;
               _anim = "Acts_JetsMarshallingEmergencyStop_out";
                sleep .880;
            }else{
               _anim = "Acts_JetsMarshallingEnginesOff_in";
                sleep .866;
               _anim = "Acts_JetsMarshallingEnginesOff_loop";
                sleep 10;
               _anim = "Acts_JetsMarshallingEnginesOff_out";
                sleep .866;
            };
        };
    };

[_unit,_anim] remoteExec["switchMove"];

if (stopped _unit) then {
    _unit stop false;
};