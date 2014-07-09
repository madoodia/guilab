import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1

import List 1.0
import Miller 1.0

import "../utils"

Item {
	id: root
	width: 600
	height: 500

	property var activeMiller_header: []
	property var activeMiller_index: []
	// title: "Miller Column"
	// flags: Qt.FramelessWindowHint | Qt.Window
	// color: "transparent"
	// visible: false
	property var oldObjects: []
	property string baseHeader: 'Header'
	property real mySize: 150


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
				spacing: 1

				ColumnLayout {
					// Layout.alignment: Qt.AlignLeft | Qt.AlignTop
					spacing: 0
					RowLayout {
						id: baseRow
						// Layout.alignment: Qt.AlignLeft
						spacing: 0

						ListView {
							id: listView
							anchors.fill: parent
							clip: true
							orientation: ListView.Horizontal

							Component.onCompleted: {
								activeMiller_header = createMiller()
							}

							model: activeMiller_header
							
							delegate: View {}
							spacing: 0
						}
						// View {
						// 	id: lv1
						// 	depthLevel: 0
						// 	headerTxt: baseHeader
						// 	light: 1
						// }
					}
				}
				// ColumnLayout {
				// 	Layout.alignment: Qt.AlignLeft | Qt.AlignTop
				// 	spacing: 0
				// 	OuterBevelFrame {
				// 	    width: 50
				// 	    height: flick.height
				// 	}
				// }
			}
		}
	}

	List {
		id: mainList
		Component.onCompleted: {
			init()
			// print(mainList.header)
			baseHeader = header
		}
	}

	Miller {
		id: mainMiller
		Component.onCompleted: {
			init()
		}
	}

	function createMiller() {
		var _list = []
		for(var i=0;i < mainMiller.lists.length;i++){
			_list[i] = mainMiller.lists[i].header
			activeMiller_header[i] = mainMiller.lists[i].index
			print(_list[i])
		}
		return _list
	}


	function createView(xPos, depth){
		var component
		var dynamic
		component = Qt.createComponent("../utils/View.qml")
		dynamic = component.createObject(baseRow)
		dynamic.x = xPos
		dynamic.depthLevel = depth
		dynamic.headerTxt = mainList.header
		// root.width += 202
		oldObjects[oldObjects.length] = dynamic
		mySize += 150

	}

	function destroyViews(depth){
		for(var i=0;i < oldObjects.length;i++){
			print(oldObjects[i])
			if(oldObjects[i].depthLevel >= depth){
				oldObjects[i].destroy()
				mySize -= 150
			}
		}
	}
}
