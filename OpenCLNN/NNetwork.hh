#pragma once

#include <vector>

#include "nnLayer.hh"

class NeuralNetwork {
private:
	std::vector<NNLayer*> layers;
	Matrix output;
public:
	NeuralNetwork(cl_context context, cl_command_queue command_queue);
	~NeuralNetwork();

	Matrix forward(Matrix input);
	void newLayer(NNLayer *layer);
	std::vector<NNLayer*> getLayers() const;
};