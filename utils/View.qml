import QtQuick 2.0
import QtQuick.Layouts 1.1


Item {
	id: listViewRoot

	property var activeList_name: []
	property var activeList_path: []
	property var activeList_depth: []

	property int depthLevel: 0

	property var headerTxt: 'Header'
	property int maxTextWidth: 0
	
	width: maxTextWidth
	height: 500

	ColumnLayout {
		id: ui
		width: parent.width
		height: parent.height
		spacing: 0
		Layout.alignment: Qt.AlignHCenter
		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			width: parent.width
			height: 20
			MillerHeader {
				id: ourHeader
				label: headerTxt
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
		for(var i=0;i < mainMiller.contents.length;i++){
			_list[i] = mainMiller.contents[i].content_name
			activeList_path[i] = mainMiller.contents[i].content_path
			activeList_depth[i] = mainMiller.contents[i].depth
		}
		return _list
	}

}