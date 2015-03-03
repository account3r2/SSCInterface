-- ######################################### --
-- ## (server)^2 Modification Core Plugin ## --
-- ##  Not intended to be run standalone. ## --
-- ##         Depends on the Core.        ## --
-- ######################################### --

local SSCI = {}				-- Main table.
SSCI.terminal = {}
SSCI.draw = {}

SSCI.title = "(server)^2 Modification Core"

if not unix then
	print("FATAL: Windows NT detected, exiting.")
	os.exit()
end

if not SSCore then
	print("FATAL: Dependency not found: serversquaredmodificationcore")
	os.exit()
end

if not colors then
	print("FATAL: Dependency not found: ansicolors")
	os.exit()
end

function SSCI.terminal.getWidth()
	local handle = io.popen("tput cols")
	SSCI.terminal.width = handle:read("*a")
	handle:close()
	SSCI.terminal.width = string.gsub(SSCI.terminal.width, "\n", blank)
end

function SSCI.terminal.getHeight()
	local handle = io.popen("tput lines")
	SSCI.terminal.height = handle:read("*a")
	handle:close()
	SSCI.terminal.height = string.gsub(SSCI.terminal.height, "\n", blank)
end

function SSCI.terminal.getSize()
	SSCI.terminal.getWidth()
	SSCI.terminal.getHeight()
end

function SSCI.terminal.clear()
	io.write("\027[2J")
end

function SSCI.terminal.setPos(line, col)
	if type(line) ~= "number" or type(col) ~= "number" then
		return
	end

	io.write("\027[" .. line .. ";" .. col .. "H")
end

function SSCI.terminal.savePos()
	io.write("\027[s")
end

function SSCI.terminal.restorePos()
	io.write("\027[u")
end

function SSCI.draw.bar()
	io.output(io.stdout)
	io.write(colors("%{reset reverse} " .. SSCI.title))

	for i = 1, math.floor(SSCI.terminal.width - (#SSCI.title + #SSCore.version.core + 4 + (SSCore.alpha and 6 or 0) + (SSCore.beta and 5 or 0))), 1 do
		io.write(colors("%{reset reverse} "))
	end

	io.write(colors("%{reset reverse} v" .. SSCore.version.core .. (SSCore.alpha and " Alpha" or blank) .. (SSCore.beta and " Beta" or blank) .. " %{reset}"))
end

function SSCI.draw.borders()
	io.output(io.stdout)

	io.write(colors("%{reset bright yellow reverse}CHAT"))

	for i = 1, math.ceil((SSCI.terminal.width / 2) - 5), 1 do
		io.write(colors("%{reset bright yellow reverse} "))
	end

	io.write(colors("%{reset bright}|"))

	SSCI.terminal.savePos()

	io.write(colors("%{reset bright magenta reverse}PLAYERS"))

	for i = 1, math.ceil((SSCI.terminal.width / 2) - 8), 1 do
		io.write(colors("%{reset bright magenta reverse} "))
	end

	SSCI.terminal.restorePos()

	for i = 1, math.floor(SSCI.terminal.height - 3), 1 do
		io.write(colors("\027[B\027[D%{reset bright}|"))

		if i == math.floor(SSCI.terminal.height / 2) then
			SSCI.terminal.savePos()

			for i = 1, math.ceil((SSCI.terminal.width / 2) - 1), 1 do
				io.write(colors("%{reset bright}-"))
			end

			SSCI.terminal.restorePos()

			io.write(colors("\027[B\027[D%{reset bright}|"))

			SSCI.terminal.savePos()

			io.write(colors("%{reset bright green reverse}SERVER"))

			for i = 1, math.ceil((SSCI.terminal.width / 2) - 7), 1 do
				io.write(colors("%{reset bright green reverse} "))
			end

			SSCI.terminal.restorePos()
		end
	end
end