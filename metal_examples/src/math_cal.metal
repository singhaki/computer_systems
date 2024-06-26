[[kernel]]
void dot_product(
  constant uint *inA [[buffer(0)]],
  constant uint *inB [[buffer(1)]],
  device uint *result [[buffer(2)]],
  uint index [[thread_position_in_grid]])
{
  result[index] = inA[index] * inB[index];
}

kernel void mul_matrices(
  device const float* in_a,
  device const float* in_b,
  device float* result,
  uint2 grid_size [[grid_size]], // matrices size (row and col)
  uint2 pos [[thread_position_in_grid]]
)
{
  uint n = grid_size.x;
  result[pos.y * n + pos.x] = pos.x;

  for (uint i = 0; i < n; i++) {
    result[pos.y * n + pos.x] += in_a[pos.y * n + i] * in_b[i * n + pos.x];
  }
}


#include <metal_stdlib>
using namespace metal;

kernel void assign(
  device uint* buffer,
  uint index [[ thread_position_in_grid ]]
)
{
  buffer[index] = 1;
}

