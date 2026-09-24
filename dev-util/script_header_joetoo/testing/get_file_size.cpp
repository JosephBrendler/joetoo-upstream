// get_file_size.cpp - demonstrate obtaining a file size with std::ifstream
//
// Derived from example code in the cplusplus.com C++ file I/O tutorial:
//   https://cplusplus.com/doc/tutorial/files/
//
// Retained in this package for testing/reference purposes.
// Original authorship and licensing remain with the upstream source.

// obtaining file size
#include <iostream>
#include <fstream>
using namespace std;

int main () {
  streampos begin,end;
//  ifstream myfile ("example.bin", ios::binary);
  ifstream myfile ("example.txt", ios::binary);
  begin = myfile.tellg();
  myfile.seekg (0, ios::end);
  end = myfile.tellg();
  myfile.close();
  cout << "file size is: " << (end-begin) << " bytes.\n";
  return 0;
}
