#include <iostream>

__global__ void add(int a, int b, int* c){
    *c = a + b;
}

int main(void){
    int c;
    int* dev_c;

    cudaMalloc((void**)&dev_c, sizeof(int));

    add<<<1,1>>>(7, 10, dev_c);

    cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);

    printf("7 + 10 = %d\n", c);

    return 0;
}