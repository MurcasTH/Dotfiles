pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // -------------------------------------------------------------------------
    // Layout
    // -------------------------------------------------------------------------

    readonly property int windowWidth: 720
    readonly property int windowHeight: 520

    readonly property int outerMargin: 16
    readonly property int windowRadius: 22
    readonly property int rowHeight: 54
    readonly property int rowRadius: 14
    readonly property int iconSize: 30

    // -------------------------------------------------------------------------
    // Existing colors
    // Kept unchanged for compatibility with existing components.
    // -------------------------------------------------------------------------

    readonly property color background: "#11111b"
    readonly property color foreground: "#cdd6f4"
    readonly property color mutedForeground: "#7f849c"
    readonly property color searchBackground: "#181825"
    readonly property color selectedBackground: "#313244"
    readonly property color borderColor: "#45475a"
    readonly property color accent: "#89b4fa"

    // -------------------------------------------------------------------------
    // Tokyo Night base palette
    // -------------------------------------------------------------------------

    readonly property color tokyoBackgroundDark: "#16161e"
    readonly property color tokyoBackground: "#1a1b26"
    readonly property color tokyoSurface: "#24283b"
    readonly property color tokyoSurfaceLight: "#292e42"
    readonly property color tokyoSurfaceHighlight: "#3b4261"

    readonly property color tokyoForeground: "#c0caf5"
    readonly property color tokyoForegroundDark: "#a9b1d6"
    readonly property color tokyoComment: "#565f89"
    readonly property color tokyoDarkComment: "#414868"

    readonly property color tokyoBlue: "#7aa2f7"
    readonly property color tokyoLightBlue: "#7dcfff"
    readonly property color tokyoCyan: "#2ac3de"
    readonly property color tokyoTeal: "#73daca"
    readonly property color tokyoGreen: "#9ece6a"
    readonly property color tokyoYellow: "#e0af68"
    readonly property color tokyoOrange: "#ff9e64"
    readonly property color tokyoRed: "#f7768e"
    readonly property color tokyoMagenta: "#bb9af7"
    readonly property color tokyoPurple: "#9d7cd8"

    // -------------------------------------------------------------------------
    // General surfaces
    // -------------------------------------------------------------------------

    readonly property color windowBackground: tokyoBackground
    readonly property color panelBackground: tokyoSurface
    readonly property color elevatedBackground: tokyoSurfaceLight
    readonly property color overlayBackground: "#cc16161e"

    readonly property color hoverBackground: tokyoSurfaceLight
    readonly property color pressedBackground: tokyoSurfaceHighlight
    readonly property color activeBackground: tokyoSurfaceHighlight
    readonly property color disabledBackground: "#1f2335"

    readonly property color separatorColor: "#2f3549"
    readonly property color subtleBorderColor: "#292e42"
    readonly property color strongBorderColor: tokyoSurfaceHighlight

    readonly property color shadowColor: "#80000000"

    // -------------------------------------------------------------------------
    // Text
    // -------------------------------------------------------------------------

    readonly property color primaryForeground: tokyoForeground
    readonly property color secondaryForeground: tokyoForegroundDark
    readonly property color tertiaryForeground: tokyoComment
    readonly property color placeholderForeground: tokyoComment
    readonly property color disabledForeground: "#3b4261"

    readonly property color selectedForeground: tokyoForeground
    readonly property color inverseForeground: tokyoBackgroundDark

    readonly property color linkForeground: tokyoBlue
    readonly property color linkHoverForeground: tokyoLightBlue
    readonly property color linkVisitedForeground: tokyoPurple

    // -------------------------------------------------------------------------
    // Focus and selection
    // -------------------------------------------------------------------------

    readonly property color focusColor: tokyoBlue
    readonly property color focusRingColor: tokyoLightBlue

    readonly property color selectionBackground: tokyoSurfaceHighlight
    readonly property color selectionForeground: tokyoForeground

    readonly property color highlightBackground: "#364a82"
    readonly property color highlightForeground: tokyoForeground

    // -------------------------------------------------------------------------
    // Search and input fields
    // -------------------------------------------------------------------------

    readonly property color inputBackground: tokyoBackgroundDark
    readonly property color inputForeground: tokyoForeground
    readonly property color inputPlaceholderForeground: tokyoComment

    readonly property color inputBorderColor: tokyoDarkComment
    readonly property color inputHoverBorderColor: tokyoSurfaceHighlight
    readonly property color inputFocusBorderColor: tokyoBlue
    readonly property color inputErrorBorderColor: tokyoRed

    readonly property color searchForeground: tokyoForeground
    readonly property color searchPlaceholderForeground: tokyoComment
    readonly property color searchIconColor: tokyoForegroundDark

    // -------------------------------------------------------------------------
    // Rows and list items
    // -------------------------------------------------------------------------

    readonly property color rowBackground: "transparent"
    readonly property color rowHoverBackground: tokyoSurfaceLight
    readonly property color rowPressedBackground: tokyoSurfaceHighlight
    readonly property color rowSelectedBackground: tokyoSurfaceHighlight

    readonly property color rowForeground: tokyoForeground
    readonly property color rowSecondaryForeground: tokyoForegroundDark
    readonly property color rowSelectedForeground: tokyoForeground

    // -------------------------------------------------------------------------
    // Buttons
    // -------------------------------------------------------------------------

    readonly property color buttonBackground: tokyoSurfaceLight
    readonly property color buttonHoverBackground: tokyoSurfaceHighlight
    readonly property color buttonPressedBackground: "#4b5378"
    readonly property color buttonForeground: tokyoForeground
    readonly property color buttonBorderColor: tokyoDarkComment

    readonly property color primaryButtonBackground: tokyoBlue
    readonly property color primaryButtonHoverBackground: "#89b4fa"
    readonly property color primaryButtonPressedBackground: "#668ee3"
    readonly property color primaryButtonForeground: tokyoBackgroundDark

    readonly property color destructiveButtonBackground: tokyoRed
    readonly property color destructiveButtonHoverBackground: "#ff8da1"
    readonly property color destructiveButtonPressedBackground: "#d85f77"
    readonly property color destructiveButtonForeground: tokyoBackgroundDark

    // -------------------------------------------------------------------------
    // Status colors
    // -------------------------------------------------------------------------

    readonly property color infoColor: tokyoBlue
    readonly property color successColor: tokyoGreen
    readonly property color warningColor: tokyoYellow
    readonly property color errorColor: tokyoRed

    readonly property color infoBackground: "#23395d"
    readonly property color successBackground: "#2b4538"
    readonly property color warningBackground: "#4b3f2c"
    readonly property color errorBackground: "#4b2d3b"

    // -------------------------------------------------------------------------
    // Checkboxes, switches and radio buttons
    // -------------------------------------------------------------------------

    readonly property color controlBackground: tokyoBackgroundDark
    readonly property color controlBorderColor: tokyoDarkComment

    readonly property color controlHoverBorderColor: tokyoForegroundDark
    readonly property color controlCheckedBackground: tokyoBlue
    readonly property color controlCheckedForeground: tokyoBackgroundDark

    readonly property color switchTrackOffColor: tokyoDarkComment
    readonly property color switchTrackOnColor: tokyoBlue
    readonly property color switchHandleColor: tokyoForeground

    // -------------------------------------------------------------------------
    // Tooltips, menus and popups
    // -------------------------------------------------------------------------

    readonly property color popupBackground: tokyoSurface
    readonly property color popupForeground: tokyoForeground
    readonly property color popupBorderColor: tokyoSurfaceHighlight

    readonly property color menuBackground: tokyoSurface
    readonly property color menuHoverBackground: tokyoSurfaceLight
    readonly property color menuSelectedBackground: tokyoSurfaceHighlight
    readonly property color menuForeground: tokyoForeground

    readonly property color tooltipBackground: tokyoSurfaceHighlight
    readonly property color tooltipForeground: tokyoForeground
    readonly property color tooltipBorderColor: tokyoDarkComment

    // -------------------------------------------------------------------------
    // Scrollbars
    // -------------------------------------------------------------------------

    readonly property color scrollbarTrackColor: "transparent"
    readonly property color scrollbarHandleColor: tokyoDarkComment
    readonly property color scrollbarHandleHoverColor: tokyoSurfaceHighlight
    readonly property color scrollbarHandlePressedColor: tokyoForegroundDark

    // -------------------------------------------------------------------------
    // Progress indicators
    // -------------------------------------------------------------------------

    readonly property color progressTrackColor: tokyoSurfaceLight
    readonly property color progressFillColor: tokyoBlue
    readonly property color progressSuccessColor: tokyoGreen
    readonly property color progressWarningColor: tokyoYellow
    readonly property color progressErrorColor: tokyoRed

    // -------------------------------------------------------------------------
    // Icons
    // -------------------------------------------------------------------------

    readonly property color iconColor: tokyoForegroundDark
    readonly property color iconHoverColor: tokyoForeground
    readonly property color iconActiveColor: tokyoBlue
    readonly property color iconDisabledColor: tokyoDarkComment

    // -------------------------------------------------------------------------
    // Typography
    // -------------------------------------------------------------------------

    readonly property string fontFamily: "Inter"
    readonly property int appNameSize: 13
    readonly property int commentSize: 10
    readonly property int searchSize: 15

    // -------------------------------------------------------------------------
    // Applications
    // -------------------------------------------------------------------------

    readonly property string terminal: "foot"
}
