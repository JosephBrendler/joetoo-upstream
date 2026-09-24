/*
 * read_text_file.cpp - read a text file line-by-line
 *
 * Derived from example code in the cplusplus.com C++ file I/O tutorial:
 *   https://cplusplus.com/doc/tutorial/files/
 *
 * Locally modified by Joseph Brendler to number output lines.
 *
 * Retained in this package for testing/reference purposes.
 * Original authorship and licensing remain with the upstream source.
 *
 *  compiler command:
 *  $ g++ -o read_text_file read_text_file.cpp
 */

#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main () {
  string line;
  ifstream myfile ("example.txt");
  if (myfile.is_open())
  {
    int i=0;
    while ( getline (myfile,line) )
    {
      cout << i++ << ") " << line << '\n';
    }
    myfile.close();
  }

  else cout << "Unable to open file"; 

  return 0;
}
