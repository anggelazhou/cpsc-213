.pos 0x100
        ld $tmp, r0         # r0 = address of tmp
        ld $0, r1           # r1 = 0 
        st r1, (r0)         # tmp = 0

        ld $tos, r0         # r0 = address of tos
        st r1, (r0)         # tos = 0

        ld $a, r2           # r2 = address of a 
        ld (r2, r1, 4), r3  # r3 = a[0]
        ld $s, r4           # r4 = address of s
        ld (r0), r5         # r5 = tos
        st r3, (r4, r5, 4)  # s[tos] = a[0]

        inc r5              # tos++
        
        ld $1, r1           # r1 = 1 
        ld (r2, r1, 4), r3  # r3 = a[1]
        ld $s, r4           # r4 = address of s
        st r3, (r4, r5, 4)  # s[tos] = a[1]

        inc r5              # tos++
        
        ld $2, r1           # r1 = 2 
        ld (r2, r1, 4), r3  # r3 = a[2]
        ld $s, r4           # r4 = address of s
        st r3, (r4, r5, 4)  # s[tos] = a[2]

        inc r5              # tos++

        dec r5              # tos--

        ld (r4, r5, 4), r3  # r3 = s[tos]
        ld $tmp, r6         # r6 = address of tmp
        ld r6, r7           # r7 = tmp
        st r3, (r7)         # tmp = s[tos]

        dec r5              # tos--

        ld (r4, r5, 4), r3  # r3 = s[tos]
        ld $tmp, r6         # r6 = address of tmp
        ld (r6), r7         # r7 = tmp
        add r3, r7          # r7 = tmp + s[tos]
        st r7, (r6)         # tmp = tmp + s[tos]

        dec r5              # tos--

        ld (r4, r5, 4), r3  # r3 = s[tos]
        ld $tmp, r6         # r6 = address of tmp
        ld 0(r6), r7        # r7 = tmp
        add r3, r7          # r7 = tmp + s[tos]
        st r7, (r6)         # tmp = tmp + s[tos]

        halt                # halt

.pos 0x1000
tmp: .long 0x00000001
.pos 0x2000
tos: .long 0x00000010
.pos 0x3000
s: .long 0x00000011
   .long 0x00000012
   .long 0x00000013
   .long 0x00000014
   .long 0x00000015
.pos 0x4000
a: .long 0x00000016
   .long 0x00000017
   .long 0x00000018