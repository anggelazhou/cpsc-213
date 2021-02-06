.pos 0x100
    ld   $t, r0              # r0 = address of t
    ld   $array, r1          # r1 = address of array
    ld   $0x10, r2           # r2 = 16
    st   r2, (r1)            # array[0] = 16

    ld   $0x110, r2          # r2 = 272
    ld   $0x1, r3            # r3 = 1
    st   r2, (r1, r3, 4)     # array[1] = 272

    ld   $0x0, r5            # r5 = 0
    ld   (r1, r5, 4), r4     # r4 = array[0] = 16
    st   r4, (r0)            # t = array[0]

    ld   (r1, r3, 4), r4     # r4 = array[1] = 272
    st   r4, (r1)            # array[0] = 272

    ld   (r0), r4            # r4 = t = 16
    st   r4, (r1, r3, 4)     # array[1] = t

    halt                     # halt

.pos 0x1000
t: .long 0x00000000
.pos 0x2000
array: .long 0x00000010 
       .long 0x00000110




