__kernel void softmaxActivation(const __global double* Z, __global double* A, int Z_x_dim, int Z_y_dim) {
	int index = get_global_id(0);
	int i;
	double sum = 0.0f;

	for (i = 0; i < Z_x_dim * Z_y_dim; i++) {
		sum += exp(Z[i]);
	}

	if (index < Z_x_dim * Z_y_dim) {
		A[index] = exp(Z[index]) / sum;
	}
}