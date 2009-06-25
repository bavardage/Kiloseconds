#include <stdio.h>
#include <time.h>

int main()
{
     struct tm *t;
     time_t now;
     float ks;
     time(&now);
     t=localtime(&now);
     ks=(t->tm_hour*3600 + t->tm_min*60 + t->tm_sec);
     printf("it is %.2f kiloseconds\n",ks/1000);
     return 0;
}

