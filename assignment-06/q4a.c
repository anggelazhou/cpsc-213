#include <stdlib.h>
#include <stdio.h>

int * a;

void method_200(int i, int j) {
    // int k = a[i];
    // j += a[i];
    // a[i] = j;
    a[j] = a[j] + i;
}

void method_300() {
   
    a = malloc(10*sizeof(int));
    for (int i = 0; i < 10; i++) {
        *(a+i) = 0;
    }

    int t1 = 1;
    int t2 = 2;
    
    method_200(3, 4);

    method_200(t1, t2);

    for (int i = 0; i < 10; i++) {
        printf("%d\n", a[i]);
    }

    free(a);
}

int main() {
    method_300();
}


