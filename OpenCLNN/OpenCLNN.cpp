// OpenCLNN.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#define CL_USE_DEPRECATED_OPENCL_1_2_APIS
#include <iostream>
#include <algorithm>
#include "CL/cl.h"
#include <string>
#include <chrono>

#include "NNetwork.hh"
#include "layer.hh"
#include "sigmoidLayer.hh"
#include "softmaxLayer.hh"
#include "reluLayer.hh"
#include "readcsv.hh"

#define EMG_SAMPLES 1500
#define GYRO_SAMPLES 1000

int main()
{
	//Dimensions of the input and output vectors
	const int input_x_dim = 1;
	const int input_y_dim = 29;
	const int output_x_dim = 1;
	const int output_y_dim = 5;

	//Gestures list
	std::string gestures[5] = { "YELLOW","WATER","YES","THANK YOU","NO" };

	//Get platforms and devices
	cl_platform_id platform_id = NULL;
	cl_device_id device_id = NULL;
	cl_uint num_devices;
	cl_uint num_platforms;
	cl_int ret = clGetPlatformIDs(1, &platform_id, &num_platforms);
	if (ret != CL_SUCCESS) {
		std::cout << "Error in getting the platforms." << std::endl;
	}
	ret = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_GPU, 1, &device_id, &num_devices);
	if (ret != CL_SUCCESS) {
		std::cout << "Error in getting the devices." << std::endl;
	}

	//Create an OpenCL context
	cl_context context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &ret);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to create the context." << std::endl;
	}

	//Create a command queue
	cl_command_queue command_queue = clCreateCommandQueue(context, device_id, 0, &ret);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to create command queue." << std::endl;
	}

	//Data pre-processing
	//------------------------- Data pre-processing function-------------------------//

	//Get input data to a matrix
	Matrix input = Matrix::Matrix(context, command_queue, input_x_dim, input_y_dim);
	input.allocateMemory();
	readCSVToMatrix("input.csv", input);
	//Scaling the inputs
	/*double minimum = *std::min_element(input.data_host.get(), input.data_host.get() + input_y_dim);
	double maximum = *std::max_element(input.data_host.get(), input.data_host.get() + input_y_dim);
	for (int i = 0; i < input_y_dim; i++) {
		input.data_host.get()[i] = input.data_host.get()[i] / (maximum - minimum);
	}*/

	//Copying inputs to the device
	input.copyHostToDevice();

	//Creating a neural network with a single hidden layer
	NeuralNetwork nn = NeuralNetwork::NeuralNetwork(context, command_queue);
	//Hidden layer with a weights matrix of 17 x 29
	nn.newLayer(new Layer(device_id, context, command_queue, "Layer1", Shape(29, 17)));
	//RELU activation
	nn.newLayer(new RELULayer(device_id, context, command_queue, "RELU1", Shape(1, 17)));
	//Output layer
	nn.newLayer(new Layer(device_id, context, command_queue, "Layer2", Shape(17, output_y_dim)));
	//Softmax activation
	nn.newLayer(new SoftmaxLayer(device_id, context, command_queue, "Softmax2", Shape(output_x_dim,output_y_dim)));

	//Inferencing the network
	std::cout << "\n \n Inferencing the neural network........\n \n";
	auto start = std::chrono::steady_clock::now();
	Matrix output = Matrix::Matrix(context, command_queue, output_x_dim, output_y_dim);
	output = nn.forward(input);
	//Copying the results to the host
	output.copyDeviceToHost();
	auto end = std::chrono::steady_clock::now();

	std::cout << "\n \nDone classifying! \n";
	std::cout << "Elapsed time in milliseconds : " << std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count() << "ms\n \n";

	//Display the results
	for (int i = 0; i < output.shape.x * output.shape.y; i++) {
		std::cout << "Output[" << i << "] = " << output.data_host.get()[i] << std::endl;
	}
	int max_index = std::distance(output.data_host.get(), std::max_element(output.data_host.get(),output.data_host.get() + output_y_dim));
	std::cout << "\n \nMax index : " << max_index << "\n";
	std::cout << "Classified as : " <<gestures[max_index] << "\n \n";
	
	//Clean up
	ret = clFlush(command_queue);
	ret = clFinish(command_queue);
	ret = clReleaseMemObject(input.data_device);
	ret = clReleaseMemObject(output.data_device);
	ret = clReleaseCommandQueue(command_queue);
	ret = clReleaseContext(context);
    return 0;
}

//Function for data preprocessing
void dataProcess(cl_context context, cl_command_queue command_queue, std::string emgFile, std::string gyroFile) {
	//Getting raw emg and gyro data
	Matrix raw_emg = Matrix::Matrix(context, command_queue, 9, EMG_SAMPLES + 1);
	Matrix raw_gyro = Matrix::Matrix(context, command_queue, 4, GYRO_SAMPLES + 1);
	raw_emg.allocateMemory();
	raw_gyro.allocateMemory();

	readCSVToMatrix(emgFile, raw_emg);
	readCSVToMatrix(gyroFile, raw_gyro);
}