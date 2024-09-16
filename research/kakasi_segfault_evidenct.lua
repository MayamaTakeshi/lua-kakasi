--[[
This is a test i wrote to confirm kakasi is not thraed safe and crashes if we don't protect access to it with a mutex.
To test, lua-kakasi should not be installed in the system (do 'sudo luarocks remove lua-kakasi').
It expects lua-kakasi.so (built from lua-kakasi.c without mutex) to be present in the parent folder.
--]]
--
local iconv = require("iconv")

-- Create a converter from UTF-8 to EUC-JP (for example)
local utf8_to_euc = iconv.new("EUC-JP", "UTF-8")

-- UTF-8 string
local utf8_string = "ハロー. こんにちは. This is a test for kakasi: 群馬県の有名なご当地料理." 
print("utf-8  :" .. utf8_string)

-- Convert to EUC-JP
local euc_string, err = utf8_to_euc:iconv(utf8_string)

if err then
    print("Conversion error:", err)
end

print("euc-jp:" .. euc_string)

package_cpath = package.cpath .. ";../?.so"

local lanes = require "lanes".configure()

local results = {}

local f = lanes.gen("package", function(package_cpath, i, text)
	package.cpath = package_cpath

	local kakasi = require("lua-kakasi")

	local options = "-s -Ha -Ka -Ja"
	local result = kakasi.convert(text, options)
	return "romaji: " .. i .. " " .. result
end)

for i=1,100 do
	print(i)
	local res = f(package_cpath, i, euc_string)
	table.insert(results, res)
end

for i,v in ipairs(results) do
	print(v[1])
end

print("success")
