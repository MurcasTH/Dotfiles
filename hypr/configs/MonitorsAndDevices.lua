-----------------
--- Variables ---
-----------------

local prefferedScale = 1.0
local debugModeInactive = true

-----------------
--- Functions ---
-----------------
local function getBestMode(monitor)
	local bestMode = nil
	for _, mode in ipairs(monitor.available_modes) do
		if bestMode == nil then
			bestMode = mode
		else
			local pixels = mode.width * mode.height
			local bestPixels = bestMode.width * bestMode.height

			if pixels > bestPixels or (pixels == bestPixels and mode.refresh_rate > bestMode.refresh_rate) then
				bestMode = mode
			end
		end
	end
	return bestMode
end

local function configureMonitors()
	local nextMonitorOffsetWidth = 0
	local nextMonitorOffsetHeight = 0
	for _, monitor in ipairs(hl.get_monitors()) do
		local mode = getBestMode(monitor)
		if mode == nil then
			print("No valid mode for:", monitor.name)
			return
		end

		-- Format String monitor resolution and framerate e.g. "1920x1080@60.02"
		local modeString = string.format("%dx%d@%.3f", mode.width, mode.height, mode.refresh_rate)
		local positionString = string.format("%dx%d", nextMonitorOffsetWidth, nextMonitorOffsetHeight)

		print("========== APPLYING MONITOR ==========")
		print("Monitor:", monitor.name)
		print("Current scale:", monitor.scale)
		print("Requested scale:", prefferedScale)
		print("Requested mode:", modeString)

		hl.monitor({
			output = monitor.name,
			mode = modeString,
			position = positionString,
			scale = 1,
		})
		nextMonitorOffsetWidth = nextMonitorOffsetWidth + monitor.width
	end
end

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- debug mode
hl.config({
	debug = {
		disable_logs = debugModeInactive,
	},
})

hl.on("config.reloaded", function()
	configureMonitors()
end)

hl.on("hyprland.start", function()
	configureMonitors()
end)

hl.on("monitor.added", function()
	configureMonitors()
end)

hl.device({
	name = "wacom-intuos-m-pen",
	output = hl.get_monitors()[1].name, -- First Monitor
})
