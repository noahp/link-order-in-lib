#include "foo.h"

#include <stdio.h>

__attribute__((weak)) int foo(int yolo) {
  printf("Calling foo from file " __FILE__ "\n");
  return yolo;
}
