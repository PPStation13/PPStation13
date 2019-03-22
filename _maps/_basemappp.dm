//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\generic\City_of_Cogs.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\PPStation\ppstation.dmm"
		#include "map_files\PubbyStation\PubbyStation.dmm"
		#include "map_files\HippieStation\hippiestation.dmm"

		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif