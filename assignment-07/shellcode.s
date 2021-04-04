  ld $7, r1  # r1 = size = 7
  gpc $2, r0
  j 8 (r0)
  .long 0x2f62696e    #/bin
  .long 0x2f736800    #/sh
  sys $2      # system call: exec
  halt
