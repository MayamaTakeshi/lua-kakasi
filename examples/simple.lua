local iconv = require("iconv")

-- kakasi gets stuck if I send utf-8 to it so I am using iconv to convert it to euc-jp.

-- Create a converter from utf-8 to euc-jp
local utf8_to_euc = iconv.new("EUC-JP", "UTF-8")

local utf8_string = "ハロー. こんにちは. This is a test for kakasi: 群馬県の有名なご当地料理."
print("utf-8 : " .. utf8_string)

-- Convert to EUC-JP
local euc_string, err = utf8_to_euc:iconv(utf8_string)

if err then
    print("Conversion error:", err)
end

print("euc-jp: " .. euc_string)

local kakasi = require("lua-kakasi")

local options = "-s -Ha -Ka -Ja"
local result = kakasi.convert(euc_string, options)

print("romaji: " .. result)
