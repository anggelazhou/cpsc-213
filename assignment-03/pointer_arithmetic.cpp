#include <iostream>
using namespace std;

int main() {
    int a[10] = { 45, 45, 13, 40, 19, 18, 32, 37, 26, 38 };
    cout << "a=" << a << "*a" << (*a) << endl;
    cout << &a[1] << endl;
    cout << &a[6] << endl;
    cout << "---------------------------" << endl;
    cout << *(a + 0) << endl;
    cout << *(a + 9) << endl;
    cout << &a[1] - &a[6] << endl;
    cout << *(a + (&a[1] - a + 6)) << endl;
    return 0;
}