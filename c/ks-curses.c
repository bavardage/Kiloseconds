#include <ncurses.h>
#include <stdio.h>
#include <time.h>
int main()
{
    struct tm *t;
    time_t now;
    float ks;
    initscr();
    while(true) {
        time(&now);
        t=localtime(&now);
        ks=(t->tm_hour*3600 + t->tm_min*60 + t->tm_sec);
        mvprintw(0,0, "It is %.3f kiloseconds\n",ks/1000);
        refresh();
        sleep(1);
    }
    endwin(); /*don't think this is needed but mhr */
    return 0;
}
