package = "lua-kakasi"
version = "1.0.0-0"
source = {
   url = "https://github.com/MayamaTakeshi/lua-kakasi/archive/refs/tags/1.0.0-0.tar.gz",
   dir = "lua-kakasi",
}
description = {
   summary = "A Lua extension module for kakasi",
   detailed = "",
   license = "MIT",
   homepage = "https://github.com/MayamaTakeshi/lua-kakasi",
}
dependencies = {
   "lua >= 5.1",
   "lua-iconv",
}
build = {
   type = "builtin",
   modules = {
      ["lua-kakasi"] = {
         sources = {
            "lua-kakasi.c",
         },
	 libraries = { "kakasi" },
	 build = {
	     make = "make",
         },
      },
   },
}
