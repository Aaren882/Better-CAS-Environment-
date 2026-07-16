#include <string>
#include <map>
#include "..\include\calculate.h"
#include "..\include\animHandler.h"

AnimHandler::AnimHandler() {}

int AnimHandler::Add(const SpringAnim *animObj)
{
	auto origin = AnimMap.find(animObj->getName());
	
	//- If object is exist
	if (origin != AnimMap.end())
	{
		origin->second = animObj;
	}
	else //- Create key and insert
	{
		AnimMap[animObj->getName()] = animObj;
	}

	return AnimMap.size();
}
const SpringAnim *const AnimHandler::Get(std::string name) 
{
	return AnimMap[name];
}