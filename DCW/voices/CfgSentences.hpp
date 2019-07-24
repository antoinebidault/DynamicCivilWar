
class CfgSentences
{
	class DCW
	{
		class LocalChief
		{
			file = "localchief\CfgSentences.bikb";
			#include "localchief\CfgSentences.bikb" // avoids a double declaration
		};

        class Civilian
		{
			file = "Civilian\CfgSentences.bikb";
			#include "Civilian\CfgSentences.bikb" // avoids a double declaration
		};

         class Medical
		{
			file = "Medical\CfgSentences.bikb";
			#include "Medical\CfgSentences.bikb" // avoids a double declaration
		};
            
        class Support
		{
			file = "Support\CfgSentences.bikb";
			#include "Support\CfgSentences.bikb" // avoids a double declaration
		};

        class Objective
		{
			file = "Objective\CfgSentences.bikb";
			#include "Objective\CfgSentences.bikb" // avoids a double declaration
		};
	};
};