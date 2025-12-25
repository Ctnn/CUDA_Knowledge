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

    test01 <<<1024,1024>>> (); 

  
    cudaDeviceSynchronize(); 
    
    return 0;
}