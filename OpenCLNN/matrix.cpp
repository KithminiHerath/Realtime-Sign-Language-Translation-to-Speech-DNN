#include "stdafx.h"
#include <iostream>
#include <stdlib.h>
#include "CL/cl.h"

#include "matrix.hh"

//Matrix constructor with x and y dimensions (x = number of columns, y = number of rows)
Matrix::Matrix(cl_context context, cl_command_queue command_queue, size_t x_dim, size_t y_dim) :
	shape(x_dim,y_dim),data_host(nullptr),
	device_allocated(false), host_allocated(false), 
	context(context), command_queue(command_queue)
{}

//Matrix constructor using shape i.e. (number of columns, number of rows)
Matrix::Matrix(cl_context context, cl_command_queue command_queue, Shape shape) :
	Matrix(context, command_queue, shape.x, shape.y)
{}

//Allocating memory for the matrix in the host device
void Matrix::allocateHostMemory() {
	if (!host_allocated) {
		data_host = std::shared_ptr<double>(new double[shape.x*shape.y], [&](double* ptr) {delete[] ptr; });
		host_allocated = true;
	}
	std::cout << "Successfully allocated memory\n";
}

//Allocating memory for the matrix in the device memory
void Matrix::allocateDeviceMemory() {
	if (!device_allocated) {
		cl_int ret;
		data_device = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(double)*shape.x*shape.y, NULL, &ret);
		if (ret != CL_SUCCESS) {
			std::cout << "Cannot allocate memory in the device." << std::endl;
			return;
		}
		device_allocated = true;
	}
}

//Allocating memory for the matrix in both the host and the device
void Matrix::allocateMemory() {
	allocateHostMemory();
	allocateDeviceMemory();
}

//Allocating memory for the matrix if the memory has not been allocated before
void Matrix::allocateMemoryForNew(Shape shape) {
	if (!device_allocated && !host_allocated) {
		this->shape = shape;
		allocateMemory();
	}
}

//Copying matrix data from host to device
void Matrix::copyHostToDevice() {
	if (host_allocated && device_allocated) {
		cl_int ret = clEnqueueWriteBuffer(command_queue, data_device, CL_TRUE, 0, sizeof(double)*shape.x*shape.y, data_host.get(), 0, NULL, NULL);
		if (ret != CL_SUCCESS) {
			std::cout << "Error copying data from host to device." << std::endl;
			if (ret == CL_INVALID_COMMAND_QUEUE) {
				std::cout << "Invalid command queue\n";
			}
			else if (ret == CL_INVALID_CONTEXT) {
				std::cout << "Invalid context\n";
			}
			else if (ret == CL_INVALID_MEM_OBJECT) {
				std::cout << "Invalid mem_object\n";
			}
			else if (ret == CL_INVALID_VALUE) {
				std::cout << "Invalid value\n";
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
	}
	else {
		std::cout << "Cannot copy data to/from unallocated device/host memory." << std::endl;
	}
}

//Copying matrix data from device to host
void Matrix::copyDeviceToHost() {
	if (host_allocated && device_allocated) {
		cl_int ret = clEnqueueReadBuffer(command_queue, data_device, CL_TRUE, 0, sizeof(double)*shape.x*shape.y, data_host.get(), 0, NULL, NULL);
		if (ret != CL_SUCCESS) {
			std::cout << "Error copying data from device to host." << std::endl;
			std::cout << "Error: " << ret << std::endl;
			return;
		}
	}
	else {
		std::cout << "Cannot copy data to/from unallocated device/host memory." << std::endl;
	}
}

//Operator to access matrix elements
double& Matrix::operator[](const int index) {
	return data_host.get()[index];
}

const double& Matrix::operator[](const int index)const {
	return data_host.get()[index];
}