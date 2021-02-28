```c
// implicit.c
static int block_is_in_use(void *block_start)
static int get_block_size(void *block_start)
static int get_payload_size(void *block_start)
static void *get_block_start(void *payload)
static void *get_payload(void *block_start)
static void set_block_header(void *block_start, int block_size, int in_use)
static void *get_next_block(void *block_start)
static void *get_previous_block(void *block_start)
static int is_first_block(struct heap *h, void *block_start)
static int is_last_block(struct heap *h, void *block_start)
static int is_within_heap_range(struct heap *h, void *addr)
struct heap *heap_create(unsigned int size)

void *mymalloc(struct heap *h, voi)

static int get_size_to_allocate(int user_size)
static void *split_and_mark_used(struct heap *h, void *block_start, int needed_size)
static void *coalesce(struct heap *h, void *first_block_start)
void myfree(struct heap *h, void *payload)
```

