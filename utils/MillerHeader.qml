import QtQuick 2.0

import "../contents"

Item {
	id: header
	property alias label: headerLabel.text
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
			text: 'Hello World'
			color: '#fefefe'
		}
	}
}