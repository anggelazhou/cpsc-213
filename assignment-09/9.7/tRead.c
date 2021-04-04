#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <sys/errno.h>
#include <assert.h>
#include "queue.h"
#include "disk.h"
#include "uthread.h"

queue_t      pending_read_queue;
unsigned int sum = 0;
int * ipointer;
uthread_t* uthreads;

void interrupt_service_routine () {
  // TODO
  void * blocki;
  queue_dequeue(pending_read_queue, &blocki, NULL, NULL);
  uthread_t t = uthreads[*((int *)blocki)];
  uthread_unblock(t);
}

void* read_block (void* blocknov) {
  // TODO schedule read and the update (correctly)
  int result;
  disk_schedule_read(&result, *((int *)blocknov));

  // uthread_t t = uthread_self(); 
  // printf("block thread addr = %p\n", &t);
  
  uthread_block();
  sum += result;
  return NULL;
} 

int main (int argc, char** argv) {

  // Command Line Arguments
  static char* usage = "usage: tRead num_blocks";
  int num_blocks;
  char *endptr;
  if (argc == 2)
    num_blocks = strtol (argv [1], &endptr, 10);
  if (argc != 2 || *endptr != 0) {
    printf ("argument error - %s \n", usage);
    return EXIT_FAILURE;
  }

  ipointer = malloc (num_blocks * sizeof(int));


  // Initialize
  uthread_init (1);
  disk_start (interrupt_service_routine);
  pending_read_queue = queue_create();

  // Sum Blocks
  // TODO
  uthreads = malloc (num_blocks * sizeof(uthread_t));
  for (int i = 0; i < num_blocks; i++) {
    ipointer[i] = i;
    queue_enqueue(pending_read_queue, ipointer+i, NULL, NULL);
    uthreads[i] = uthread_create (read_block, & ipointer[i]);
  }

  for (int i = 0; i < num_blocks; i++) {
     uthread_join(uthreads[i], 0);
  }

  free(uthreads);
  free(ipointer);

  printf ("%d\n", sum);
}

