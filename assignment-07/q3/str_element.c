#include <stdlib.h>
#include <stdio.h>

#include "str_element.h"
#include "refcount.h"

/* TODO: Implement all public str_element functions, including element interface functions.

You may add your own private functions here too. */

/* Forward reference to a str_element. You get to define the structure. */
struct str_element_class {
  void (*print)(struct str_element *);
  void (*compare)(struct str_element *, struct str_element *);
  int type;
};

struct str_element {
  struct str_element_class *class;
  char    *c;
};

void str_element_print(struct str_element * s_element) {
  printf("%s", s_element->c);
}

int str_element_compare(struct str_element * s_e1, struct str_element * s_e2) {
  int i = 0;
  while (1) {
      char c1 = s_e1->c[i];
      char c2 = s_e2->c[i];

      if (c1 == '\0') {
          return c2 == '\0' ? 0 : -1;
      } else if (c2 == '\0') {
          return 1;
      } else {
          int k = (int) c1 - (int) c2;
          if (k != 0) {
              return k;
          } else {
              i++;
          }
      }
  }
}

struct str_element_class  str_element_class= {str_element_print, str_element_compare, 1};

void str_element_finalizer(void * p) {
    struct str_element * s_e = p;
    free(s_e->c);
}

/* Static constructor that creates new string elements. */
struct str_element *str_element_new(char *value) {
    struct str_element *obj = rc_malloc(sizeof(struct str_element), str_element_finalizer);
    obj->class = &str_element_class;
    obj->c     = malloc(sizeof(value)+1);
    for ( char *p = obj->c; ( *p = *value ) != '\0'; ++p, ++value );
    rc_keep_ref(obj->c);
    return obj;
}

/* Static function that obtains the string from a str_element. The caller should keep_ref it. */
char *str_element_get_value(struct str_element * s_element) {
    return s_element->c;
}

/* Static function that determines whether this is a str_element. */
int is_str_element(struct element * element) {
    return ((struct str_element *)element)->class->type == 1;
}