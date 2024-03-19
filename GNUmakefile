TARGET := hello-window
PHONY_TARGETS := all prelude clean

SRCS := $(shell find src -type f -name \*.c)
OBJS := $(patsubst src/%.c,tmp/obj/%.o,$(SRCS))

CPPFLAGS := -Iinclude -DNDEBUG $(shell PKG_CONFIG_PATH="external/lib/pkgconfig" pkg-config --cflags-only-I glfw3)
LDFLAGS := -framework Cocoa -framework OpenGL -framework IOKit $(shell PKG_CONFIG_PATH="external/lib/pkgconfig" pkg-config --libs glfw3)
CFLAGS := -O $(shell PKG_CONFIG_PATH="external/lib/pkgconfig" pkg-config --cflags-only-other glfw3)

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
