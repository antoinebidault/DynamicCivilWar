class CfgPatches
{
	class DCW_Module
	{
		units[] = {"DCW_ModuleInit"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F"};
	};
};

class CfgFunctions
{
	class DCW
	{
		class Module
		{
			file = "\DCW_Module\functions";
			class init{};
		};
	};
};

class CfgFactionClasses
{
	class NO_CATEGORY;
	class DCW_Category: NO_CATEGORY
	{
		displayName = "Dynamic Civil War";
	};
};

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit; // Default edit box (i.e., text input field)
			class Combo; // Default combo box (i.e., drop-down menu)
			class Checkbox; // Default checkbox (returned value is Bool)
			class CheckboxNumber; // Default checkbox (returned value is Number)
			class ModuleDescription; // Module description
			class Units; // Selection of units on which the module is applied
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
		};
	};

	class DCW_ModuleInit: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "DCW Init"; // Name displayed in the menu
		// icon = "\myTag_addonName\data\iconNuke_ca.paa"; // Map icon. Delete this entry to use the default icon
		category = "DCW_Category";

		// Name of function triggered once conditions are met
		function = "DCW_fnc_init";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 1;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 1;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		curatorInfoType = "RscDisplayAttributeModuleNuke";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
            /*
			// Arguments shared by specific module type (have to be mentioned in order to be present)
			class Units: Units
			{
				property = "myTag_ModuleNuke_Units";
			};
			// Module specific arguments
			class Yield: Combo
  			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "myTag_ModuleNuke_Yield";
				displayName = "Nuclear weapon yield"; // Argument label
				tooltip = "How strong will the explosion be"; // Tooltip description
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "50"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class 50Mt	{name = "50 megatons";	value = 50;}; // Listbox item
					class 100Mt	{name = "100 megatons"; value = 100;};
				};
			};
			class Name: Edit
  			{
				displayName = "Name";
				tooltip = "Name of the nuclear device";
				// Default text filled in the input box
				// Because it's an expression, to return a String one must have a string within a string
				defaultValue = """Tsar Bomba""";
			};
             */
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Dynamic Civil War startup script. This requires only a group of friendly units placed in a flat area and a marker named marker_base"; // Short description, will be formatted as structured text
			sync[] = {"LocationArea_F"}; // Array of synced entities (can contain base classes)
	 
			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"First line",
					"Second line"
				};
				position = 1; // Position is taken into effect
				direction = 1; // Direction is taken into effect
				optional = 1; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
				synced[] = {"BLUFORunit","AnyBrain"}; // Pre-define entities like "AnyBrain" can be used. See the list below
			};
			class BLUFORunit
			{
				description = "Short description";
				displayName = "Any BLUFOR unit"; // Custom name
				icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
				side = 1; // Custom side (will determine icon color)
			};
		};
	};
};

#include "functions\DCW\includes.hpp"
