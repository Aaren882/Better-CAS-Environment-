#include <string>
#include <sstream>
#include <vector>
#include <cmath>
#include <numbers>
#include "..\include\calculate.h"

/*
	IN GAME TEST AVG SPEED (10000/10000) :
	- SQF COMMAND : 0.0130 ms
	- EXTENSION : 0.0075 ms (BETTER)
*/

SpringAnim::SpringAnim(
		std::string name,
		double mass,
		double dampingRatio,
		double response,
		double duration,
		double frameRate,
		double initialPosition,
		double initialVelocity)
		: name(name), mass(mass), dampingRatio(dampingRatio), initialPosition(initialPosition), initialVelocity(initialVelocity)
{
	this->frequencyResponse = response * (frameRate * duration);
}

std::string SpringAnim::getName() const { return name; }
std::string SpringAnim::getParams() const {
	std::stringstream ss;
	ss << "mass :" << mass << " ";
	ss << "dampingRatio :" << dampingRatio << " ";
	ss << "frequencyResponse :" << frequencyResponse << " ";
	ss << "initialPosition :" << initialPosition << " ";
	ss << "initialVelocity :" << initialVelocity;
	return ss.str();
}

//- DOING LINEAR INTERPOLATION
double SpringAnim::calculateSpringOscillation(double _t) const
{
	// Calculate physical properties
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

	// Calculate relative displacement
	// C++ std::sin/cos use radians natively, so no degree conversion is needed
	double currentPos = std::exp(-a * _t) * (c * std::sin(b * _t) + d * std::cos(b * _t));
	double result = currentPos - initialPosition;

	if (std::isnan(result))
		throw "\"result\" is \"nan\"";

	// return frames;
	return result;
}