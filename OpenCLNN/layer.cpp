#include "stdafx.h"
#include <stdlib.h>
#include <assert.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

#include "layer.hh"
#include "readcsv.hh"

//Constructor for a neural network layer
//name = name of the layer eg: Layer1, Layer2, ...
//shape = shape of the weights matrix
//W = weights matrix, b = bias vector, A = input vector, Z = output vector
Layer::Layer(cl_device_id device_id, cl_context context, cl_command_queue command_queue, std::string name, Shape shape) :
	W(context, command_queue, shape), b(context, command_queue, 1, shape.y),
	A(context, command_queue, 1, shape.x), Z(context, command_queue, 1, shape.y)
{
	this->name = name;
	this->context = context;
	this->command_queue = command_queue;
	this->shape = shape;
	this->device_id = device_id;
	W.allocateMemory();
	std::cout << "Successfully allocated memory for weights in " << name << "\n";
	b.allocateMemory();
	std::cout << "Successfully allocated memory for biases in " << name << "\n";
	getWeights();
	std::cout << "Successfully loaded weights in " << name << "\n";
	getBias();
	std::cout << "Successfully loaded biases in " << name << "\n";
}

//Deconstructor for a neural network layer
Layer::~Layer()
{}

//Function to load the weights stored in a csv file
void Layer::getWeights() {
	std::string filename;
	filename = name + "_weights.csv";
	readCSVToMatrix(filename, W);
	W.copyHostToDevice();
}

//Function to load the biases stored in a csv file
void Layer::getBias() {
	std::string filename;
	filename = name + "_bias.csv";
	readCSVToMatrix(filename, b);
	b.copyHostToDevice();
}

