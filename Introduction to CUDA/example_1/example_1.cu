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
    // "Execution Configuration" => "<<< >>>"
    
    // Scenario: A Construction Project
    // If you write <<< 2, 5 >>>:
    
    // 1. Set up 2 crews (Blocks) for me.
    // 2. Put 5 workers (Threads) in each crew.
    // 3. Result: 10 workers (2 * 5) working simultaneously.

    // kernel_name<<< num_of_blocks , num_of_threads_per_block>>> ();
    // IMPORTANT: CUDA does not guarantee the execution order of blocks. 
    // Since blocks run in parallel and independently, Block 1 may finish before Block 0.
   
    test01 <<<1024,1024>>> (); // Max Threads Per Block: 1024

    // Without this line, the program might exit before the GPU finishes (Asynchronous Execution).
    // The CPU waits here for the GPU to complete its task.
    // Without it, the output might appear sometimes, or not at all (Race Condition).
    
    // Analogy: The waiter (CPU) places the order and says:
    // "I am waiting at the door until the food comes out of the kitchen (GPU), nobody close the shop yet!"
    cudaDeviceSynchronize(); 
    
    return 0;
}