#include "foo.h"

#include <assert.h>
#include <stdio.h>

int main(int argc, char **argv) {
  if (argc != 2) {
    printf("Usage: %s <integer>\n", argv[0]);
    return 1;
  }
  // convert argv[1] to an integer
  int yolo = 0;
  sscanf(argv[1], "%d", &yolo);

  // call foo with that integer
  int result = foo(yolo);
  printf("foo(%d) = %d\n", yolo, result);
  return 0;
}
