// Copyright (C) 2013-2014 Thalmic Labs Inc.
// Distributed under the Myo SDK license agreement. See LICENSE.txt for details.

// This sample illustrates how to log EMG and IMU data. EMG streaming is only supported for one Myo at a time, and this entire sample is geared to one armband

#define _USE_MATH_DEFINES
#include <cmath>
#include <iomanip>
#include <algorithm>
#include <array>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <fstream>
#include <time.h>
#include <windows.h> // WinApi header 
#include <chrono>
#include <string.h>
#include <direct.h>
//#include <unistd.h>

#include <myo/Myo.hpp>
using namespace std;
string DIR;
string path;
auto last_onset = chrono::steady_clock::now();;
//string GYRO_DIR = "";

bool triggered = 0;
std::ofstream detected_emg;
std::ofstream detected_gyro;
string detected_current;

class DataCollector : public myo::DeviceListener {
public:
	DataCollector()
	{
		openFiles();
	}


	void openFiles() {
		cout << "open files" << endl;
		time_t timestamp = std::time(0);
		
		cout << "Which gesture are you recording" << endl;



		path = "C:\\Users\\acer\\Downloads\\myo-sdk-win-0.9.0\\samples\\DATASET-test\\" ;

		cout << path << endl;
		
		ostringstream TEMP;
		TEMP << path << timestamp;

		cout << TEMP.str() << endl;
		char arr[1024];
		strcpy(arr, TEMP.str().c_str());

		cout << arr << endl;
		_mkdir(arr);

		// Open file for EMG log
		if (emgFile.is_open()) {
			emgFile.close();
		}
		std::ostringstream emgFileString;
		emgFileString<< TEMP.str() << "/emg-" << timestamp << ".csv";
		cout << emgFileString.str() << endl;
		emgFile.open(emgFileString.str(), std::ios::out);
		emgFile << "timestamp,emg1,emg2,emg3,emg4,emg5,emg6,emg7,emg8" << std::endl;

		// Open file for gyroscope log
		if (gyroFile.is_open()) {
			gyroFile.close();
		}
		std::ostringstream gyroFileString;
		gyroFileString << TEMP.str() << "/gyro-" << timestamp << ".csv";
		gyroFile.open(gyroFileString.str(), std::ios::out);
		gyroFile << "timestamp,x,y,z" << std::endl;

		// Open file for accelerometer log
		if (accelerometerFile.is_open()) {
			accelerometerFile.close();
		}
		std::ostringstream accelerometerFileString;
		accelerometerFileString << TEMP.str() <<"/accelerometer-" << timestamp << ".csv";
		accelerometerFile.open(accelerometerFileString.str(), std::ios::out);
		accelerometerFile << "timestamp,x,y,z" << std::endl;

		// Open file for orientation log
		if (orientationFile.is_open()) {
			orientationFile.close();
		}
		std::ostringstream orientationFileString;
		orientationFileString << TEMP.str() << "/orientation-" << timestamp << ".csv";
		orientationFile.open(orientationFileString.str(), std::ios::out);
		orientationFile << "timestamp,x,y,z,w" << std::endl;

		// Open file for orientation (Euler angles) log
		if (orientationEulerFile.is_open()) {
			orientationEulerFile.close();
		}
		std::ostringstream orientationEulerFileString;
		orientationEulerFileString << TEMP.str() <<"/orientationEuler-" << timestamp << ".csv";
		orientationEulerFile.open(orientationEulerFileString.str(), std::ios::out);
		orientationEulerFile << "timestamp,roll,pitch,yaw" << std::endl;



	}

