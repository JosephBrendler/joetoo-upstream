/*
 * <filename> - text-file output test
 *
 * Derived from example code in the cplusplus.com C++ file I/O tutorial:
 *   https://cplusplus.com/doc/tutorial/files/
 *
 * Locally modified by Joseph Brendler for testing/reference purposes.
 * Original authorship and licensing remain with the upstream source.
 *
 * compile with g++ write_text_file.cpp -o write_text_file
 */

#include <iostream>
#include <fstream>
using namespace std;

int main () {
  ofstream myfile ("example.txt");
  if (myfile.is_open())
  {
    myfile << "This is a line.\n\n";
    myfile << "This is also a line.\n";
    myfile << "This is another line.\n\n";
    myfile << "\n\n\nThis is yet another joetoo line.\n";
    myfile.close();
  }
  else cout << "Unable to open file";
  return 0;
}
