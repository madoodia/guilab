import QtQuick 2.0

// import Miller 1.0
import Controller 1.0

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
            id: millerView
            anchors.centerIn: parent
            width: parent.width-1
            height: parent.height-2
            clip: true
            orientation: ListView.Horizontal

            // Component.onCompleted: {
            //     updateMiller()
            // }

            model: list_header
            
            delegate: ListItem {}
            spacing: 0

            snapMode: ListView.SnapOneItem

            focus: true
            highlightFollowsCurrentItem: true

            // populate: Transition {
            //     NumberAnimation { properties: "x"; duration: 1000 }
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
        }
    }


    // Miller {
    //     id: mainController
    //     Component.onCompleted: {
    //         init()
    //         list_header = updateMiller()
    //     }
    // }

    Controller {
        id: mainController
        Component.onCompleted: {
            // here_in_controller()
            list_header = updateMiller()
        }
    }

    function printMe() {
        for(var i=0;i < mainController.lists.length;i++){
            print(mainController.lists[i])
        }        
    }

    function updateMiller() {
        var _list = []
        for(var i=0;i < mainController.lists.length;i++){
            _list[i] = mainController.lists[i].header
            list_index[i] = mainController.lists[i].index
            // print(list_index[i])
        }
        // print("------------")
        return _list
    }

}