.pos 0x0
    ld   $0x1028, r5            # r5 = 0x1028 (bottom of stack)
    ld   $0xfffffff4, r0        # r0 = -12
    add  r0, r5                 # r0 = 0x1028 - 12 (allocate 3 spots in frame)
    ld   $0x200, r0             # r0 = 0x200 (&arr[0])
    ld   0x0(r0), r0            # r0 = arr[0]
    st   r0, 0x0(r5)            # store arr[0] on stack (0x101c)
    ld   $0x204, r0             # r0 = 0x204 (&arr[1])  
    ld   0x0(r0), r0            # r0 = arr[1]
    st   r0, 0x4(r5)            # store arr[1] on stack 
    ld   $0x208, r0             # r0 = 0x208 (&arr[2])
    ld   0x0(r0), r0            # r0 = arr[2]
    st   r0, 0x8(r5)            # store arr[2] on stack
    gpc  $6, r6                 # r6 = return address = pc + 6
    j    0x300                  # goto 0x300 [procedure q2]
    ld   $0x20c, r1             # r1 = 0x20c (&arr[3])
    st   r0, 0x0(r1)            # arr[3] = arg2
    halt
.pos 0x200
    .long 0x0000000A            # arr[0]
    .long 0x00000004            # arr[1]
    .long 0x00000006            # arr[2]
    .long 0x00000005            # arr[3]
.pos 0x300
    ld   0x0(r5), r0            # r0 = arr[0] (arg0) [procedure q2]
    ld   0x4(r5), r1            # r1 = arr[1] (arg1)
    ld   0x8(r5), r2            # r2 = arr[2] (arg2)
    ld   $0xfffffff6, r3        # r3 = -10
    add  r3, r0                 # r0 = arg0 - 10
    mov  r0, r3                 # r3 = arg0 - 10
    not  r3                     # r3 = ~(arg0 - 10)
    inc  r3                     # r3 = 10 - arg0
    bgt  r3, L6                 # if arg0 < 10, goto L6
    mov  r0, r3                 # r3 = arg0 - 10
    ld   $0xfffffff8, r4        # r4 = -8
    add  r4, r3                 # r3 = arg0 - 10 - 8 = arg0 - 18
    bgt  r3, L6                 # if arg0 > 18, goto L6
    ld   $0x400, r3             # r3 = 0x400 (&jump table)
    ld   (r3, r0, 4), r3        # r3 = jump table[arg0 - 10]
    j    (r3)                   # goto jump table[arg0 - 10]
.pos 0x330
    add  r1, r2                 # r2 = arg2 + arg1 (when arg0 = 10)
    br   L7                     # goto L7

    not  r2                     # r2 = ~(arg2) (when arg0 = 12)
    inc  r2                     # r2 = -arg2
    add  r1, r2                 # r2 = arg1 - arg2
    br   L7                     # goto L7

    not  r2                     # r2 = ~(arg2) (when arg0 = 14)
    inc  r2                     # r2 = -arg2
    add  r1, r2                 # r2 = arg1 - arg2
    bgt  r2, L0                 # if arg1 > arg2, goto L0
    ld   $0x0, r2               # r2 = 0x0
    br   L1                     # goto L1 (which goes to L7)
L0:
    ld   $0x1, r2               # r2 = 0x1
L1:
    br   L7                     # goto L7

    not  r1                     # r1 = ~(arg1) (when arg0 = 16)
    inc  r1                     # r1 = - arg1 
    add  r2, r1                 # r1 = arg2 - arg1
    bgt  r1, L2                 # if arg2 > arg1, goto L2
    ld   $0x0, r2               # r2 = 0x0
    br   L3                     # goto L3 (which goes to L7)
L2:
    ld   $0x1, r2               # r2 = 0x1
L3:
    br   L7                     # goto L7

    not  r2                     # r2 = ~(arg2) (when arg0 = 18)
    inc  r2                     # r2 = -arg2
    add  r1, r2                 # r2 = arg1 - arg2
    beq  r2, L4                 # if arg1 = arg2, goto L4
    ld   $0x0, r2               # r2 = 0x0
    br   L5                     # goto L5 (which goes to L7)
L4:
    ld   $0x1, r2               # r2 = 0x1
L5:
    br   L7                     # goto L7
L6:
    ld   $0x0, r2               # r2 = 0x0 (default case)
    br   L7                     # goto L7  (^ when arg0 < 10 OR arg0 = 11, 13, 15, 17 OR arg0 > 18)
L7:
    mov  r2, r0                 # r0 = r2
    j    0x0(r6)                # goto r6

.pos 0x400                      # jump table
    .long 0x00000330            # add r1, r2 (r0 = 10)
    .long 0x00000384            # L6 (r0 = 11)
    .long 0x00000334            # not r2 (r0 = 12)
    .long 0x00000384            # L6 (r0 = 13)
    .long 0x0000033c            # not r2 (r0 = 14)
    .long 0x00000384            # L6 (r0 = 15)
    .long 0x00000354            # not r1 (r0 = 16)
    .long 0x00000384            # L6 (r0 = 17)
    .long 0x0000036c            # not r2 (r0 = 18)
.pos 0x1000                     # stack
    .long 0x00000000
    .long 0x00000000
    .long 0x00000000
    .long 0x00000000
    .long 0x00000000
    .long 0x00000000
    .long 0x00000000
    .long 0x00000000
    .long 0x00000000
    .long 0x00000000