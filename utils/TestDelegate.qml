import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

Item {
    width: 700
    height: 300

	Rectangle {
	    width: parent.width
	    height: parent.height
	    color: "gray"
		Button {
			anchors.centerIn: parent
			text: 'Apply'
		    style: ButtonStyle {
		    	background: Rectangle {
		    	    width: parent.width
		    	    height: parent.height
		    	    color: "#707070"
		    	    border.color: "#454545"
		    	}
		    }
		}
	}
}