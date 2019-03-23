#include <iostream>
#include <string>
using namespace std;

#include "Common.h"

void TestCommon(string s)
{
    string myS = s + "  ";
    cout << myS << __func__ << endl;
}