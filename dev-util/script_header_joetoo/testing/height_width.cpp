// height_width.cpp - demonstrate querying terminal rows and columns
//
// Derived from example code posted to LinuxQuestions.org:
//   "Get width/height of a terminal window in c++?"
//   post #2, 2010-05-29 06:05 AM
//   https://www.linuxquestions.org/questions/programming-9/get-width-height-of-a-terminal-window-in-c-810739/
//
// Retained in this package for testing/reference purposes.
// Original authorship and licensing remain with the upstream source.

#include <sys/ioctl.h>
#include <stdio.h>
#include <unistd.h>

int main (void)
{
    int cols = 80;
    int lines = 24;

#ifdef TIOCGSIZE
    struct ttysize ts;
    ioctl(STDIN_FILENO, TIOCGSIZE, &ts);
    cols = ts.ts_cols;
    lines = ts.ts_lines;
#elif defined(TIOCGWINSZ)
    struct winsize ts;
    ioctl(STDIN_FILENO, TIOCGWINSZ, &ts);
    cols = ts.ws_col;
    lines = ts.ws_row;
#endif /* TIOCGSIZE */

    printf("Terminal size is %dx%d\n", cols, lines);
}
