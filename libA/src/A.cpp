#include <iostream>
#include <string>
using namespace std;


#include "A.h"
#include "Common.h"

void TestA(string s)
{
    string myS = s + "  ";
    cout << myS << __func__ << endl;
    TestCommon(myS);
}

void TestA1(void)
{
    cout << __func__ << endl;
}