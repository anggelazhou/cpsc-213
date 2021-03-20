#include <stdlib.h>
#include <stdio.h>

#include "int_element.h"
#include "refcount.h"

/* TODO: Implement all public int_element functions, including element interface functions.

You may add your own private functions here too. */

/* Forward reference to a int_element. You get to define the structure. */
struct int_element_class {
  void (*print)(struct element *);
  void (*compare)(struct element *, struct element *);
};

struct int_element {
  struct int_element_class *class;
  int    i;
};

void int_element_print(struct element * element) {
  if (is_int_element(element)) {
      struct int_element * i_element = element;
      printf("%d", i_element->i);
  } else {
      element->class->print(element);
  }
}

int int_element_compare(struct element * e1, struct element * e2) {
      if (is_int_element(e1)) {
        if (is_int_element(e2)) {
          struct int_element *i_e1 = e1;
          struct int_element *i_e2 = e2;
          return i_e1->i - i_e2->i;
        } else {
            return -1;
        }
    } else {
        if (is_int_element(e2)) {
            return 1;
        } else {
            return e1->class->compare(e1, e2);
        }
    }
}

struct int_element_class  int_element_class= {int_element_print, int_element_compare};

void int_element_finalizer(void * p) {
   // struct int_element * i_e = p;
    // free(i_e);
}

/* Static constructor that creates new integer elements. */
struct int_element *int_element_new(int value) {
    struct int_element *obj = rc_malloc(sizeof(struct int_element), int_element_finalizer);
    obj->class = &int_element_class;
    obj->i     = value;
    return obj;
}

/* Static function that obtains the value held in an int_element. */
int int_element_get_value(struct int_element * i_element) {
    return i_element->i;
}

/* Static function that determines whether this is an int_element. */
int is_int_element(struct element * element) {
    return ((struct int_element *)element)->class == &int_element_class;
}
