.pos 0x100
    ld  $a, r0
    ld  $b, r1
    ld  (r0), r0
    ld  (r1, r0, 4), r2
    ld  (r1, r2, 4), r3
    ld  (r1, r3, 4), r4
    st  r2, (r1, r4, 4)
.pos 0x1000
a:  .long 1
.pos 0x2000
b:  .long 3
    .long 2
    .long 1
    .long 0