##### Available defines for CJSON_CFLAGS #####
##
## USE_INTERNAL_ISINF:      Workaround for Solaris platforms missing isinf().
## DISABLE_INVALID_NUMBERS: Permanently disable invalid JSON numbers:
##                          NaN, Infinity, hex.
##
## Optional built-in number conversion uses the following defines:
## USE_INTERNAL_FPCONV:     Use builtin strtod/dtoa for numeric conversions.
## IEEE_BIG_ENDIAN:         Required on big endian architectures.
## MULTIPLE_THREADS:        Must be set when Lua CJSON may be used in a
##                          multi-threaded application. Requries _pthreads_.

##### Build defaults #####
LUA_VERSION =       5.1
TARGET =            cmsgpack.so
PREFIX =            /usr/local
#CFLAGS =            -g -Wall -pedantic -fno-inline
CFLAGS =            -O3 -Wall -pedantic -DNDEBUG
CJSON_CFLAGS =      -fpic
CJSON_LDFLAGS =     -shared
LUA_INCLUDE_DIR =   $(PREFIX)/include
LUA_CMODULE_DIR =   $(PREFIX)/lib/lua/$(LUA_VERSION)
LUA_MODULE_DIR =    $(PREFIX)/share/lua/$(LUA_VERSION)
LUA_BIN_DIR =       $(PREFIX)/bin


##### End customisable sections #####

DATAPERM =          644
EXECPERM =          755

ASCIIDOC =          asciidoc

BUILD_CFLAGS =      -I$(LUA_INCLUDE_DIR) $(CJSON_CFLAGS)
OBJS =              lua_cmsgpack.o
.PHONY: all clean install

%.o: %.c
	$(CC) -c $(CFLAGS) $(BUILD_CFLAGS) -o $@ $<

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CJSON_LDFLAGS) -o $@ $(OBJS)

install: $(TARGET)
	mkdir -p $(DESTDIR)/$(LUA_CMODULE_DIR)
	cp $(TARGET) $(DESTDIR)/$(LUA_CMODULE_DIR)
	chmod $(EXECPERM) $(DESTDIR)/$(LUA_CMODULE_DIR)/$(TARGET)

clean:
	rm -f *.o $(TARGET)
