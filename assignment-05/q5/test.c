#include <stdlib.h>
#include <stdio.h>

int main() {
    int i = 10;
    int j = 0 & (i++);
    printf("j = %d, i = %d\n",j, i);
    int k = 0 && (i++);

    printf("k = %d, i = %d\n",k, i);
}

void test_int_pointer_vs_void_pointer() {
    int* ip = malloc(8*sizeof(int));
    void* vp = ip;
    printf("ip =  %p, vp = %p, ip + 3 = %p, vp + 3 = %p\n"
            , ip, vp, ip+3, vp+3);
}