package = "AIO"

version = "scm-1"

description = {
  summary = "Lua Threads with Asynchronous IO",
  detailed = [[
  AIO implements asynchronous I/O primitives on top of
  POSIX's O_NONBLOCK, plus a threading library that integrates
  with the I/O primitives and uses Libevent.
  ]],
  license = "MIT/X11",
  homepage = "http://alien.luaforge.net/aio"
}

dependencies = { "alien", "bitlib" }

external_dependencies = {
 platforms = {
  unix = {
    LIBEVENT = { header = "event.h" }
  }
 }
}

source = {
   url = "git://github.com/mascarenhas/thread.git"
}

build = {
   type = "make",
   install_variables = {
      LUA_DIR = "$(LUADIR)",
      PREFIX = "$(PREFIX)"
   },
   build_variables = {
      CONSTANTS = "$(CONSTANTS_DIR)/constants",
      CFLAGS = "$(CFLAGS)",
      LIBEVENT_INCDIR = "$(LIBEVENT_INCDIR)"
   }
}
