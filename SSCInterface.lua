local terminal = {}

function terminal.getWidth()
	local handle = io.popen("tput cols")
	terminal.width = handle:read("*a")
	handle:close()
	terminal.width = string.gsub(terminal.width, "\n", "")
end

function terminal.getHeight()
	local handle = io.popen("tput lines")
	terminal.height = handle:read("*a")
	handle:close()
	terminal.height = string.gsub(terminal.height, "\n", "")
end

function terminal.getSize()
	terminal.getWidth()
	terminal.getHeight()
end