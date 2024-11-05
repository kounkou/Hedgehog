import QtQuick 2.15

QtObject {
    id: themeObject
    
    property string theme: "light"

    property color backgroundColor:         theme === "light" ? "#F6F6F6" : "#000000"   // Off-white for light theme, softer dark for dark theme
    property color textColor:               theme === "light" ? "#202020" : "#E0E0E0"  // Dark grey for light theme, light grey for dark theme

    property color buttonBorderColor:       theme === "light" ? "#E0E0E0" : "#424242"  // Slightly darker grey for light theme, less harsh dark grey for dark theme
    property color buttonColor:             theme === "light" ? "#E0E0E0" : "#323232"  // Softer grey for light theme, lighter grey for dark theme
    property color buttonHoveredColor:      theme === "light" ? "#D8D8D8" : "#606060"  // More muted hover effect for both themes
    property color buttonClickedColor:      theme === "light" ? "#C8C8C8" : "#787878"  // Softer click colors for both themes
    property color buttonEasyColor:         theme === "light" ? "#B8DFC6" : "#4D8F6B"  // Softer green for both themes
    property color buttonMediumColor:       theme === "light" ? "#F5DD9F" : "#C29915"  // Softer yellow for both themes
    property color buttonHardColor:         theme === "light" ? "#F49B96" : "#D84D4D"  // Softer red for both themes
    property color buttonActionColor:       theme === "light" ? "#3A80FA" : "#3A80FA"
    property color submitHoveredColor:      theme === "light" ? "#3A80FA" : "#3A80FA"
    property color buttonSubmitColor:       theme === "light" ? "#3A80FA" : "#3A80FA"
    
    property color categoryColor:           theme === "light" ? "#E0E0E0" : "#424242"

    property color textAreaBackgroundColor: theme === "light" ? "#EFEFEF" : "#4A4A4A"  // Light grey for light theme, lighter grey for dark theme
    property color textExpectedAnswerColor: theme === "light" ? "#006400" : "#32CD32"  // Muted green for light, slightly softer green for dark
    property color textAreaBorderColor:     theme === "light" ? "#CCCCCC" : "#444444"  // Less contrast in borders
    
    property color codeTextColor:           theme === "light" ? "#333333" : "#E0E0E0"  // Dark grey for light theme, soft grey for dark theme

    property color averageLineColor:        theme === "light" ? "#2E7D32" : "#66BB6A"
    
    property color buttonDownColor:         theme === "light" ? "#CCCCCC" : "#CCCCCC"
    property color buttonUpColor:           theme === "light" ? "#FFFFFF" : "#FFFFFF"

}
