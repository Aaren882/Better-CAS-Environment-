#pragma once

#include <vector>
#include <string>

class SpringAnim
{
private:
	std::string name;
	struct
	{
		double mass = 0.0,
			frequencyResponse = 0.0,
			dampingRatio = 0.0,
			initialPosition = 0.0,
			initialVelocity = 0.0;
		double a = 0.0, b = 0.0, c = 0.0, d = 0.0;
	};
	
public:
	/* SpringAnim(
			std::string name,
			double mass,
			double dampingRatio,
			double response,
			double duration,
			double frameRate,
			double initialPosition,
			double initialVelocity); */
	SpringAnim(
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
	);

	std::string getName() const;
	std::string getParams() const;
	double calculateSpringOscillation(double _t) const;
};