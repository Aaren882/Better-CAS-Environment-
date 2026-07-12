#include <string>
#include <cstring>
// #include <sstream>
#include "..\include\arma3headers.h"
#include "..\include\calculate.h"

void RVExtension(char *output, unsigned int outputSize, const char *function)
{
	std::strncpy(output, function, outputSize - 1);
}

int RVExtensionArgs(char *output, unsigned int outputSize, const char *function, const char **argv, unsigned int argc)
{
	double params[8];
	for (int i = 0; i < argc; i++)
	{
		char *endptr;
		double value = std::strtod(argv[i], &endptr);
		params[i] = value;
	}
	
	auto result = calculateSpringOscillation(
		params[0],
		params[1],
		params[2],
		params[3],
		params[4],
		params[5],
		params[6],
		params[7]
	);

	// std::string sfunction = function;
	std::strncpy(output, (std::to_string(result)).c_str(), outputSize - 1);

	return 0;
}

void RVExtensionVersion(char *output, unsigned int outputSize)
{
	std::strncpy(output, "Test-Extension v1.0", outputSize - 1);
}
