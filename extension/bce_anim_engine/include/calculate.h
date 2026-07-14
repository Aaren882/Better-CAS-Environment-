#pragma once

#include <vector>
#include <string>

class SpringAnim
{
private:
	std::string name;
	struct
	{
		double mass
		,frequencyResponse
		,dampingRatio
		,initialPosition
		,initialVelocity;
	};

public:
	SpringAnim(
			std::string name,
			double mass,
			double dampingRatio,
			double response,
			double duration,
			double frameRate,
			double initialPosition,
			double initialVelocity);
			
	std::string getName() const;
	std::string getParams() const;
	double calculateSpringOscillation(double _t) const;
};