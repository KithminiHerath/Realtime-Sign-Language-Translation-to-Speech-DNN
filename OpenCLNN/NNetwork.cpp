#include "stdafx.h"
#include "CL/cl.h"

#include "NNetwork.hh"

//Constructor for a neural network
NeuralNetwork::NeuralNetwork(cl_context context,cl_command_queue command_queue):
	output(context,command_queue,1,1)
{}

//Deconstructor for the neural network
NeuralNetwork::~NeuralNetwork() {
	for (auto layer : layers) {
		delete layer;
	}
}

//Adding a new layer to the neural network
void NeuralNetwork::newLayer(NNLayer* layer) {
	this->layers.push_back(layer);
}

//Forwarding the input through the neural network
Matrix NeuralNetwork::forward(Matrix X) {
	Matrix Z = X;
	for (auto layer : layers) {
		Z = layer->forward(Z);
	}
	output = Z;
	return output;
}

//Function to get the layers of the neural network
std::vector<NNLayer*> NeuralNetwork::getLayers() const {
	return layers;
}