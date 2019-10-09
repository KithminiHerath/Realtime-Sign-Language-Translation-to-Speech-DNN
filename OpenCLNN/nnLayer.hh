#pragma once

#include <iostream>
#include "CL/cl.h"

#include "matrix.hh"

class NNLayer {
protected:
	std::string name;
	cl_context context;
	cl_command_queue command_queue;
	Shape shape;
public:
	cl_device_id device_id;
	virtual ~NNLayer() = 0;
	virtual Matrix& forward(Matrix& A) = 0;

	std::string getName() { return this->name; };
};

inline NNLayer::~NNLayer(){}