import QtQuick 2.0

import "../contents"

Item {
	id: header
	property alias label: headerLabel.text
	property alias enableLight: light.opacity
	width: 150
	height: 25

	OuterBevelFrame {
		id: headerFrame
		width: parent.width
		height: parent.height
		Text {
			id: headerLabel
			// anchors.left: parent.left
			anchors.centerIn: parent
			// anchors.margins: 5
			text: 'Header Here'
			color: '#fefefe'
		}
		Rectangle {
			id: light
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			anchors.rightMargin: 10
		    width: 6
		    height: 6
		    color: "lawngreen"
		    opacity: 0
		}
	}
}