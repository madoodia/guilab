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
	signal clicked()
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
			// 	buttonColor = 
			// }
			onReleased: {
				buttonColor = "#537f3f"
			}
			onClicked: {
				// remove_item(modelData)
				// listView.model = activeList
				// print(mainList.contents[index].content_path)
				// print(activeList_name[index])
				
				// 1: Fill Contents
				mainList.fill_contents(activeList_path[index], activeList_depth[index])
				
				// 2: Destroy Items
				destroyViews(Number(activeList_depth[index]))

				// 3: Create New Blocks
				createView(150 * (1 + Number(activeList_depth[index])),Number(activeList_depth[index]))

				// print(textWidth)
			}
		}
	}
}