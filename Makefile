.SILENT:

BUILDDIR = build

CFLAGS += \
  -Wall \
  -Wextra \
  -Werror \
  -g

ifeq ($(USE_LINK_GROUPS),1)
START_GROUP := -Wl,--start-group
END_GROUP := -Wl,--end-group
endif

ifeq ($(USE_WHOLE_ARCHIVE),1)
START_WHOLE_ARCHIVE := -Wl,--whole-archive
END_WHOLE_ARCHIVE := -Wl,--no-whole-archive
endif

$(BUILDDIR)/main: $(BUILDDIR)/main.o $(BUILDDIR)/foo.a
	echo "Linking main"
	echo $(CC) $(CFLAGS) -o $@ -L. $(START_GROUP) $< $(START_WHOLE_ARCHIVE) $(BUILDDIR)/foo.a $(END_WHOLE_ARCHIVE) $(END_GROUP)
	$(CC) $(CFLAGS) -o $@ -L. $(START_GROUP) $< $(START_WHOLE_ARCHIVE) $(BUILDDIR)/foo.a $(END_WHOLE_ARCHIVE) $(END_GROUP)

$(BUILDDIR)/%.o: %.c
	mkdir -p $(BUILDDIR)
	echo "Compiling $<"
	$(CC) $(CFLAGS) -c $< -o $@

# To test order of .o's in .a, change the order in this variable
FOO_OBJS ?= foo_weak.o foo_strong.o

$(BUILDDIR)/foo.a: $(FOO_OBJS:%=$(BUILDDIR)/%)
	mkdir -p $(BUILDDIR)
	echo "Creating $@"
	ar rcs $@ $^
