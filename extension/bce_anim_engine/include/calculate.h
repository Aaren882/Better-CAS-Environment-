#pragma once

#include <vector>

double calculateSpringOscillation(
	int _t,
	double mass,
	double frequencyResponse,
	double dampingRatio,
	double duration,
	double frameRate,
	double initialPosition,
	double initialVelocity);