.pos 0x1000
code:
                 ld   $i, r0              # r0 = address of i
                 ld   (r0), r0            # r0 = value of i
                 ld   $s, r1              # r1 = address of s
                 ld   (r1, r0, 4), r2     # r2 = s.x[i] 
                 ld   $v0, r3             # r3 = address of v0
                 st   r2, (r3)            # v0 = s.x[i]

                 inca r1                  # r1 = address of s.x[1]
                 inca r1                  # r1 = address of s.y
                 ld   (r1), r2            # r2 = value of s.y
                 ld   (r2, r0, 4), r4     # r4 = s.y[i]
                 ld   $v1, r3             # r3 = address of v1
                 st   r4, (r3)            # v1 = s.y[i]

                 inca r1                  # r1 = address of s.z
                 ld   (r1), r2            # r2 = value of s.z
                 ld   (r2, r0, 4), r3     # r3 = s.z->x[i] 
                 ld   $v2, r4             # r4 = address of v2
                 st   r3, (r4)            # v2 = s.z->x[i]

                 inca r2                  # r2 = address of s.z->x[1]
                 inca r2                  # r2 = address of s.z->y
                 inca r2                  # r2 = address of s.z->z
                 ld   (r2), r2            # r2 = value of s.z->z 
                 inca r2                  # r2 = address of s.z->z->x[1]
                 inca r2                  # r2 = address of s.z->z->y
                 ld   (r2), r2            # r2 = value of s.z->z->y
                 ld (r2, r0, 4), r2       # r2 = s.z->z->y[i]
                 ld   $v3, r4             # r4 = address of v3
                 st   r2, (r4)            # v3 = s.z->z->y

                 halt                     # halt

.pos 0x2000
static:
i:      .long 0x00000000
v0:     .long 0x00000000
v1:     .long 0x00000000
v2:     .long 0x00000000
v3:     .long 0x00000000
s:      .long 0x00000000     # x[0]
        .long 0x00000000     # x[1]
        .long s_y            # y
        .long s_z            # z


.pos 0x3000
heap:
s_y:    .long 0x00000000     #s.y[0]
        .long 0x00000000     #s.y[1]

s_z:    .long 0x00000000     # s.z->x[0]
        .long 0x00000000     # s.z->x[1]
        .long 0x00000000     # s.z->y
        .long s_z_z          # s.z->z

s_z_z:  .long 0x00000000     # s.z->z->x[0]
        .long 0x00000000     # s.z->z->x[1]
        .long s_z_z_y        # s.z->z->y
        .long 0x00000000     # s.z->z->z
        
s_z_z_y: .long 0x00000000     #s.z->z->y[0]
         .long 0x00000000     #s.z->z->y[1]
