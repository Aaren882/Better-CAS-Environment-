#pragma once

#include <string>
#include <map>
#include "..\include\calculate.h"

class AnimHandler
{
private:
	std::map<const std::string, const SpringAnim *> AnimMap;

public:
	AnimHandler();

	int Add(const SpringAnim *animObj);
	const SpringAnim *const Get(std::string name);
};