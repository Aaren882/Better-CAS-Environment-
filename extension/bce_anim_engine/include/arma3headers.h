#pragma once

#include <stddef.h>

#if defined(_MSC_VER)
#define ARMA_EXPORT __declspec(dllexport)
#define ARMA_CALL __stdcall
#elif defined(__GNUC__)
#define ARMA_EXPORT __attribute__((dllexport))
#define ARMA_CALL __attribute__((stdcall))
#else
#define ARMA_EXPORT
#define ARMA_CALL
#endif

extern "C"
{
	ARMA_EXPORT void ARMA_CALL RVExtension(char *output, unsigned int outputSize, const char *function);

	ARMA_EXPORT int ARMA_CALL RVExtensionArgs(char *output, unsigned int outputSize, const char *function, const char **argv, unsigned int argc);

	ARMA_EXPORT void ARMA_CALL RVExtensionVersion(char *output, unsigned int outputSize);
}
