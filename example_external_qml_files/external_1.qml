import QtQuick 2.14

// Import C++ data handlers
import DataManager 1.0

Rectangle {

    property string inputText: DataManager.getItem("ABC").id

    width: 100
    height: 100
    color: "blue" // CHANGE IT AND PRESS AGAIN THE LOAD BUTTONS

    Text {
        text: parent.inputText
        anchors.centerIn: parent
        font.pointSize: parent.height/10
        color: "white"
    }
}
