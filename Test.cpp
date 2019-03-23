#include <iostream>
#include <string>

using namespace std;

#include "A.h"

int main(void)
{
    string myS = "";
    cout << myS << __func__ << endl;
    TestA(myS);
}