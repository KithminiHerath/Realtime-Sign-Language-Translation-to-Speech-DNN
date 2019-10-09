#pragma once

#include "CL/cl.h"

#include "nnLayer.hh"


class SigmoidLayer : public NNLayer {
private:
	Matrix A;
	Matrix Z;
public:
	SigmoidLayer(cl_device_id device_id, cl_context context, cl_command_queue command_queue, std::string name, Shape shape);
	~SigmoidLayer();

	Matrix& forward(Matrix& Z);
};