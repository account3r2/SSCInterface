local SSCI = {}				-- Main table.
SSCI.terminal = {}
SSCI.draw = {}

SSCI.title = "(server)^2 Modification Interface"		-- Title of this modification.
SSCI.version = "1.0.0"									-- Version number of this modification.
SSCI.beta = false										-- If this build is a beta build.
SSCI.alpha = true										-- If this build is an alpha build.

local blank = ""
local space = " "

-- Load ansicolors
function reqansicolors()
	colors = require("ansicolors")
end
if not pcall(reqansicolors) then
	print("Dependency not found: ansicolors")
	os.exit()
end
reqansicolors = nil

function SSCI.terminal.getWidth()
	local handle = io.popen("tput cols")
	SSCI.terminal.width = handle:read("*a")
	handle:close()
	SSCI.terminal.width = string.gsub(SSCI.terminal.width, "\n", "")
end

function SSCI.terminal.getHeight()
	local handle = io.popen("tput lines")
	SSCI.terminal.height = handle:read("*a")
	handle:close()
	SSCI.terminal.height = string.gsub(SSCI.terminal.height, "\n", "")
end

function SSCI.terminal.getSize()
	SSCI.terminal.getWidth()
	SSCI.terminal.getHeight()
end

function SSCI.draw.bar()
	io.output(io.stdout)
	io.write(colors("%{reset reverse} " .. SSCI.title))

	for i = 1, math.floor(SSCI.terminal.width - (#SSCI.title + #SSCI.version + 4 + (SSCI.alpha and 6 or 0) + (SSCI.beta and 5 or 0))), 1 do
		io.write(colors("%{reset reverse} "))
	end

	io.write(colors("%{reset reverse} v" .. SSCI.version .. (SSCI.alpha and " Alpha" or blank) .. (SSCI.beta and " Beta" or blank) .. " %{reset}"))
end