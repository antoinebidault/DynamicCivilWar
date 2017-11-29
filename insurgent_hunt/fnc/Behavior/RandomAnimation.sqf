/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

 params["_unit"];
_unit doWatch player;
_unit disableAI "MOVE";
sleep .4;
 if(random 1 < .33)then{
        _unit switchMove "Acts_JetsMarshallingClear_in";
        sleep 1.49;
        _unit switchMove "Acts_JetsMarshallingClear_loop";
        sleep 10;
        _unit switchMove "Acts_JetsMarshallingClear_out";
        sleep 1.49;
    }else{
        if(random 1 < .5)then{
            _unit switchMove "Acts_JetsMarshallingEmergencyStop_in";
            sleep .866;
            _unit switchMove "Acts_JetsMarshallingEmergencyStop_loop";
            sleep 10;
            _unit switchMove "Acts_JetsMarshallingEmergencyStop_out";
            sleep .880;
        }else{
              if(random 1 < .5)then{
                _unit switchMove "Acts_JetsMarshallingEmergencyStop_in";
                sleep .866;
                _unit switchMove "Acts_JetsMarshallingEmergencyStop_loop";
                sleep 10;
                _unit switchMove "Acts_JetsMarshallingEmergencyStop_out";
                sleep .880;
            }else{
                _unit switchMove "Acts_JetsMarshallingEnginesOff_in";
                sleep .866;
                _unit switchMove "Acts_JetsMarshallingEnginesOff_loop";
                sleep 10;
                _unit switchMove "Acts_JetsMarshallingEnginesOff_out";
                sleep .866;
            };
        };
    };

_unit enableAI "MOVE";