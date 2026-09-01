//@ pragma IconTheme adwaita

import Quickshell

import qs.bar as BarModule
import qs.launcher as LauncherModule
import qs.clock as ClockModule

ShellRoot {
    BarModule.Bar {}
    LauncherModule.Launcher {}
    ClockModule.Clock {}
}
