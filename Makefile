
CONSTANTS=constants

HOST_CC=gcc

all: src/aio_constants.lua src/event_constants.lua

src/aio_constants.lua: src/aio_constants
	cd src && ./aio_constants

src/aio_constants: src/aio_constants.c
	$(HOST_CC) -o src/aio_constants src/aio_constants.c

src/aio_constants.c: src/aio_constants.def
	$(CONSTANTS) src/aio_constants.def src/aio_constants.c aio_constants.lua

src/event_constants.lua: src/event_constants
	cd src && ./event_constants

src/event_constants: src/event_constants.c
	$(HOST_CC) -o src/event_constants -I$(LIBEVENT_INCDIR) src/event_constants.c

src/event_constants.c: src/event_constants.def
	$(CONSTANTS) src/event_constants.def src/event_constants.c event_constants.lua

install:
	cp src/*.lua $(LUA_DIR)
	mkdir -p $(LUA_DIR)/thread
	cp src/thread/*.lua $(LUA_DIR)/thread
	cp -r tests $(PREFIX)/

clean:
	rm -f src/event_constants src/event_constants.lua src/aio_constants src/aio_constants.lua src/event_constants.c src/aio_constants.c

