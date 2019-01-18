import QtQuick 2.11

Item  {
    property alias source: image1.source
    property string state: "normal"
    width: 200
    height: 200
    Image {
        id:image1
        visible: true
        anchors.fill: parent        
        sourceSize.width: parent.width
        sourceSize.height: parent.height

        states:[
          State
          {
            // Произвольное название
            name: "normal";
            when: state == "normal";
            PropertyChanges { target: image1; opacity: 0; source: ""}

          },
          State
          {
            name: "accept"
            when: state == "accept";
            PropertyChanges { target: image1; opacity: 1; source: "icon/accept.svg"; }
          },
          State
          {
            name: "stop"
            when: state == "stop";
            PropertyChanges { target: image1; opacity: 1;source: "icon/stop.svg"; }
          }
         ]
        Behavior on opacity {
            NumberAnimation {duration: 500 }
        }
    }
}
