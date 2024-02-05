#include "foo.h"

#include <stdio.h>

int foo(int yolo) {
  printf("Calling foo from file " __FILE__ "\n");
  return yolo * 2;
}
