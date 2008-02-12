
all: aio_constants.lua event_constants.lua

aio_constants.lua: aio_constants
	./aio_constants

aio_constants: aio_constants.c
	$(CC) -o aio_constants aio_constants.c

aio_constants.c: aio_constants.def
	constants aio_constants.def aio_constants.c aio_constants.lua

event_constants.lua: event_constants
	./event_constants

event_constants: event_constants.c
	$(CC) -o event_constants -I$(LIBEVENT_INCDIR) event_constants.c

event_constants.c: event_constants.def
	constants event_constants.def event_constants.c event_constants.lua

install:
	cp aio.lua thread.lua aio_constants.lua event_constants.lua $(LUA_DIR)

clean:
	rm -f event_constants event_constants.lua aio_constants aio_constants.lua *.c

upload:
	darcs dist -d aio-current
	ncftpput -u mascarenhas ftp.luaforge.net alien/htdocs aio-current.tar.gz