	// onEmgData() is called whenever a paired Myo has provided new EMG data, and EMG streaming is enabled.
	void onEmgData(myo::Myo* myo, uint64_t timestamp, const int8_t* emg)
	{
		bool is_high= 0;  
		emgFile << timestamp;
		auto time_now = chrono::steady_clock::now();

		for (size_t i = 0; i < 8; i++) {
			int emg_temp = static_cast<int>(emg[i]);
			/*if (emg_temp >50){
				is_high = 1;
				
				
				if (chrono::duration_cast<chrono::milliseconds>(time_now - last_onset).count() >= 4000) {
					triggered = 1;
					last_onset = time_now;

					ostringstream TEMP;
					cout << "triggered - ";
					TEMP << timestamp<<".csv";

					cout << TEMP.str() << endl;
					
					if (detected.is_open()) {
						detected.close();
					}

					detected.open(TEMP.str(), std::ios::out);
					detected << "timestamp,emg1,emg2,emg3,emg4,emg5,emg6,emg7,emg8" << std::endl;

					
				}
			}*/
		}
/*
		if (chrono::duration_cast<chrono::milliseconds>(time_now - last_onset).count() >= 4000) {
			if (!is_high) {
				triggered = 0;
				cout << "gesture timed out" << endl;
				if (detected.is_open()) {
					detected.close();
				}
			}
		}
		*/
		if (triggered) {
			
			
			detected_emg <<  timestamp;
		}
	
		for (size_t i = 0; i < 8; i++) {
			int emg_temp = static_cast<int>(emg[i]);

			if (triggered) {
				detected_emg << "," << emg_temp;
			}
			emgFile << ',' << emg_temp;
		}
		emgFile << std::endl;
		detected_emg << std::endl;
	}

	// onOrientationData is called whenever new orientation data is provided
	// Be warned: This will not make any distiction between data from other Myo armbands
	void onOrientationData(myo::Myo *myo, uint64_t timestamp, const myo::Quaternion< float > &rotation) {

		
		orientationFile << timestamp
			<< ',' << rotation.x()
			<< ',' << rotation.y()
			<< ',' << rotation.z()
			<< ',' << rotation.w()
			<< std::endl;


		using std::atan2;
		using std::asin;
		using std::sqrt;
		using std::max;
		using std::min;

		// Calculate Euler angles (roll, pitch, and yaw) from the unit quaternion.
		float roll = atan2(2.0f * (rotation.w() * rotation.x() + rotation.y() * rotation.z()),
			1.0f - 2.0f * (rotation.x() * rotation.x() + rotation.y() * rotation.y()));
		float pitch = asin(max(-1.0f, min(1.0f, 2.0f * (rotation.w() * rotation.y() - rotation.z() * rotation.x()))));
		float yaw = atan2(2.0f * (rotation.w() * rotation.z() + rotation.x() * rotation.y()),
			1.0f - 2.0f * (rotation.y() * rotation.y() + rotation.z() * rotation.z()));

		orientationEulerFile << timestamp
			<< ',' << roll
			<< ',' << pitch
			<< ',' << yaw
			<< std::endl;
	}

	// onAccelerometerData is called whenever new acceleromenter data is provided
	// Be warned: This will not make any distiction between data from other Myo armbands
	void onAccelerometerData(myo::Myo *myo, uint64_t timestamp, const myo::Vector3< float > &accel) {
		auto time_now = chrono::steady_clock::now();
		if (accel.x() < 0) {
			//Beep(723, 100);
			
			
			if (chrono::duration_cast<chrono::milliseconds>(time_now - last_onset).count() >= 4000) {
				triggered = 1;
				last_onset = time_now;

				ostringstream TEMP;
				TEMP << timestamp<<".csv";

				detected_current = TEMP.str();

				if (detected_gyro.is_open()) {
					detected_gyro.close();
				}
				if (detected_emg.is_open()) {
					detected_emg.close();
				}

				string ff= "C:\\Users\\acer\\Desktop\\InnovateFPGA\\"
				detected_gyro.open(ff+"gyro-" + detected_current, std::ios::out);
				detected_emg.open(ff+"emg" + detected_current, std::ios::out);

				detected_emg << "timestamp,emg1,emg2,emg3,emg4,emg5,emg6,emg7,emg8" << std::endl;
				detected_gyro << "timestamp,x,y,z" << std::endl;
				cout << ',' << accel.x()
					<< ',' << accel.y()
					<< ',' << accel.z()
					<< std::endl


			}
			printVector(accelerometerFile, timestamp, accel);
		}else {
			if (chrono::duration_cast<chrono::milliseconds>(time_now - last_onset).count() >= 4000) {
					triggered = 0;
					cout << "gesture timed out" << endl;
					if (detected_gyro.is_open()) {
						detected_gyro.close();
					}
					if (detected_emg.is_open()) {
						detected_emg.close();
					}
			}
		}
	}

