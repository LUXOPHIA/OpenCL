__kernel void
add( __global const float *A,
     __global const float *B,
     __global float *C )
{
    *C = *A + *B;
}

