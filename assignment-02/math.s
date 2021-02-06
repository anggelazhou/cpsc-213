.pos 0x100
    ld   $a, r0              # r0 = address of a
    ld   $b, r1              # r1 = address of b

    ld   (r1), r3            # r3 = b
    inc  r3                  # r3 = b+1
    inca r3                  # r3 = (b+1) + 4
    shr  $0x0001, r3         # r3 / 2 
    ld   (r1), r2            # r2 = b
    and  r2, r3              # r3 & b
    shl  $0x0002, r3         # r3 << 2 

    st r3, (r0)              # a = r3

    halt                     # halt

.pos 0x1000
a: .long 0xffffffff
.pos 0x2000
b: .long 0x00000017