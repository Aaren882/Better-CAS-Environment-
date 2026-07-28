#include <string>
#include <map>
#include <cmath>
#include "..\include\calculate.h"
#include "..\include\animHandler.h"

AnimHandler::AnimHandler() {}

const SpringAnim *AnimHandler::Add(
		std::string name,
		double mass,
		double dampingRatio,
		double response,
		double duration,
		double frameRate,
		double initialPosition,
		double initialVelocity)
{
	auto origin = AnimMap.find(name);

	// Calculate physical properties
	double frequencyResponse(response * (frameRate * duration));
	double stiffness = std::pow((2.0 * std::numbers::pi) / frequencyResponse, 2) * mass;

	double undampedNaturalFrequency = std::sqrt(stiffness / mass);
	if (std::isnan(undampedNaturalFrequency))
		throw "\"undampedNaturalFrequency\" is \"nan\"";

	double dampedNaturalFrequency = undampedNaturalFrequency * std::sqrt(std::abs(1.0 - std::pow(dampingRatio, 2)));
	if (std::isnan(dampedNaturalFrequency))
		throw "\"dampedNaturalFrequency\" is \"nan\"";

	// Set up motion equation constants
	double a = undampedNaturalFrequency * dampingRatio;
	double b = dampedNaturalFrequency;

	// #NOTE - If dampingRatio >= 1.0, b will be 0, causing division by zero here.
	// This code assumes an strictly under-damped system (dampingRatio < 1.0).
	double c = (initialVelocity + a * initialPosition) / b;
	double d = initialPosition;

	auto animObj = new SpringAnim(
			name, mass, dampingRatio, response, duration, frameRate, initialPosition, initialVelocity, a, b, c, d);

	//- If object is exist
	if (origin != AnimMap.end())
	{
		delete origin->second;
		origin->second = animObj;
	}
	else //- Create key and insert
	{
		AnimMap[name] = animObj;
	}

	return animObj;
}

const int AnimHandler::Add(const SpringAnim &animObj)
{
	auto origin = AnimMap.find(animObj.getName());

	//- If object is exist
	if (origin != AnimMap.end())
	{
		origin->second = &animObj;
	}
	else //- Create key and insert
	{
		AnimMap[animObj.getName()] = &animObj;
	}

	return AnimMap.size();
}
const SpringAnim *const AnimHandler::Get(std::string name)
{
	auto origin = AnimMap.find(name);
	if (origin == AnimMap.end())
	{
		throw "The AnimObj is not exist.";
	}
	auto obj = origin->second;

	if (obj == nullptr)
	{
		throw "The AnimObj '" + name + "' exists but points to nullptr.";
	}

	return obj;
}