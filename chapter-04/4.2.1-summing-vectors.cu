#include <iostream>
#define N 10
__global__ void add(int *a, int *b, int *c){
    int tid = blockIdx.x;

    if(tid < N){
        c[tid] = a[tid] + b[tid];
    }
}

int main(void){
    int a[N], b[N], c[N];
    int *dev_a, *dev_b, *dev_c;
    int Array_size = sizeof(int) * N;
    
    cudaMalloc((void**)&dev_a, Array_size);
    cudaMalloc((void**)&dev_b, Array_size);
    cudaMalloc((void**)&dev_c, Array_size);

    for(int i=0; i<N; i++){
        a[i] = 2 * i;
        b[i] = 2 * i + 1;
    }

    cudaMemcpy(dev_a, a, Array_size, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, Array_size, cudaMemcpyHostToDevice);

    add<<<N, 1>>>(dev_a, dev_b, dev_c);
  
    cudaMemcpy(c, dev_c, Array_size, cudaMemcpyDeviceToHost);

    for(int i=0; i<N; i++){
        printf("%d + %d = %d\n", a[i], b[i], c[i]);
    }

    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_c);

    return 0;
}