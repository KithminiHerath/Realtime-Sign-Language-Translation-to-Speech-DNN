__kernel void RELUActivation(const __global double* Z, __global double* A, int Z_x_dim, int Z_y_dim) {
	int index = get_global_id(0);
	
	if (index < Z_x_dim * Z_y_dim) {
		if (Z[index] <= 0) {
			A[index] = 0;
		}
		else {
			A[index] = Z[index];
		}
	}
}