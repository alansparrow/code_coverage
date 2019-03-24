#include <iostream>
#include <string>

using namespace std;

#include "Common.h"
#include "A.h"
#include "B.h"
#include "Combine.h"

int main(void)
{
    string myS = "";
    cout << myS << __func__ << endl;
    //TestCommon(myS);
    TestA(myS);
    //TestB(myS);
    //TestCombine(myS);
}