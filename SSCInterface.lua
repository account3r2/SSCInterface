local SSCI = {}				-- Main table.
SSCI.terminal = {}

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