	// onGyroscopeData is called whenever new gyroscope data is provided
	// Be warned: This will not make any distiction between data from other Myo armbands
	void onGyroscopeData(myo::Myo *myo, uint64_t timestamp, const myo::Vector3< float > &gyro) {
		if (triggered) {
			detected_gyro << timestamp << ',' << gyro.x() << ',' << gyro.y() << ',' << gyro.z() << endl;
		}

		printVector(gyroFile, timestamp, gyro);

	}

	void onConnect(myo::Myo *myo, uint64_t timestamp, myo::FirmwareVersion firmwareVersion) {
		//Reneable streaming
		myo->setStreamEmg(myo::Myo::streamEmgEnabled);
		openFiles();
	}

	// Helper to print out accelerometer and gyroscope vectors
	void printVector(std::ofstream &file, uint64_t timestamp, const myo::Vector3< float > &vector) {
		file << timestamp
			<< ',' << vector.x()
			<< ',' << vector.y()
			<< ',' << vector.z()
			<< std::endl;
	}



	// The files we are logging to
	std::ofstream emgFile;
	std::ofstream gyroFile;
	std::ofstream orientationFile;
	std::ofstream orientationEulerFile;
	std::ofstream accelerometerFile;

};

int main(int argc, char** argv)
{
	// We catch any exceptions that might occur below -- see the catch statement for more details.
	try {

		// First, we create a Hub with our application identifier. Be sure not to use the com.example namespace when
		// publishing your application. The Hub provides access to one or more Myos.
		myo::Hub hub("com.undercoveryeti.myo-data-capture");

		std::cout << "Attempting to find a Myo..." << std::endl;

		// Next, we attempt to find a Myo to use. If a Myo is already paired in Myo Connect, this will return that Myo
		// immediately.
		// waitForMyo() takes a timeout value in milliseconds. In this case we will try to find a Myo for 10 seconds, and
		// if that fails, the function will return a null pointer.
		myo::Myo* myo = hub.waitForMyo(10000);

		// If waitForMyo() returned a null pointer, we failed to find a Myo, so exit with an error message.
		if (!myo) {
			throw std::runtime_error("Unable to find a Myo!");
		}

		// We've found a Myo.
		std::cout << "Connected to a Myo armband! Logging to the file system. Check your home folder or the folder this application lives in." << std::endl << std::endl;

		// Next we enable EMG streaming on the found Myo.
		myo->setStreamEmg(myo::Myo::streamEmgEnabled);

		// Next we construct an instance of our DeviceListener, so that we can register it with the Hub.
		DataCollector collector;

		// Hub::addListener() takes the address of any object whose class inherits from DeviceListener, and will cause
		// Hub::run() to send events to all registered device listeners.
		hub.addListener(&collector);

		// Finally we enter our main loop.

		//GYRO_DIR = x + "_";

		
		
		
		
		
		
		
		
		
		
		
		
		
		auto start = chrono::steady_clock::now();
		auto start0 = start;

		Beep(723, 500);
		while (1) {
			// In each iteration of our main loop, we run the Myo event loop for a set number of milliseconds.
			// In this case, we wish to update our display 50 times a second, so we run for 1000/20 milliseconds.
			hub.run(1);

			auto end = chrono::steady_clock::now();
			
			
			/**cout << "Elapsed time in milliseconds : "
				<< chrono::duration_cast<chrono::milliseconds>(end - start).count()
				<< " ms" << endl;
				*/
			if (chrono::duration_cast<chrono::milliseconds>(end - start).count() >= 4000) {
				start = end;
				//sBeep(523, 500);
			}
		}

		// If a standard exception occurred, we print out its message and exit.
	}
	catch (const std::exception& e) {
		std::cerr << "Error: " << e.what() << std::endl;
		std::cerr << "Press enter to continue.";
		std::cin.ignore();
		return 1;
	}
}
