#include <iostream>
#include <string>
using namespace std;


#include "Common.h"
#include "A.h"
#include "B.h"

void TestCombine(string s)
{
    string myS = s + "  ";
    cout << myS << __func__ << endl;
    TestCommon(myS);
    TestA(myS);
    TestB(myS);
}