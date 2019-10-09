__kernel void sigmoidActivation(const __global double* Z, __global double* A, int Z_x_dim, int Z_y_dim) {
	int index = get_global_id(0);

	if (index < Z_x_dim * Z_y_dim) {
		A[index] = 1.0f / exp(1 + (Z[index]));
	}
}