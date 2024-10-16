import QtQuick 2.15

QtObject {
    id: themeObject
    
    property string theme: "dark"

    property color backgroundColor:         theme === "light" ? "#F7F7F7" : "#1C1C1C"  // Off-white for light theme, softer dark for dark theme
    property color textColor:               theme === "light" ? "#202020" : "#E0E0E0"  // Dark grey for light theme, light grey for dark theme
    property color buttonBorderColor:       theme === "light" ? "#CCCCCC" : "#444444"  // Slightly darker grey for light theme, less harsh dark grey for dark theme
    property color buttonColor:             theme === "light" ? "#E0E0E0" : "#4A4A4A"  // Softer grey for light theme, lighter grey for dark theme
    property color textAreaBackgroundColor: theme === "light" ? "#EFEFEF" : "#4A4A4A"  // Light grey for light theme, lighter grey for dark theme
    property color buttonHoveredColor:      theme === "light" ? "#D8D8D8" : "#606060"  // More muted hover effect for both themes
    property color buttonClickedColor:      theme === "light" ? "#C8C8C8" : "#787878"  // Softer click colors for both themes
    property color buttonEasyColor:         theme === "light" ? "#B8DFC6" : "#4D8F6B"  // Softer green for both themes
    property color buttonMediumColor:       theme === "light" ? "#F5DD9F" : "#C29915"  // Softer yellow for both themes
    property color buttonHardColor:         theme === "light" ? "#F49B96" : "#D84D4D"  // Softer red for both themes
    property color textExpectedAnswerColor: theme === "light" ? "#006400" : "#32CD32"  // Muted green for light, slightly softer green for dark
    property color textAreaBorderColor:     theme === "light" ? "#CCCCCC" : "#444444"  // Less contrast in borders
    property color codeTextColor:           theme === "light" ? "#333333" : "#E0E0E0"  // Dark grey for light theme, soft grey for dark theme
}
