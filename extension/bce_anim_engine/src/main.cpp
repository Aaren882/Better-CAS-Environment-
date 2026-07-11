#include <string>
#include <cstring>
#include <sstream>
#include "..\include\arma3headers.h"

void RVExtension(char *output, unsigned int outputSize, const char *function)
{
	std::strncpy(output, function, outputSize - 1);
}

int RVExtensionArgs(char *output, unsigned int outputSize, const char *function, const char **argv, unsigned int argc)
{
	std::stringstream sstream;
	for (int i = 0; i < argc; i++)
	{
		sstream << argv[i];
	}
	std::strncpy(output, sstream.str().c_str(), outputSize - 1);
	return 0;
}

void RVExtensionVersion(char *output, unsigned int outputSize)
{
	std::strncpy(output, "Test-Extension v1.0", outputSize - 1);
}
