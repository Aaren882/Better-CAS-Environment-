#include <string>
#include <cstring>
#include <sstream>
#include <bit>
#include "..\include\arma3headers.h"
#include "..\include\calculate.h"
#include "..\include\animHandler.h"

static auto animHandler = new AnimHandler();

void RVExtension(char *output, unsigned int outputSize, const char *function)
{
	std::strncpy(output, function, outputSize - 1);
}

int RVExtensionArgs(char *output, unsigned int outputSize, const char *function, const char **argv, unsigned int argc)
{
	std::string s_output = "";
	std::string s_function = function;

	if (s_function == "register") //- Add new 
	{
		std::string animName = argv[0];

		double params[7];
		for (int i = 1; i < argc; i++)
		{
			double value = std::stod(argv[i]);
			params[i - 1] = value;
		}
		
		auto animObj = new SpringAnim(animName, params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
		auto handlerSize = animHandler->Add(animObj);
		
		//- Return
		// s_output = "New \"" + animObj->getName() + "\" has been added (Total " + std::to_string(handlerSize) + ")";
		s_output = "New " + animObj->getName() + ": " + animObj->getParams();
	}
	else if (s_function == "calculate") //- Calculation
	{
		std::string animName = argv[0];
		double _t = std::stod(argv[1]);

		//- Do interpolation
		try
		{
			auto animObj = animHandler->Get(animName);
			auto result = animObj->calculateSpringOscillation(_t);

			//- Return
			s_output = std::to_string(result);
		}
		catch(const std::exception& e)
		{
			//- Return Error
			s_output = e.what();
		}
	}
	else
	{
		//- Return
		s_output = "No Function Found !!";
	}

	//- Print out the "s_output" to Arma3
	std::strncpy(output, s_output.c_str(), outputSize - 1);
	return 0;
}

void RVExtensionVersion(char *output, unsigned int outputSize)
{
	std::strncpy(output, "Test-Extension v1.0", outputSize - 1);
}
