import QtQuick 2.0
import QtQuick.Layouts 1.1


Item {
	id: listViewRoot

	property var activeList_name: []
	property var activeList_index: []
	// property var activeList_depth: []

	property int depthLevel: 0

	property var headerTxt: 'Header'
	property int light: 0
	// property int maxTextWidth: 0
	
	width: 150
	height: 500
	Rectangle {
		width: parent.width
		height: parent.height
	    color: "green"
	    border.color: "black"
	}

	ColumnLayout {
		id: ui
		width: parent.width
		height: parent.height
		spacing: 0
		Layout.alignment: Qt.AlignHCenter
		RowLayout {
			// Layout.alignment: Qt.AlignHCenter
			width: parent.width
			height: 20
			MillerHeader {
				id: ourHeader
				label: modelData
				enableLight: light
				// width: parent.width
			}		
		}
		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			ListView {
				id: listView
				anchors.fill: parent
				clip: true

				Component.onCompleted: {
					activeList_name = createList()
				}

				model: activeList_name
				
				delegate: Delegate {}
				spacing: 0
			}
		}
	}

	function createList() {
		var _list = []
		for(var i=0;i < mainMiller.lists.length;i++){
			_list[i] = mainMiller.lists[i].name
			activeList_index[i] = mainMiller.lists[i].index
		}
		return _list
	}

}