#include "lib/utils.h"

#include <cstdio>

auto main() -> int {
  double const x = 4.0;
  printf("The square of %f is %f.\n", x, square(x));
  return 0;
}
