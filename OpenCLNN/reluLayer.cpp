#include "stdafx.h"
#include <iostream>
#include <stdlib.h>
#include "CL/cl.h"

#include "reluLayer.hh"

//Constructor for the RELU activation
//name = name of the RELU activation layer eg: RELU1, RELU2, ...
//shape = shape of the output vector
RELULayer::RELULayer(cl_device_id device_id, cl_context context, cl_command_queue command_queue, std::string name, Shape shape) :
	A(context, command_queue, shape), Z(context, command_queue, shape)
{
	this->name = name;
	this->context = context;
	this->command_queue = command_queue;
	this->shape = shape;
	this->device_id = device_id;
}

//Deconstructor for the RELU activation layer
RELULayer::~RELULayer()
{}

//Function to do RELU activation on a layer
Matrix& RELULayer::forward(Matrix& Z) {
	this->Z = Z;
	A.allocateMemoryForNew(Z.shape);
	std::cout << "Allocated memory for Matrix A\n";

	FILE *fp;
	char *source_code;
	size_t source_size;
	//Reading the kernel file
	fp = fopen("reluLayer.cl", "r");
	if (!fp) {
		fprintf(stderr, "Failed to load the kernel.\n");
		exit(1);
	}
	source_code = (char*)malloc(0x100000);
	source_size = fread(source_code, 1, 0x100000, fp);
	fclose(fp);

	cl_int ret;
	//Create a program from the kernel source
	cl_program program = clCreateProgramWithSource(context, 1, (const char **)&source_code, (const size_t *)&source_size, &ret);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to create the program." << std::endl;
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

	//Create the kernel RELUActivation
	cl_kernel kernel = clCreateKernel(program, "RELUActivation", &ret);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to create the kernel." << std::endl;
	}

	//Set kernel arguments
	ret = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&Z.data_device);
	ret &= clSetKernelArg(kernel, 1, sizeof(cl_mem), (void *)&A.data_device);
	ret &= clSetKernelArg(kernel, 2, sizeof(int), (void *)&Z.shape.x);
	ret &= clSetKernelArg(kernel, 3, sizeof(int), (void *)&Z.shape.y);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to set arguments for sigmoidActivation kernel." << std::endl;
	}

	//Setting the global item size to the size of the vector
	size_t global_item[1];
	global_item[0] = (size_t)Z.shape.y;
	//Execute the kernel
	cl_event event;
	ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, global_item, NULL, 0, NULL, NULL);
	if (ret != CL_SUCCESS) {
		std::cout << "Failed to execute the kernel sigmoidActivation." << std::endl;
	}
	//ret = clWaitForEvents(1, &event);
	//Copying the results to the host memory
	A.copyDeviceToHost();
	return A;
}