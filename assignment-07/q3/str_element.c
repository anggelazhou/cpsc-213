#include <stdlib.h>
#include <stdio.h>

#include "str_element.h"
#include "refcount.h"

/* TODO: Implement all public str_element functions, including element interface functions.

You may add your own private functions here too. */

/* Forward reference to a str_element. You get to define the structure. */
struct str_element_class {
  void (*print)(struct element *);
  void (*compare)(struct element *, struct element *);
};

struct str_element {
  struct str_element_class *class;
  char    *c;
};

void str_element_print(struct element * element) {
  if (is_str_element(element)) {
      struct str_element * s_element = element;
      printf("%s", s_element->c);
  } else {
      element->class->print(element);
  }
  
}

int str_element_compare(struct element * e1, struct element * e2) {
    if (is_str_element(e1)) {
        if (is_str_element(e2)) {
            struct str_element *s_e1 = e1;
            struct str_element *s_e2 = e2;

            int i = 0;
            while (1) {
                char c1 = s_e1->c[i];
                char c2 = s_e2->c[i];

                if (c1 == '\0') {
                    return c2 == '\0' ? 0 : -1;
                } else if (c2 == '\0') {
                    return 1;
                } else {
                    int k = (int)c1 - (int)c2;
                    if (k != 0) {
                        return k;
                    } else {
                        i++;
                    }
                }
            }
        } else {
            return 1;
        }
    } else {
        if (is_str_element(e2)) {
            return -1;
        } else {
            return e1->class->compare(e1, e2);
        }
    }
}

struct str_element_class  str_element_class= {str_element_print, str_element_compare};

void str_element_finalizer(void * p) {
    struct str_element * s_e = p;
    free(s_e->c);
}

/* Static constructor that creates new string elements. */
struct str_element *str_element_new(char *value) {
    struct str_element *obj = rc_malloc(sizeof(struct str_element), str_element_finalizer);
    obj->class = &str_element_class;
    int len = strlen(value);
    obj->c     = malloc(len+1);
    strcpy(obj->c, value);
    // memcpy(obj->c, value, size);
    // obj->c[size] = 0;
    return obj;
}

/* Static function that obtains the string from a str_element. The caller should keep_ref it. */
char *str_element_get_value(struct str_element * s_element) {
    return s_element->c;
}

/* Static function that determines whether this is a str_element. */
int is_str_element(struct element * element) {
    return ((struct str_element *)element)->class == &str_element_class;
}
