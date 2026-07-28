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
		double initialVelocity,
		double a,
		double b,
		double c,
		double d
	)
	: name(name), mass(mass), frequencyResponse(response * (frameRate * duration)), dampingRatio(dampingRatio), initialPosition(initialPosition), initialVelocity(initialVelocity), a(a), b(b), c(c), d(d)
{
	
}

std::string SpringAnim::getName() const { return name; }
std::string SpringAnim::getParams() const {
	std::stringstream ss;
	ss << "mass :" << mass << " ";
	ss << "dampingRatio :" << dampingRatio << " ";
	ss << "frequencyResponse :" << frequencyResponse << " ";
	ss << "initialPosition :" << initialPosition << " ";
	ss << "initialVelocity :" << initialVelocity << " ";
	ss << "a :" << a << " ";
	ss << "b :" << b << " ";
	ss << "c :" << c << " ";
	ss << "d :" << d;
	return ss.str();
}

//- DOING LINEAR INTERPOLATION
double SpringAnim::calculateSpringOscillation(double _t) const
{
	// Calculate relative displacement
	// C++ std::sin/cos use radians natively, so no degree conversion is needed
	double currentPos = std::exp(-a * _t) * (c * std::sin(b * _t) + initialPosition * std::cos(b * _t));
	double result = currentPos - initialPosition;

	if (std::isnan(result))
		throw "\"result\" is \"nan\"";

	// return frames;
	return result;
}