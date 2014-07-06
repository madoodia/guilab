import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1

import MillerLogic 1.0

import "../utils"

Item {
	id: root
	width: 605
	height: 500
	// title: "Miller Column"
	// flags: Qt.FramelessWindowHint | Qt.Window
	// color: "transparent"
	// visible: false
	property var oldObjects: []
	property string baseHeader: 'Header'
	property real mySize: 1000

	InnerBevelFrame {
		id: mainBG
		anchors.centerIn: parent
		width: parent.width-15
		height: parent.height-15
		
		// color: "white"
		Flickable {
			id: flick
			width: parent.width-1
			height: parent.height-1
			anchors.centerIn: parent
		    contentWidth: mySize
		    contentHeight: 1000
		    clip: true
		    // boundsBehavior: Flickable.DragOverBounds
		    flickableDirection: Flickable.HorizontalFlick

		    // rebound: Transition {
		    //     NumberAnimation {
		    //         properties: "x"
		    //         duration: 1000
		    //         easing.type: Easing.OutBounce
		    //     }
		    // }
			RowLayout {
				id: mainRow
				// height: parent.height
				// Layout.alignment: Qt.AlignLeft | Qt.AlignTop
				spacing: 0

				ColumnLayout {
					// Layout.alignment: Qt.AlignLeft | Qt.AlignTop
					spacing: 0
					RowLayout {
						id: baseRow
						// Layout.alignment: Qt.AlignLeft
						spacing: 1
						View {
							id: lv1
							depthLevel: 0
							headerTxt: baseHeader
						}
					}
				}
				ColumnLayout {
					Layout.alignment: Qt.AlignLeft | Qt.AlignTop
					spacing: 0
					OuterBevelFrame {
					    width: 50
					    height: flick.height
					}
				}
			}
		}
	}

	Miller {
		id: mainMiller

		Component.onCompleted: {
			fill_contents('', -1)
			baseHeader = header
		}
	}

	function createView(xPos, depth){
		var component
		var dynamic
		component = Qt.createComponent("../utils/View.qml")
		dynamic = component.createObject(baseRow)
		dynamic.x = xPos
		dynamic.depthLevel = depth
		dynamic.headerTxt = mainMiller.header
		// root.width += 202
		oldObjects[oldObjects.length] = dynamic
		mySize += 200

	}

	function destroyViews(depth){
		for(var i=0;i < oldObjects.length;i++){
			print(oldObjects[i])
			if(oldObjects[i].depthLevel >= depth){
				oldObjects[i].destroy()
				mySize -= 200
			}
		}
	}
}
