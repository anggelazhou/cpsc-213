#include <stdlib.h>
#include <stdio.h>

int x[8];
int y[8];

int f(int i) {
    
    int r0 = 0;
    int r2 = 0x80000000;

    while (i != 0) {
        if ((i & r2) != 0) {
            r0++;
        }
        i = i * 2;
    }

    return r0;
}

int main() {
    for (int i = 0; i<8; i++) {
        y[i] = 0;
    }

    x[0] = 1;
    x[1] = 2;
    x[2] = 3;
    x[3] = -1;
    x[4] = -2;
    x[5] = 0;
    x[6] = 184;
    x[7] = 340057058;

    int r4 = 8;

    while (r4 != 0) {
        r4--;
        int a = x[r4];
        a = f(a);
        y[r4] = a;
    }

    for (int i = 0; i<8; i++) {
        printf("%d\n", x[i]);
    }

    for (int i = 0; i<8; i++) {
        printf("%d\n", y[i]);
    }
}