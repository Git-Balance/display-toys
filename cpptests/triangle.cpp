#include <iostream>
using namespace std;

int main()
{
    std::cout << "Hello World!" << endl;
    for (int x = 0; x < 5; x++)
    {
        for (int y = 0; y < x+1; y++)
        {
            std::cout << "*";
        }
        std::cout << endl;
    }
    return 0;
}

// TODO: figure out what is going on with other files, like triangle.obj, triangle.pdb, etc.