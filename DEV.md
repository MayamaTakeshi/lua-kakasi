# Build and install during dev work
```
$ gcc -O2 -fPIC -I /usr/include/lua5.1/ lua-kakasi.c -o lua-kakasi.so -shared -lkakasi -llua
$ cp lua-kakasi.so /usr/local/lib/lua/5.1/
```

# Manual Test
```
$ lua examples/simple.lua 
utf-8 : ハロー. こんにちは. This is a test for kakasi: 群馬県の有名なご当地料理.
euc-jp: ϥ. . This is a test for kakasi: ̾ʤ.
romaji: haro^ . konnichiha . This is a test for kakasi: gunmaken no yuumei nago touchi ryouri .
```






