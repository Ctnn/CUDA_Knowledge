// Grid (1. level) -> Thread Block (2. level) -> Warp: Group of 32 threads  (3. level) -> Thread (4.level)(threadIdx.x)

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

// This is not a function, it's a kernel 
__global__ void test01()
{
    // Print the block and thread IDs
    // Warp=32threads (I assume my project's have 128 threads/block) --> ( 128/32 = 4 warps/block)
    int warp_ID_Value = 0;
    warp_ID_Value = threadIdx.x / 32;
    printf("\nThe block ID is %d ---- the thread ID is %d ---- The warp ID %d \n ", blockIdx.x, threadIdx.x,warp_ID_Value);
}

int main()
{
    // test01 <<<1,64>>> (); // warps/block = 2warps
    // test01 <<<2,64>>> (); // warps/block = 4warps
    test01 <<<1,128>>> (); // warps/block = 4warps

  
    cudaDeviceSynchronize(); 
    
    return 0;
}