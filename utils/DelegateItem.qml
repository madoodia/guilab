import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.1

import "../contents"

Item {
    id: btnDelegate
    property string buttonColor: "#4b4b4b"
    // property string label: 'Hello World!'
    property bool mainEnabled: true
    property int textWidth: 0
    property int parentIndex
    width: ourHeader.width
    height: 25
    enabled: mainEnabled

    OuterBevelFrame {
        id: buttonFrame
        bgColor: btnDelegate.buttonColor
        width: parent.width
        height: parent.height
        Text {
            id: btnLabel
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            text: modelData
            color: '#fefefe'
            font.family: 'Consolas'
            Component.onCompleted: {
                textWidth = width
            }
        }
        Image {
            id: expandBg
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 3
            width: 16
            height: 16
            source: "../contents/button_expand.png"
        }

        MouseArea {
            id: buttonMouse
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                buttonColor = "#656565"
            }
            onExited: {
                buttonColor = "#4b4b4b"
            }
            onClicked: {
                // print(parentIndex + " : " + index)
                // print(delegate_objetcs[index].index)
                // print(list_objects[parentIndex])
                delegate_objetcs[index].selected_event(delegate_objetcs[index].index)
                list_header = root.updateMiller()
                // mainController.printLists()
            }
        }
    }
}