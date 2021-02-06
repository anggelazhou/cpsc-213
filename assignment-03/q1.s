.pos 0x100
    ld   $i, r0              # r0 = address of i
    ld   $j, r1              # r1 = address of j
    ld   $a, r2              # r2 = address of a

    ld   $0x3, r3            # r3 = 3
    ld   (r2, r3, 4), r4     # r4 = a[3]
    st   r4, (r0)            # i = a[3]

    ld  (r0), r3             # r3 = value of i
    ld  (r2, r3, 4), r4      # r4 = a[i]
    st  r4, (r0)             # i = a[i]

    ld  $p, r4               # r4 = address of p
    st  r1, (r4)             # p = &j

    ld  $0x4, r5             # r5 = 4
    st  r5, (r4)             # *p = 4

    ld  $0x2, r5             # r5 = 2
    ld  (r2, r5, 4), r3      # r3 = a[2]
    ld  (r2, r3, 4), r5      # r5 = a[a[2]]
    shl $2, r3               # r3 = 4 * a[2]
    add r3, r2               # r2 = address of a[a[2]]
    ld  $p, r6               # r6 = address of p   
    st  r2, (r6)             # p = address of a[a[2]]

    ld  $p, r5               # r5 = address of p
    ld  (r5), r3             # r3 = p (= address of a[a[2]])
    ld  (r3), r6             # r6 = p*
    ld  $0x4, r7             # r7 = 4
    ld  $a, r2               # r2 = address of a
    ld  (r2, r7, 4), r4      # r4 = a[4]
    add r4, r6               # r6 = p* + a[4]
    st  r6, (r3)             # a[a[2]] = p* + a[4]
    
    halt                     # halt

.pos 0x1000
i: .long 0x00000001
.pos 0x2000
j: .long 0x00000010
.pos 0x3000
p: .long 0x00000017
.pos 0x4000
a: .long 0x00000011
   .long 0x00000012
   .long 0x00000013
   .long 0x00000014
   .long 0x00000015
   .long 0x00000016
   .long 0x00000017
   .long 0x00000018
   .long 0x00000019
   .long 0x0000001a