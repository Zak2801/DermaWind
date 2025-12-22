---------------------------------------------------------------
--  lua\autorun\zks_acs_loader.lua
---------------------------------------------------------------
ZKsDermaWind = ZKsDermaWind or {}
ZKsDermaWind.Loaded = false

function ZKsDermaWind.LoadDirectory(path)
	local files, folders = file.Find(path .. "/*", "LUA")

	for _, fileName in ipairs(files) do
		local filePath = path .. "/" .. fileName

		if CLIENT then
			include(filePath)
		else
			if fileName:StartWith("cl_") then
				AddCSLuaFile(filePath)
			elseif fileName:StartWith("sh_") then
				AddCSLuaFile(filePath)
				include(filePath)
			else
				include(filePath)
			end
		end
	end

	return files, folders
end

function ZKsDermaWind.LoadDirectoryRecursive(basePath)
	local _, folders = ZKsDermaWind.LoadDirectory(basePath)
	for _, folderName in ipairs(folders) do
		ZKsDermaWind.LoadDirectoryRecursive(basePath .. "/" .. folderName)
	end
end

ZKsDermaWind.LoadDirectoryRecursive("zks_dermawind")

local version = "v0.7"
MsgC( "\n", Color( 255, 255, 255 ), "---------------------------------- \n" )
MsgC( Color( 65, 215, 160 ), "[Zaktak's Dermawind Library]\n" )
MsgC( Color( 255, 255, 255 ), "Loading Files.......\n" )
MsgC( Color( 255, 255, 255 ), "Version........ "..version.."\n" )
MsgC( Color( 255, 255, 255 ), "---------------------------------- \n" )