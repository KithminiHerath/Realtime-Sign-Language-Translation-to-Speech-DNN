#pragma once

#include <memory>
#include "CL/cl.h"

#include "shape.hh"

class Matrix {
private:
	cl_context context;
	cl_command_queue command_queue;
	bool host_allocated;
	bool device_allocated;

	void allocateHostMemory();
	void allocateDeviceMemory();

public:
	Shape shape;

	cl_mem data_device;
	std::shared_ptr<double> data_host;

	Matrix(cl_context context, cl_command_queue command_queue, size_t x_dim = 1, size_t y_dim = 1);
	Matrix(cl_context context, cl_command_queue command_queue, Shape shape);

	void allocateMemory();
	void allocateMemoryForNew(Shape shape);

	void copyHostToDevice();
	void copyDeviceToHost();

	double& operator[](const int index);
	const double& operator[](const int index) const;
};