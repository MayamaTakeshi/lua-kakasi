local iconv = require("iconv")

local utf8_to_euc = iconv.new("EUC-JP", "UTF-8")

local utf8_string = "ハロー. こんにちは. This is a test for kakasi: 群馬県の有名なご当地料理." 
print("utf-8 : " .. utf8_string)

local euc_string, err = utf8_to_euc:iconv(utf8_string)

if err then
    print("Conversion error:", err)
end

print("euc-jp: " ..  euc_string)

local lanes = require "lanes".configure()

local results = {}

local f = lanes.gen("package", function(i, text)
	local kakasi = require("lua-kakasi")

	local options = "-s -Ha -Ka -Ja"
	local result = kakasi.convert(text, options)
	return i .. " " .. result
end)

for i=1,100 do
	local res = f(i, euc_string)
	table.insert(results, res)	
end

for i,v in ipairs(results) do
	print("romaji: " .. v[1])
end

print("success")
