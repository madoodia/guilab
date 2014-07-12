import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1
import "../contents"
import "../utils"
import "../miller"


ApplicationWindow {
	id: root
	width: 700
	height: 400
	title: "Miller Column"
	flags: Qt.FramelessWindowHint | Qt.Window
	// maximumHeight: 500
	// maximumWidth: 700
	// minimumHeight: 500
	// minimumWidth: 700
	color: "transparent"
	// visible: false

	Item {
		id: main
		// visible: false
		anchors.centerIn: parent
		width: parent.width
		height: parent.height

		OuterBevelFrame {
			id: base
			width: parent.width
			height: parent.height
			// Rectangle {
			//     width: parent.width
			//     height: parent.height
			//     color: "green"
			// }

			ColumnLayout {
				id: ui
				width: parent.width
				height: parent.height
				spacing: 1
				Layout.alignment: Qt.AlignHCenter | Qt.AlignHCenter
				RowLayout {
					id: header
					Layout.maximumHeight: 30
					Layout.maximumWidth: parent.width - 5
					MouseArea {
						anchors.fill: header
						property real lastMouseX: 0
						property real lastMouseY: 0
						acceptedButtons: Qt.LeftButton
						onPressed: {
							if(mouse.button == Qt.LeftButton){
								parent.forceActiveFocus()
								lastMouseX = mouseX
								lastMouseY = mouseY
							}
						}
						onMouseXChanged: root.x += (mouseX - lastMouseX)
						onMouseYChanged: root.y += (mouseY - lastMouseY)
					}
					Text {
						text: 'Dash'
						anchors.left: parent.left
						// anchors.top: parent.top
						anchors.right: parent.right
						// anchors.bottom: parent.bottom
						anchors.margins: 7
						color: 'white'
                    	font.family: 'Consolas'

					}
					ColumnLayout {
						width: parent.width
						Layout.alignment: Qt.AlignRight
						RowLayout {
							Image {
								id: helpBg
								source: "../contents/button_help.png"
								MouseArea {
									id: helpBtn
									anchors.fill: parent
									// onClicked: Qt.quit()
								}
							}
							Image {
								id: minimizeBg
								source: "../contents/button_minimise.png"

								MouseArea {
									id: minimizeBtn
									anchors.fill: parent
									onClicked: root.visibility = Window.Minimized
								}
							}
							Image {
								id: closeBg
								source: "../contents/button_close.png"
								MouseArea {
									id: closeBtn
									anchors.fill: parent
									onClicked: Qt.quit()
								}
							}
						}
					}
				}
				RowLayout {
					id: page
					Layout.maximumHeight: parent.height-30
					Layout.alignment: Qt.AlignHCenter | Qt.AlignHCenter
					spacing: 0
					MillerItem {
						id: m
						width: page.width
						height: page.height
					}
				}
			}
		}
	}
}