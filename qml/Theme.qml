// Theme.qml
import QtQuick 2.15

QtObject {
    id: themeObject
    
    property string theme: "dark"

    property color backgroundColor:         theme === "light" ? "#FFFFFF" : "#121212"  // White for light theme, dark for dark theme
    property color textColor:               theme === "light" ? "#000000" : "#FFFFFF"  // Black for light theme, white for dark theme
    property color buttonBorderColor:       theme === "light" ? "#DDDDDD" : "#333333"  // Light grey border for light theme, dark grey for dark theme
    property color buttonColor:             theme === "light" ? "#E8E8E8" : "#3C3C3C"  // Light grey for light, darker grey for dark theme
    property color textAreaBackgroundColor: theme === "light" ? "#E8E8E8" : "#3C3C3C"  // Light grey for light theme, dark grey for dark theme
    property color buttonHoveredColor:      theme === "light" ? "#D0D0D0" : "#505050"  // Lighter grey for light theme, slightly lighter grey for dark theme
    property color buttonClickedColor:      theme === "light" ? "#C0C0C0" : "#686868"  // Darker grey for light theme, lighter grey for dark theme when clicked
    property color buttonEasyColor:         theme === "light" ? "#A8D5BA" : "#38755B"  // Light green for light theme, darker green for dark theme
    property color buttonMediumColor:       theme === "light" ? "#F1D18A" : "#B18504"  // Light yellow for light theme, darker yellow for dark theme
    property color buttonHardColor:         theme === "light" ? "#F28B82" : "#D32F2F"  // Light red for light theme, darker red for dark theme
    property color textExpectedAnswerColor: theme === "light" ? "#008000" : "#00FF00"  // Dark green for light theme, bright green for dark theme
    property color textAreaBorderColor:     theme === "light" ? "#DDDDDD" : "#333333"  // Light grey border for light theme, dark grey for dark theme
    property color codeTextColor:           theme === "light" ? "#000000" : "#FFFFFF"  // Dark brown for light theme, gold for dark theme
}
