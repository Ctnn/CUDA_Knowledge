#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

int main()
{
    int deviceId;
    // Get the current GPU ID (Usually 0)
    cudaGetDevice(&deviceId); 

    cudaDeviceProp props;
    // Load device properties into the 'props' variable
    cudaGetDeviceProperties(&props, deviceId); 

    printf("\n--- GPU Information ---\n");
    printf("GPU Name: %s\n", props.name);
    printf("Max Threads Per Block: %d\n", props.maxThreadsPerBlock);
    
    // This is the 'Max dimension size of a thread block' you asked about:
    printf("Max Block Dimensions [x, y, z]: [%d, %d, %d]\n", 
           props.maxThreadsDim[0], props.maxThreadsDim[1], props.maxThreadsDim[2]);

    printf("Max Grid Dimensions [x, y, z]: [%d, %d, %d]\n", 
           props.maxGridSize[0], props.maxGridSize[1], props.maxGridSize[2]);
    
    printf("Warp Size: %d\n", props.warpSize);

    return 0;
}