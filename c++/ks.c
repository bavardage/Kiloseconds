#include <iostream>
using namespace std;

int main()
{
    time_t now;
    time(&now);
    struct tm *t = localtime(&now);
    float ks = (t->tm_hour*3600 + t->tm_min*60 + t->tm_sec);
    cout << "it is " << ks/1000 << " kiloseconds" << endl;
    return 0;
}

