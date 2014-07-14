import QtQuick 2.0
import QtQuick.Layouts 1.1


Item {
    id: listViewRoot

    property var delegate_name: []
    property var delegate_objetcs: []

    property int depthLevel: 0

    property var headerTxt: 'Header'
    property int light: 0
    property int pIndex
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
                    // mainController.lists[index].here_in_list()
                    pIndex = index
                }

                model: delegate_name
                
                delegate: DelegateItem {
                    parentIndex: pIndex
                }
                spacing: 0

                // populate: Transition {
                //     NumberAnimation { properties: "y"; duration: 100 }
                // }
                
                // add: Transition {
                //     NumberAnimation { properties: "x"; duration: 1000 }
                // }
                // remove: Transition {
                //     ParallelAnimation {
                //         NumberAnimation { property: "opacity"; to: 0; duration: 1000 }
                //         NumberAnimation { properties: "x,y"; to: 100; duration: 1000 }
                //     }
                // }
                footer: GhostItem {}
            }
        }
    }

    function updateList() {
        var _list = []
        for(var j=0;j < mainController.lists[index].delegates.length;j++){
            delegate_objetcs[j] = mainController.lists[index].delegates[j]
            _list[j] = delegate_objetcs[j].name
            // print(delegate_index[j] + " : " + _list[j])
        }
        return _list
    }

}