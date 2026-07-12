#include <vector>
#include <cmath>
#include <numbers>

/*
	IN GAME TEST AVG SPEED (10000/10000) :
	- SQF COMMAND : 0.0130 ms
	- EXTENSION : 0.0147 ms (SLOWER)
*/

double calculateSpringOscillation(
	int _t,
	double mass,
	double frequencyResponse,
	double dampingRatio,
	double duration,
	double frameRate,
	double initialPosition,
	double initialVelocity)
{
	// std::vector<double> frames;

	double arange = duration * frameRate;

	// Calculate physical properties
	double stiffness = std::pow((2.0 * std::numbers::pi) / frequencyResponse, 2) * mass;
	double undampedNaturalFrequency = std::sqrt(stiffness / mass);
	double dampedNaturalFrequency = undampedNaturalFrequency * std::sqrt(std::abs(1.0 - std::pow(dampingRatio, 2)));

	// Set up motion equation constants
	double a = undampedNaturalFrequency * dampingRatio;
	double b = dampedNaturalFrequency;

	// #NOTE - If dampingRatio >= 1.0, b will be 0, causing division by zero here.
	// This code assumes an strictly under-damped system (dampingRatio < 1.0).
	double c = (initialVelocity + a * initialPosition) / b;
	double d = initialPosition;

	double maxT = 1.5 * arange;

	// Calculate relative displacement
	// C++ std::sin/cos use radians natively, so no degree conversion is needed
	double currentPos = std::exp(-a * _t) * (c * std::sin(b * _t) + d * std::cos(b * _t));
	double result = currentPos - initialPosition;

	// return frames;
	return result;
}