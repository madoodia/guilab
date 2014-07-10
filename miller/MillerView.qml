import QtQuick 2.0

import Miller 1.0

import "../utils"

Item {
    id: root
    width: 600
    height: 300
    property var list_header: []
    property var list_index: []

    InnerBevelFrame {
        id: mainBG
        anchors.centerIn: parent
        width: parent.width-15
        height: parent.height-15

        ListView {
            id: listView
            anchors.centerIn: parent
            width: parent.width-1
            height: parent.height-2
            clip: true
            orientation: ListView.Horizontal

            // Component.onCompleted: {
            //     updateMiller()
            // }

            model: list_header
            
            delegate: View {}
            spacing: 0

            // add: Transition {
            //     NumberAnimation { properties: "x"; from: 0; duration: 1000 }
            // }
            // remove: Transition {
            //     ParallelAnimation {
            //         NumberAnimation { property: "opacity"; to: 0; duration: 1000 }
            //         NumberAnimation { properties: "x,y"; to: 100; duration: 1000 }
            //     }
            // }
        }
    }


    Miller {
        id: mainMiller
        Component.onCompleted: {
            init()
            list_header = updateMiller()
        }
    }

    function updateMiller() {
        var _list = []
        for(var i=0;i < mainMiller.lists.length;i++){
            _list[i] = mainMiller.lists[i].header
            list_index[i] = mainMiller.lists[i].index
            // print(list_index[i])
        }
        // print("------------")
        return _list
    }

}