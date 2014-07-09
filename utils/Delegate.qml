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
    width: ourHeader.width
    height: 25
    enabled: mainEnabled


    Button {
        id: buttonBg
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        enabled: mainEnabled

        style: ButtonStyle {
            background: OuterBevelFrame {
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
            }
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
            // onPressed: {
            //  buttonColor = 
            // }
            onReleased: {
                buttonColor = "#537f3f"
            }
            onClicked: {
                mainMiller.send_index(delegate_index[index])
                root.list_header = root.updateMiller()
            }
        }
    }
}