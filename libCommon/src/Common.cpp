#include <iostream>
#include "Common.h"

using namespace std;

void Log(const char* msg)
{
    cout << __func__ << ": " << msg << endl;
}