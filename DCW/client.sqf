/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

if (isNull player) exitWith{false;};

//Default white list marker;
titleCut ["Mission loading...", "BLACK FADED", 999];

//Briefing
player createDiaryRecord ["Diary",["Keep a good reputation",
"The civilian in the sector would be very sensitive to the way you talk to them. Some of them are definitly hostiles to our intervention. You are free to take them in custody, that's a good point to track the potential insurgents in the region. You must avoid any mistakes, because it could have heavy consequences on the reputation of our troops in the sector. More you hurt them, more they might join the insurgents. If you are facing some difficulties, it is possible to convince some of them to join your team (it would costs you some credits...). Keep in mind the rules of engagements and it would be alright."]];

//Briefing
player createDiaryRecord ["Diary",["How to gather supports ? Side operations",
"To accomplish these tasks, you would need resources from the HQ. They could provide you all the supports you need (Choppers, CAS, ammo drops, extractions...). But you must prove them the value of your action down there. You all know that what we're doing here is not very popular, even in the high command...<br/>That's why, as side objectives, you have to bring back peace in the region. There is a few sides missions you can accomplish :<br/><br/> Clear IEDs on road<br/>Liberate hostages<br/>Destroy mortars<br/>Destroy weapon caches<br/>Desmantle outposts<br/>Eliminate snipers team<br/><br/><br/>You can ask civilian to get some more intels about these sides operations.</br>Your insertion point is already secured and located <marker name='marker_base'>uphill Zaros</marker>. Good luck soldier !"]];

player createDiaryRecord ["Diary",["How to locate the commander ?",
"For this purpose, you have two options : Find and interrogate enemy officers located by our drones. They are oftenly running with mecanized infantry which is very easy to track with our sattelites and drones. The HQ will get you in touch if they've found one.<br/><br/>Interrogate the civilian chief located in large cities, talk to civilians, ask them informations about local chief. If you keep a good reputation, they would help us.<br/>Here is a photography of mecanized infantry with leutnant : <img image='images\leutnant.jpg' width='300' height='193'/>"]];

player createDiaryRecord ["Diary",["Main objective : kill the commander",
"Dynamic Civil War<br/><br/>
In this singleplayer scenario, you have one major objective : assassinate the enemy general. We kow that it would considerably change the situation in this region which is ravaged by war. At this point, we have no intel on his exact location. He is probably hidden in mountains or forests, wandering from place to place very often far from the conflicts areas. Firstly, you must get intel about his approximate position.<br/><img image='images\target.jpg' width='302' height='190'/><br/><br/>"]];

//[] execVM "intro.sqf"; 

//Default white list marker;
[worldName, "Prepare for action..."] call BIS_fnc_infoText;
titleCut ["Mission loading...", "BLACK IN", 5];
"dynamicBlur" ppEffectEnable true;   
"dynamicBlur" ppEffectAdjust [6];   
"dynamicBlur" ppEffectCommit 0;     
"dynamicBlur" ppEffectAdjust [0.0];  
"dynamicBlur" ppEffectCommit 5;  

// init user respawn loop
[getMarkerPos "marker_base", player] spawn fnc_respawn; //Respawn loop

