#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

// This is not function it's kernel 
__global__ voide test()
{

}


int main()
{
    test << <1,1> > ();

    return 0;
}