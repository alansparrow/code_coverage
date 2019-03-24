#include <iostream>
#include <string>

using namespace std;

#include "A.h"
#include "B.h"

int main(void)
{
    string myS = "";
    cout << myS << __func__ << endl;
    TestA(myS);
    //TestB(myS);
}