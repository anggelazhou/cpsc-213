#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/errno.h>
#include <assert.h>
#include "uthread.h"
#include "queue.h"
#include "disk.h"

queue_t pending_read_queue;
volatile int finished_last_read;

void interrupt_service_routine() {
  // TODO
  void* val;
  void* count;
  void (*callback)(void*,void*);
  queue_dequeue (pending_read_queue, &val, &count, &callback);
  callback (val, count); 
}

void handleOtherReads(void *resultv, void *countv) {
  // TODO
  int * result = resultv;
  // printf("whose value is %d\n", *result);
  int * count = countv;
  * count = ((* count) - 1);
  // printf("read # %d from block #%d ", *count, *result);
  if (*count == 0) {
    // end
    finished_last_read = 1;
  } else {
    void (*handler) (void*, void*) = handleOtherReads;
    queue_enqueue (pending_read_queue, result, count, handler);
    disk_schedule_read (result, * result);
  }
}

void handleFirstRead(void *resultv, void *countv) {
  // TODO
  int * result = resultv;
  int * count = countv;
  *count = * result;
  // printf("first result is = %d\n", *result);
  void (*handler) (void*, void*) = handleOtherReads;
  // printf("read # %d from block #%d ", *count, *result);
  queue_enqueue (pending_read_queue, result, count, handler);
  disk_schedule_read (result, *result);

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
  // printf("read first block = %d", starting_block_number);
  void (*handler) (void*, void*) = handleFirstRead;
  finished_last_read = 0;
  int count = 0;
  int value  = 0;
  queue_enqueue (pending_read_queue, &value, &count, handler);
  disk_schedule_read (&value, starting_block_number);
  while (!finished_last_read);

  printf ("%d\n", value); 
}
