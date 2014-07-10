import QtQuick 2.0
import QtQuick.Layouts 1.1


Item {
    id: listViewRoot

    property var delegate_name: []
    property var delegate_index: []
    // property var activeList_depth: []

    property int depthLevel: 0

    property var headerTxt: 'Header'
    property int light: 0
    // property int maxTextWidth: 0
    
    width: 150
    height: 500

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
                    delegate_name = updateList()
                }

                model: delegate_name
                
                delegate: Delegate {}
                spacing: 0

                // populate: Transition {
                //     NumberAnimation { properties: "y"; duration: 100 }
                // }
            }
        }
    }

    function updateList() {
        var _list = []
        for(var j=0;j < mainMiller.lists[index].delegates.length;j++){
            _list[j] = mainMiller.lists[index].delegates[j].name
            delegate_index[j] = mainMiller.lists[index].delegates[j].index
            // print(delegate_index[j] + " : " + _list[j])
        }
        return _list
    }

}