-- Generates a .c file that outputs a Lua script with C constants

local const_file = select(1, ...)
local c_file = select(2, ...)
local lua_file = select(3, ...)

if not const_file or not c_file or not lua_file then
  print("Syntax: lua constants.lua <constants_file> <c_file> <lua_file>")
  os.exit(1)
end

c_file = io.open(c_file, "w+")

local prologue = true

for line in io.lines(const_file) do
  if line:match("^%s*#include") then
    c_file:write(line .. '\n')
  elseif not line:match("^%s*$") then
    if prologue then
      prologue = false
      c_file:write('#define LUA_FILE "' .. lua_file .. '"\n')
      c_file:write[[
#include <stdio.h>
int main() {
  FILE *f = fopen(LUA_FILE, "w+");
]]
    end
    local var, val = line:match("([_%a]+)%s*=%s*(.+)$")
    if not var then
      var, val = line, line
    end
    c_file:write([[
  fprintf(f, "%s = %i\n", "]] .. var .. [[", ]] .. val .. [[);
]])
  end
end

c_file:write[[
  fclose(f);
}
]]

c_file:close()
