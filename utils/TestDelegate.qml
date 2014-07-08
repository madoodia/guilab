import QtQuick 2.0

Item {
    width: 100
    height: 300

	Rectangle {
	    width: parent.width
	    height: parent.height
	    color: "green"
	    border.color: "black"

	    Text {
	    	text: modelData
	    }
	}
}