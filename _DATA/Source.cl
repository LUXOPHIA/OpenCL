kernel void Main( global float* BufferA,
                  global float* BufferB,
                  global float* BufferC )
{
    int i = get_global_id( 0 );

    BufferC[ i ] = BufferA[ i ] * BufferB[ i ];
}

