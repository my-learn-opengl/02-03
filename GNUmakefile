TARGET := hello-window
PHONY_TARGETS := all prelude clean

SRCS := $(shell find src -type f -name \*.c)
OBJS := $(patsubst src/%.c,tmp/obj/%.o,$(SRCS))

CPPFLAGS := -Iinclude -DNDEBUG $(shell PKG_CONFIG_PATH="external/lib/pkgconfig" pkg-config --cflags glfw3)
LDFLAGS := -Lexternal/lib -lglfw3 -framework Cocoa -framework OpenGL -framework IOKit
CFLAGS := -O

$(PHONY_TARGETS):
.PHONY: $(PHONY_TARGETS)

prelude: external
external:
	sh ./init.sh

all: $(TARGET)
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

./tmp/obj/%.o: ./src/%.c
	mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

.PHONY: clean_obj
clean: clean_obj
clean_obj:
	rm -rf ./tmp/obj

.PHONY: clean_output
clean: clean_output
clean_output:
	rm -f $(TARGET)
