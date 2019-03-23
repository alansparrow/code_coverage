#include <iostream>
#include <string>
using namespace std;


#include "B.h"
#include "Common.h"

void TestB(string s)
{
    string myS = s + "  ";
    cout << myS << __func__ << endl;
    TestCommon(myS);
}