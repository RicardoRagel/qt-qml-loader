import QtQuick 2.14
import QtQuick.Window 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

// Import C++ data handlers
import DataManager 1.0

// App Window
ApplicationWindow
{
    id: root
    property color appWindowColor:      Qt.rgba(30/255,30/255,30/255, 1)

    // Windows Configuration
    title: qsTr("App")
    visible: true
    visibility : Window.Maximized
    x: 0
    y: 0
    minimumWidth: Screen.width * 0.5
    minimumHeight: Screen.height * 0.75
    color: appWindowColor

    // Manage the app starup
    Component.onCompleted:
    {
    }

    /*
        CONTENT
    */
    Rectangle
    {
        id: appBackground
        visible: true
        anchors.fill: parent
        color: "transparent"

        Row
        {
            anchors.centerIn: parent
            spacing: 10

            property int rect_width: appBackground.width/8

            Rectangle
            {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.rect_width
                height: width

                color: DataManager.getItem("ABC").color

                Text
                {
                    anchors.centerIn: parent
                    font.pointSize: parent.height/10

                    text: DataManager.getItem("ABC").id
                }
            }

            /*
                EXAMPLE OF A DYNAMIC LOADER
                You can load here any other QML code, for example, the ones in
                the folder example_external_qml_files, that are not included in
                the project
            */
            Rectangle
            {
                id: loaderSpace
                width: parent.rect_width
                height: width

                color: "transparent"
                border.color: "white"
                border.width: 1

                Text
                {
                    id: helpText
                    anchors.centerIn: parent
                    text: qsTr("Press button to load a QML file")
                    color: "white"
                }

                Loader
                {
                    id: loader
                    anchors.centerIn: parent

                    width: parent.width
                    height: parent.height

                    function load(path)
                    {
                        console.log("Loading QML file: " + path)
                        var hackStr = "?"+Math.random();
                        loader.setSource(path+hackStr, {width: loaderSpace.width,
                                                        height: loaderSpace.height})
                    }
                }

                Button
                {
                    id: loaderButton
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    width: parent.width / 10
                    height: width

                    text: "L"

                    onClicked:
                    {
                        fileDialog.visible = true
                    }
                }
            }

        }//row
    }//background

    /*
        FILE DIALOG
        Use it to load any QML file
    */
    FileDialog
    {
        id: fileDialog
        title: "Please choose a QML file to be loaded"
        visible: false
        folder: shortcuts.home
        nameFilters: [ "QML files (*.qml)"]
        selectMultiple: false

        onAccepted:
        {
            console.log("You chose: " + fileDialog.fileUrl)

            loader.load(fileDialog.fileUrl)
        }
        onRejected:
        {
            console.log("Canceled")
        }
    }
}
