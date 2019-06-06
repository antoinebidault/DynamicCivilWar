 class CfgPatches
 {
	class Markers
	{
		units[] = {};
		weapons[] = {};
		requiredVersion=1.00;
	};
 };

 class CfgMarkerClasses
{
	class CustomMarkers
	{
		displayName = "This is a marker";
	};
};


 class CfgMarkers
 {
    class DCW_humanitary
	{
		name="humanitary";
		icon="\DCW\icons\humanitary.paa";
		color[]={1,1,1,1};
		size=32;
		shadow = 0;
		scope = 2;
		markerClass = "CustomMarkers";
	};
	class DCW_secured
	{
		name="secured";
		icon="\DCW\icons\secured.paa";
		color[]={1,1,1,1};
		size=32;
		shadow = 0;
		scope = 2;
		markerClass = "CustomMarkers";
	};
	class DCW_bastion
	{
		name="Bastion";
		icon="\DCW\icons\bastion.paa";
		color[]={1,1,1,1};
		size=32;
		shadow = 0;
		scope = 2;
		markerClass = "CustomMarkers";
	};
	class DCW_default
	{
		name="neutral";
		icon="\DCW\icons\default.paa";
		color[]={1,1,1,1};
		size=32;
		shadow = 0;
		scope = 2;
		markerClass = "CustomMarkers";
	};
	class DCW_massacred
	{
		name="Death";
		icon="\DCW\icons\massacred.paa";
		color[]={1,1,1,1};
		size=32;
		shadow = 0;
		scope = 2;
		markerClass = "CustomMarkers";
	};
 };