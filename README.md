# lua-kakasi
A lua extension for KAKASI (Kanji Kana Simple Inverter)

## Installation

You need to have libkakasi2-dev installed:
```
sudo apt install libkakasi2-dev
```
Then do:
```
sudo luarocks install lua-kakasi
```

## Usage examples

See [examples](https://github.com/MayamaTakeshi/lua-kakasi/edit/main/examples)

Just run
```
lua examples/simple.lua
```
or
```
lua examples/multithread.lua
```

Sample execution output:
```
$ lua examples/simple.lua 
utf-8 : ハロー. こんにちは. This is a test for kakasi: 群馬県の有名なご当地料理.
euc-jp: �ϥ���. ����ˤ���. This is a test for kakasi: ���ϸ���ͭ̾�ʤ���������.
romaji: haro^ . konnichiha . This is a test for kakasi: gunmaken no yuumei nago touchi ryouri .
```

