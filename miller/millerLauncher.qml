import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1

ApplicationWindow {
	id: root
	width: 600
	height: 300
	title: "Miller Column"
	flags: Qt.FramelessWindowHint | Qt.Window
	color: "transparent"

	// MillerView {}
	MillerItem {}
}