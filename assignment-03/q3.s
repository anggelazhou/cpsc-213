.pos 0x100
        
        ld $a, r0               # r0 = address of a
        ld $0x03, r1            # r1 = 3
        st r1, (r0)             # a = 3

        dec r1                  # r1--
        st r1, (r0)             # *p = *p - 1 = 2

        ld $b, r0               # *p = address of b
        inca r0                 # p++
        ld $b, r2               # r2 = address of b
        ld (r2, r1, 4), r3      # r3 = b[a]
        shl $2, r1              # a = a * 4
        add r0, r1              # r1 = p[a]
        st r3, (r1)             # p[a] = b[a]

        ld $0xc, r4             # r4 = 12
        add r4, r0              # r0 = p + 12 (p + (3*4))
        ld (r2), r3             # r3 = b[0]
        st r3, (r0)             # *(p+3) = b[0]

        ld $b, r3               # r4 = address of b (p)
        inca r3                 # p++
        ld $p, r5               # r5 = address of p
        st r3, (r5)             # store new value of p into memory

        halt

.pos 0x1000
a:      .long 0x00000001
.pos 0x2000
p:      .long 0x00000001
.pos 0x3000
b:      .long 0x00000001
        .long 0x00000001
        .long 0x00000001
        .long 0x00000001
        .long 0x00000001