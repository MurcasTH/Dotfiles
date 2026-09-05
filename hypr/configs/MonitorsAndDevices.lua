-----------------
--- Variables ---
-----------------

local prefferedScale = 1.0
local debugModeInactive = false

-----------------
--- Functions ---
-----------------
local function configureMonitors()
	local nextMonitorOffsetWidth = 0
	local nextMonitorOffsetHeight = 0

	for _, monitor in ipairs(hl.get_monitors()) do
		-- Format String for monitor position e.g. "2560x0"
		local positionString = string.format("%dx%d", nextMonitorOffsetWidth, nextMonitorOffsetHeight)

		-- Debug prints (doesn't show unless debugModeInactive is fasle)
		print("========== APPLYING MONITOR ==========")
		print("Monitor:", monitor.name)
		print("Current scale:", monitor.scale)
		print("Requested scale:", prefferedScale)
		print("Current Position:", string.format("%dx%d", monitor.position.x, monitor.position.y))
		print("Requested Position", positionString)

		hl.monitor({
			output = monitor.name,
			mode = "preffered",
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
	output = hl.get_monitors()[1].name, -- First Monitor [1]
})
