#include "cuda_runtime.h"

#include <stdio.h>

#define SIZE 32 // Define the size of the vector

// CUDA Kernel for vector addition
// Executed on the GPU side
__global__ void vectorAdd(int* A, int* B, int* C, int n) {
    int i = threadIdx.x;
    C[i] = A[i] + B[i];
}

int main()
{
    // Step 1 Allocate and initialize host and device vectors
    int * A, * B, * C;               // Host vectors
    int * d_A, * d_B, * d_C;        // Device vectors
    size_t size = SIZE * sizeof(int);

    //Step 2 Allocate and initialize host vectors
    // Standart C'de fonksiyon, ayırdığı yerin adresini return eder (geri döndürür).
    A = (int*)malloc(size);
    B = (int*)malloc(size);
    C = (int*)malloc(size);

    // Step 3 Allocate device vectors
    cudaMalloc((void**)&d_A, size);
    cudaMalloc((void**)&d_B, size);
    cudaMalloc((void**)&d_C, size);

    // Step 4 Initialize the host input vFectors

    for( int i=0; i< SIZE; i++ ) {
        A[i] = i;
        B[i] = i*i;
    }

    cudaMemcpy(d_A,A,size,cudaMemcpyHostToDevice); // cudaMemcpy( HEDEF, KAYNAK, BOYUT, YÖN );
    cudaMemcpy(d_B,B,size,cudaMemcpyHostToDevice);

    // Step 5 Launch the Vector 

    vectorAdd<<<1, SIZE>>>(d_A, d_B, d_C, SIZE);

    // Step 6 Copy result back to host
    //When the GPU finishes its task, the results are stored in d_C (GPU memory). 
    //The CPU must retrieve the data in order to read it and print it to the screen using printf.

    cudaMemcpy(C,d_C,size,cudaMemcpyDeviceToHost); // Device mean the gpu(C) and Host mean the cpu(d_C)

    printf(" \n Execution finished \n");
    for( int i=0; i< SIZE; i++ ) {
        printf("%d + %d = %d", A[i], B[i], C[i]);
        printf("\n");
    }

    // Step 7 Cleanup
    // There is no “Garbage Collector” in C++ and CUDA. So, we need to free the memory we allocated.
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(A);
    free(B);
    free(C);
  
    cudaDeviceSynchronize(); 
    
    return 0;
}