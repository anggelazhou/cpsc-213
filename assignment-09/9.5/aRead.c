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
volatile int pending_reads;

void interrupt_service_routine () {
    void* val;
    void (*callback)(void*,void*);
    queue_dequeue (pending_read_queue, &val, NULL, &callback);
    callback (val, NULL);
}

void handle_read (void* resultv, void* not_used) {
    // TODO add result to sum
    int* tmp = resultv;
    sum += *tmp;
}

void handle_n_terminate (void* resultv, void* not_used) {
    handle_read(resultv, NULL);
    pending_reads = -1;
}


int main (int argc, char** argv) {

    // Command Line Arguments
    static char* usage = "usage: aRead num_blocks";
    int num_blocks;
    char *endptr;
    if (argc == 2)
        num_blocks = strtol (argv [1], &endptr, 10);
    if (argc != 2 || *endptr != 0) {
        printf ("argument error - %s \n", usage);
        return EXIT_FAILURE;
    }


    // Initialize
    uthread_init (2);
    disk_start (interrupt_service_routine);
    pending_read_queue = queue_create();
    pending_reads = num_blocks;

    int rsf[num_blocks];

    for (int i = 0; i < num_blocks; i++) {
        void (*handler) (void*, void*) = handle_n_terminate;
        if (i < num_blocks - 1) handler = handle_read;
        queue_enqueue (pending_read_queue, &rsf[num_blocks], NULL, handler);
        disk_schedule_read (&rsf[num_blocks], i);
    }

    // polling loop so that main doesn't return before all of the reads complete
    while (pending_reads > 0);

    printf ("%d\n", sum);
}



