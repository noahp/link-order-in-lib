# Link order in static libs with weak symbols in objects

There are several configurations that are demonstrated here:

```bash
# 1. foo.a is foo_weak.a + foo_strong.a, no additional special arguments
# WEAK is selected
❯ make && ./build/main 2
Compiling main.c
Compiling foo_weak.c
Compiling foo_strong.c
Creating build/foo.a
Linking main
cc -Wall -Wextra -Werror -g -o build/main -L. build/main.o build/foo.a
Calling foo from file foo_weak.c
foo(2) = 2

# 2. foo.a is foo_strong.a + foo_weak.a, no additional special arguments. use
# 'nm build/foo.a' to see the order in the archive.
# STRONG is selected
❯ FOO_OBJS="foo_strong.o foo_weak.o" make && ./build/main 2
Compiling main.c
Compiling foo_strong.c
Compiling foo_weak.c
Creating build/foo.a
Linking main
cc -Wall -Wextra -Werror -g -o build/main -L. build/main.o build/foo.a
Calling foo from file foo_strong.c
foo(2) = 4

# 3. foo.a is foo_weak.a + foo_strong.a, -Wl,--whole-archive encloses the foo.a
# linker input.
# STRONG is selected
❯ USE_WHOLE_ARCHIVE=1 make && ./build/main 2
Compiling main.c
Compiling foo_weak.c
Compiling foo_strong.c
Creating build/foo.a
Linking main
cc -Wall -Wextra -Werror -g -o build/main -L. build/main.o -Wl,--whole-archive build/foo.a -Wl,--no-whole-archive
Calling foo from file foo_strong.c
foo(2) = 4

# 4. foo.a is foo_strong.a + foo_weak.a, -Wl,--start-group encloses all linker
# inputs.
# WEAK is selected!!!
❯ USE_LINK_GROUPS=1 make && ./build/main 2
Compiling main.c
Compiling foo_weak.c
Compiling foo_strong.c
Creating build/foo.a
Linking main
cc -Wall -Wextra -Werror -g -o build/main -L. -Wl,--start-group build/main.o build/foo.a -Wl,--end-group
Calling foo from file foo_weak.c
foo(2) = 2
```
