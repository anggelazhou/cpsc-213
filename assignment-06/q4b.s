.pos 0x100
start:
    ld   $sb, r5         # r5 = &sb (stack)
    inca r5              # r5 = pop stack
    gpc  $6, r6          # r6 = ra = pc + 6
    j    main            # goto main
    halt

f:
    deca r5              # claim room for 1 item on sb
    ld   $0, r0          # r0 = 0 (= index??)
    ld   4(r5), r1       # r1 = arguement
    ld   $0x80000000, r2 # r2 = 0x80000000
f_loop:
    beq  r1, f_end       # if r1 (arguement) = 0, goto f_end
    mov  r1, r3          # else, r3 = arguement
    and  r2, r3          # r3 = 0x80000000 & arguement
    beq  r3, f_if1       # if r3 = 0, go to f_if1
    inc  r0              # 0++ (i++??)
f_if1:
    shl  $1, r1          # r1 = r1 (arguement) * 2
    br   f_loop          # goto f_loop
f_end:
    inca r5              # pop stock
    j    (r6)            # return

main:
    deca r5              # claim room for 1 item on sb
    deca r5              # claim room for 1 more item on sb
    st   r6, 4(r5)       # save return address to bottom of stack sb (sb[0])
    ld   $8, r4          # r4 = 8
main_loop:
    beq  r4, main_end    # if r4 = 0, goto main_end
    dec  r4              # else, r4--
    ld   $x, r0          # r0 = &x
    ld   (r0, r4, 4), r0 # r0 = x[r4]
    deca r5              # claim room for 1 more item on sb
    st   r0, (r5)        # store r0 = x[r4] to top of stack
    gpc  $6, r6          # r6 = ra = pc + 6
    j    f               # jump to f
    inca r5              # pop sb
    ld   $y, r1          # r1 = &y
    st   r0, (r1, r4, 4) # y[r4] = r0 (from f)
    br   main_loop       # goto main_loop
main_end:
    ld   4(r5), r6       # retrieve saved return address from bottom of stack
    inca r5              # pop stack
    inca r5              # pop stack
    j    (r6)            # return 

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long -1
    .long -2
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0

