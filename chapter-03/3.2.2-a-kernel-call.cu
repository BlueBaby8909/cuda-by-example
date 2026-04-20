#include <iostream>

__global__ void kernel(void){
}

int main(void){
    kernel<<<1,1>>>();
    printf("Hello, Boss!\n");

    return 0;
}