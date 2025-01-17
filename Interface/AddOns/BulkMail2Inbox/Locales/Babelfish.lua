#!/usr/local/bin/lua

-- CONFIG --

--[[
	The name of the AceLocale-3.0 Category, as being used in :NewLocale and :GetLocale
]]
local localeName = "BulkMailInbox"

--[[
	Prefix to all files if this script is run from a subdir, for example
]]
local filePrefix = "../"

--[[
	List of all files to parse
]]
local files = {
   "BulkMailInbox.lua", 
}

--[[
	The Language your addon was originally written in
]]
local baseLocale = "enUS"

--[[
	The supported Languages
	-- DO NOT INCLUDE the base locale here!
]]
local locale = {
--	"deDE",
--	"frFR",
--	"esES",
--	"esMX",
--	"zhCN",
--	"zhTW",
--	"koKR",
--	"ruRU"
}
-- CODE --

local strings = {}

-- extract data from specified lua files
for idx,filename in pairs(files) do
	local file = io.open(string.format("%s%s", filePrefix or "", filename), "r")
	assert(file, "Could not open " .. filename)
	local text = file:read("*all")

	for match in string.gmatch(text, "L%[\"(.-)\"%]") do
		strings[match] = true
	end
end

local work = {}

for k,v in pairs(strings) do table.insert(work, k) end
table.sort(work)

local AceLocaleHeader = "local L ="
local BabbleFishHeader = "L = {} -- "

local function replaceHeader(content)
	return content:gsub(AceLocaleHeader, BabbleFishHeader):gsub("\\", "\\\\"):gsub("\\\"", "\\\\\"")
end

local localizedStrings = {}

table.insert(locale, baseLocale)
-- load existing data from locale files
for idx, lang in ipairs(locale) do
	local file = io.open(lang .. ".lua", "r")
	assert(file, "Could not open ".. lang .. ".lua for reading")
	local content = file:read("*all")
	content = replaceHeader(content)
	assert(loadstring(content))()
	localizedStrings[lang] = L
	file:close()
end

-- Write locale files
for idx, lang in ipairs(locale) do
	local file = io.open(lang .. ".lua", "w")
	assert(file, "Could not open ".. lang .. ".lua for writing")
	file:write("-- Generated by Babelfish script, do not add strings manually, only translate existing strings.\n")
	if lang == baseLocale then
		file:write("-- This is the base locale; values can be \"true\" so they default to their key, or any string to override that behaviour.\n")
		file:write(string.format("local L = LibStub(\"AceLocale-3.0\"):NewLocale(\"%s\", \"%s\", true)\n", localeName, lang))
		file:write("\n")
	else
		file:write("-- Please make sure to save the file as UTF-8, BUT WITHOUT THE UTF-8 BOM HEADER; ¶\n")
		file:write(string.format("local L = LibStub(\"AceLocale-3.0\"):NewLocale(\"%s\", \"%s\")\n", localeName, lang))
		file:write("if not L then return end\n")
	end
	file:write("\n")
	local L = localizedStrings[lang]
	for idx, match in ipairs(work) do
		if type(L[match]) == "string" then
			file:write(string.format("L[\"%s\"] = \"%s\"\n", match, L[match]))
		else
			if lang ~= baseLocale then
				local value = type(localizedStrings[baseLocale][match]) == "string" and localizedStrings[baseLocale][match] or "true"
				file:write(string.format("-- L[\"%s\"] = %s\n", match, value))
			else
				file:write(string.format("L[\"%s\"] = true\n", match))
			end
		end
	end
	file:close()
end
