#pragma once

#include "CL/cl.h"

#include "nnLayer.hh"

class Layer :public NNLayer {
private:
	Matrix W;
	Matrix b;

	Matrix A;
	Matrix Z;

	void getBias();
	void getWeights();
	//void calculateLayerOutput(Matrix& A);
public:
	Layer(cl_device_id device_id, cl_context context, cl_command_queue command_queue, std::string name, Shape shape);
	~Layer();

	void calculateLayerOutput(Matrix& A);
	Matrix& forward(Matrix& A);

	int getXDim() const;
	int getYDim() const;

	Matrix getWeightsMatrix() const;
	Matrix getBiasMatrix() const;
};