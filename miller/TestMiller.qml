import QtQuick 2.0

import Miller 1.0

import "../utils"

Item {
	id: root
	width: 600
	height: 500
	property var activeMiller_header: []
	property var activeMiller_index: []

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
		spacing: 5
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

}