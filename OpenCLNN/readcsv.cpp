#include "stdafx.h"
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

#include "readcsv.hh"

using namespace std;

//Function to read a csv file into a matrix
void readCSVToMatrix(string filename, Matrix& X) {
	string line;

	//Opening the file
	ifstream f(filename);
	if (!f.is_open()) {
		cout << "Error in reading " << filename << "\n";
	}

	int i = 0;
	//Reading the file line by line
	while (getline(f, line) && (i < X.shape.x * X.shape.y)) {
		string val;
		stringstream s(line);
		//Allocating each element to the matrix converting them to double
		while (getline(s, val, ',')) {
			X[i] = stod(val);
			i++;
		}
	}
	f.close();
}