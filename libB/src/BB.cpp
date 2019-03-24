#include <iostream>
#include <string>
using namespace std;


#include "BB.h"
#include "Common.h"

void TestBB(string s)
{
    string myS = s + "  ";
    cout << myS << __func__ << endl;
    TestCommon(myS);
}