//Function to calculate the layer output
void Layer::calculateLayerOutput(Matrix& A) {
	FILE *fp;				
	char *source_code;
	size_t source_size;

	//Reading the kernel file
	fp = fopen("matrix.cl", "r");
	if (!fp) {
		fprintf(stderr, "Failed to load the matrixMultiply kernel.\n");
		exit(1);
	}
	std::cout << "Successfully loaded the kernel file in " << name << "\n";
	//Reading the kernel file to character array source_code
	source_code = (char*)malloc(0x100000);
	source_size = fread(source_code, 1, 0x100000, fp);
	fclose(fp);

	//Variable to store the status of the cl commands
	cl_int ret;
	//Create a program from the kernel source
	cl_program program = clCreateProgramWithSource(context, 1, (const char **)&source_code, (const size_t *)&source_size, &ret);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to create the program." << std::endl;
	}
	else {
		std::cout << "Successfully created the program in " << name << "\n";
	}
	//Build the program
	ret = clBuildProgram(program, 1, &device_id, NULL, NULL, NULL);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to build the program." << std::endl;
		if (ret == CL_INVALID_PROGRAM) {
			std::cout << "Invalid program object" << std::endl;
		}
		else if (ret == CL_INVALID_VALUE) {
			std::cout << "Invalid num_devices" << std::endl;
		}
		else if (ret == CL_INVALID_DEVICE) {
			std::cout << "Invalid device" << std::endl;
		}
		else if (ret == CL_INVALID_BUILD_OPTIONS) {
			std::cout << "Invalid build options" << std::endl;
		}
		else if (ret == CL_INVALID_OPERATION) {
			std::cout << "Invalid operation" << std::endl;
		}
		else if (ret == CL_COMPILER_NOT_AVAILABLE) {
			std::cout << "Compiler not available" << std::endl;
		}
		else if (ret == CL_BUILD_PROGRAM_FAILURE) {
			std::cout << "Build program failure" << std::endl;
		}
		else if (ret == CL_INVALID_OPERATION) {
			std::cout << "Invalid operation" << std::endl;
		}
		else if (ret == CL_OUT_OF_HOST_MEMORY) {
			std::cout << "Out of host memory" << std::endl;
		}
	}
	else {
		std::cout << "Successfully built the program in " << name << "\n";
	}
	//Create the kernel matrix_multiply
	cl_kernel kernel = clCreateKernel(program, "matrix_multiply", &ret);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to create the kernel matrix_multiply." << std::endl;
	}
	else {
		std::cout << "Successfully created the kernel in " << name << "\n";
	}
	//Set kernel arguments
	ret = clSetKernelArg(kernel, 0, sizeof(int), (void *)&A.shape.x);
	ret &= clSetKernelArg(kernel, 1, sizeof(int), (void *)&W.shape.y);
	ret &= clSetKernelArg(kernel, 2, sizeof(int), (void *)&A.shape.y);
	ret &= clSetKernelArg(kernel, 3, sizeof(cl_mem), (void *)&W.data_device);
	ret &= clSetKernelArg(kernel, 4, sizeof(cl_mem), (void *)&A.data_device);
	ret &= clSetKernelArg(kernel, 5, sizeof(cl_mem), (void *)&Z.data_device);
	ret &= clSetKernelArg(kernel, 6, sizeof(cl_mem), (void *)&b.data_device);
	
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to set arguments for matrix_multiply kernel." << std::endl;
	}
	else {
		std::cout << "Argument setting for kernel is successful in " << name << "\n";
	}

	//Setting the global item size to the number of rows in the weights matrix
	//Each working item processes with a single row of the weights matrix
	size_t global_item[1];
	global_item[0] = (size_t) W.shape.y;
	//Executing the kernel
	cl_event event;
	ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, global_item, NULL, 0, NULL, NULL);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to execute the kernel matrix_multiply in " << name << "." << std::endl;
		if (ret == CL_INVALID_PROGRAM_EXECUTABLE) {
			std::cout << "No successfully built program\n";
		}
		else if (ret == CL_INVALID_COMMAND_QUEUE) {
			std::cout << "Invalid command queue\n";
		}
		else if (ret == CL_INVALID_KERNEL) {
			std::cout << "Invalid kernel\n";
		}
		else if (ret == CL_INVALID_CONTEXT) {
			std::cout << "Invalid context\n";
		}
		else if (ret == CL_INVALID_KERNEL_ARGS) {
			std::cout << "Invalid kernel arguments\n";
		}
		else if (ret == CL_INVALID_WORK_DIMENSION) {
			std::cout << "Invalid work dimension\n";
		}
		else if (ret == CL_INVALID_WORK_GROUP_SIZE) {
			std::cout << "Invalid work group size\n";
		}
		else if (ret == CL_INVALID_WORK_ITEM_SIZE) {
			std::cout << "Invalid work item size\n";
		}
		else if (ret == CL_INVALID_GLOBAL_OFFSET) {
			std::cout << "Invalid global offset\n";
		}
		else if (ret == CL_OUT_OF_RESOURCES) {
			std::cout << "Out of resources\n";
		}
		else if (ret == CL_INVALID_EVENT_WAIT_LIST) {
			std::cout << "Invalid event wait list\n";
		}
		else if (ret == CL_MEM_OBJECT_ALLOCATION_FAILURE) {
			std::cout << "Mem_object allocation failure\n";
		}
		else if (ret == CL_OUT_OF_HOST_MEMORY) {
			std::cout << "Out of host memory\n";
		}
		else {
			std::cout << "Other error\n";
		}
	}
	std::cout << "Successfully executed the kernel in " << name << "\n";
	//ret = clWaitForEvents(1, &event);
	//std::cout << "Event synchroniztion done in " << name << "\n";
}

//Function to go forward through the layer
Matrix& Layer::forward(Matrix& A) {
	this->A = A;
	//Allocating memory for the output vector
	Shape Z_shape(A.shape.x, W.shape.y);
	Z.allocateMemoryForNew(Z_shape);
	std::cout << "Successfully allocated memory for Matrix Z in " << name << "\n";

	//Calculating the output
	calculateLayerOutput(A);
	std::cout << "Successfully calculated output in " << name << "\n";
	return Z;
}

//Functions to get x and y dimensions of the weights matrix
int Layer::getXDim() const {
	return W.shape.x;
}

int Layer::getYDim() const {
	return W.shape.y;
}

//Function to get the weigths matrix
Matrix Layer::getWeightsMatrix() const {
	return W;
}

//Function to get the bias vector
Matrix Layer::getBiasMatrix() const {
	return b;
}