#pragma once

#include <string>
#include <map>
#include "..\include\calculate.h"

class AnimHandler
{
private:
	std::map<std::string, const SpringAnim *> AnimMap;

public:
	AnimHandler();

	const SpringAnim *Add(std::string name,
											 double mass,
											 double dampingRatio,
											 double response,
											 double duration,
											 double frameRate,
											 double initialPosition,
											 double initialVelocity);
	const int Add(const SpringAnim &animObj);
	const SpringAnim *const Get(std::string name);
};