.pos 0x100
    ld   $i, r0              # r0 = address of i
    ld   $x, r1              # r1 = address of x
    ld   $y, r2              # r2 = address of y
    ld   $data, r4           # r4 = address of data  
    
    ld   (r0), r5            # r5 = i value
    ld   (r4, r5, 4), r6     # r6 = data[i]

    inc  r5                  # r5 = i + 1
    ld   (r4, r5, 4), r7     # r7 = data[i+1]

    add  r6, r7              # r7 = data[i] + data[i+1]
    st   r7, (r2)            # y = data[i] + data[i+1]

    ld   $0xff, r5           # r5 = 0xff
    and  r5, r7              # r7 = y & 0xff
    st   r7, (r1)            # x = y & 0xff

    halt                     # halt

.pos 0x1000
i: .long 0x00000001
.pos 0x2000
x: .long 0x00000017
.pos 0x3000
y: .long 0x00000013
.pos 0x4000
data: .long 0x00000011
      .long 0x00000012
      .long 0x00000013
      .long 0x00000014