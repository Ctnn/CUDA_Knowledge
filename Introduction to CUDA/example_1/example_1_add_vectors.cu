#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

// This is not a function, it's a kernel 
__global__ void test01()
{
    // Print the block and thread IDs
    printf("\nThe block ID is %d ---- the thread ID is %d \n", blockIdx.x, threadIdx.x);
}

int main()
{
    // add two vectors has 2048 elements
    test01 <<<1024,1024>>> (); // SM x Max Thread Blocks/SM  = num_of_blocks (first raw)

  
    cudaDeviceSynchronize(); 
    
    return 0;
}