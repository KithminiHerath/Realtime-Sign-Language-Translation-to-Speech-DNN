#pragma once

#include "CL/cl.h"

#include "nnLayer.hh"


class SoftmaxLayer : public NNLayer {
private:
	Matrix A;
	Matrix Z;
public:
	SoftmaxLayer(cl_device_id device_id, cl_context context, cl_command_queue command_queue, std::string name, Shape shape);
	~SoftmaxLayer();

	Matrix& forward(Matrix& Z);
};