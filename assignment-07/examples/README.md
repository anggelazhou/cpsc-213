# System call to write

<table><tr><th>C</th><th>Assembly</th><tr><tr valign='top'><td>

```c
#include <unistd.h>

int main() {
  write(1, "hello world\n", 12);
}
```

</td><td>

```ASM
.pos 0x1000
  ld $1, r0   # r0 = fd = 1 (standard out)
  ld $str, r1 # r1 = buffer 
  ld $12, r2  # r2 = length of string
  sys $1      # system call: write
  halt

.pos 0x2000
str:
  .long 0x68656c6c # hell
  .long 0x6f20776f # o wo
  .long 0x726c640a # rld\n
```

</td></tr></table>

# System call to read/write

<table><tr><th>C</th><th>Assembly</th><tr><tr valign='top'><td>

```c
#include <unistd.h>

char buf[16];
int main() {
  read(0, buf, 16);
  write(1, buf, 16);
}
```

</td><td>

```ASM
.pos 0x1000
  ld $0, r0   # r0 = fd = 0 (standard in)
  ld $buf, r1 # r1 = buf
  ld $16, r2  # r2 = size
  sys $0      # system call: read

  ld $1, r0   # r0 = fd = 1 (standard out)
  ld $buf, r1 # r1 = buf
  ld $16, r2  # r2 = size
  sys $1      # system call: write
  halt

.pos 0x2000
buf:
  .long 0
  .long 0
  .long 0
  .long 0
```

</td></tr></table>

# System call to read/write again

<table><tr><th>C</th><th>Assembly</th><tr><tr valign='top'><td>

```c
#include <unistd.h>

char buf[16];
int main() {
  read(0, buf, 16);
  write(1, buf, 16);
}
```

</td><td>

```ASM
.pos 0x1000
start:
  ld $stacktop, r5
  gpc $6, r6
  j main
  halt

main:
  ld $-16, r0
  add r0, r5

  ld $0, r0   # r0 = fd = 0 (standard in)
  mov r5, r1  # r1 = buf (on stack)
  ld $16, r2  # r2 = size
  sys $0      # system call: read

  ld $1, r0   # r0 = fd = 1 (standard out)
  mov r5, r1  # r1 = buf (on stack)
  ld $16, r2  # r2 = size
  sys $1      # system call: write

  ld $16, r0
  add r0, r5
  j (r6)

.pos 0x3000
stack:
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
stacktop:
  .long 0
```

</td></tr></table>

# System execution

<table><tr><th>C</th><th>Assembly</th><tr><tr valign='top'><td>

```c
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/* simulate exec using the C function system */
/* this function is not in the assembly */
int exec(char *buffer, int size) {
  /* buffer might not be null-terminated, but system() wants a null-terminated string,
     so our emulated exec adds null-termination here using a temporary variable */
  char *str = malloc(size + 1);
  memcpy(str, buffer, size);
  str[size] = 0;
  int res = system(str);
  free(str);
  return res;
}

char buf[64];
int main() {
  int size = read(0, buf, sizeof(buf));
  exec(buf, size);
}
```

</td><td>

```ASM
.pos 0x1000
  ld $0, r0   # r0 = fd = 0 (standard in)
  ld $buf, r1 # r1 = buf
  ld $64, r2  # r2 = size
  sys $0      # system call: read

  mov r0, r1  # r1 = size = read return value
  ld $buf, r0 # r0 = buf
  sys $2      # system call: exec
  halt

.pos 0x2000
buf:
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
```

</td></tr></table>

