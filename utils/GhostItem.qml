import QtQuick 2.0

Item {
    id: ghost
    width: 150
    height: 30

    Rectangle {
        id: rect
        anchors.fill: parent
        border.color: "#656565"
        border.width: 2
        color: "transparent"
        opacity: 0
        Text {
            anchors.centerIn: parent
            text: "+"
            color: "#656565"
            font.pixelSize: 20
            font.bold: true
        }
    }

    MouseArea {
        id: buttonMouse
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            rect.opacity = 1
        }
        onExited: {
            rect.opacity = 0
        }
        onClicked: {}
    }
}