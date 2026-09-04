-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("awww-init")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("awww restore")
	hl.exec_cmd("wal -R")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
	hl.exec_cmd("qs") -- Launch Quickshell
	hl.exec_cmd("fcitx5 -d")
	hl.exec_cmd(
		"mako --default-timeout=5000 --ignore-timeout=1 --max-visible=4 --max-history=10 --anchor=top-right --layer=overlay"
	)
end)
