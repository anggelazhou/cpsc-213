#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/errno.h>
#include <assert.h>
#include "uthread.h"
#include "queue.h"
#include "disk.h"

queue_t pending_read_queue;
volatile int pending_reads;

void interrupt_service_routine() {
  // TODO
  void* val;
  void (*callback)(void*,void*);
  queue_dequeue (pending_read_queue, &val, NULL, &callback);
  callback (val, NULL); 
}

void handleOtherReads(void *resultv, void *countv) {
  // TODO
  pending_reads = 0;
}

void handleFirstRead(void *resultv, void *countv) {
  // TODO
  pending_reads = 0;

}

int main(int argc, char **argv) {
  // Command Line Arguments
  static char* usage = "usage: treasureHunt starting_block_number";
  int starting_block_number;
  char *endptr;
  if (argc == 2)
    starting_block_number = strtol (argv [1], &endptr, 10);
  if (argc != 2 || *endptr != 0) {
    printf ("argument error - %s \n", usage);
    return EXIT_FAILURE;
  }

  // Initialize
  uthread_init (1);
  disk_start (interrupt_service_routine);
  pending_read_queue = queue_create();

  // Start the Hunt
  // TODO
  // get first value
  int firstValue;
  void (*handler) (void*, void*) = handleFirstRead;
  pending_reads = 1;
  queue_enqueue (pending_read_queue, &firstValue, NULL, handler);
  disk_schedule_read (&firstValue, starting_block_number);
  while (pending_reads);

  // get other values
  int prevValue = firstValue;
  int otherValue;
  for (int i = 0; i < firstValue; i++) {
    void (*handler) (void*, void*) = handleOtherReads;
    pending_reads = 1;
    queue_enqueue (pending_read_queue, &otherValue, NULL, handler);
    disk_schedule_read (&otherValue, otherValue);
    while (pending_reads);
    prevValue = otherValue;
  }

  printf ("%d\n", otherValue); 
}
