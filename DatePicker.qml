import QtQuick 2.11
import QtQuick.Controls 2.4
//import QtQuick.Controls.Material 2.0
//import QtQuick.Layouts 1.1

Rectangle {
    id: root
    color: "transparent"
    width: 110
    height: 20
    property var date: new Date()


    function getDate() {
        textDay.text = date.getDate();
        textMonth.text = root.date.getMonth()+1;
        textYear.text = date.getFullYear();
    }

    onDateChanged: {
        textDay.text = date.getDate();
        textMonth.text = root.date.getMonth()+1;
        textYear.text = date.getFullYear();
    }

    Row {
        width: 163
        spacing: 2
        anchors.fill: parent

        Rectangle {
            id: rectangleDay
            height: root.height
            width: root.width/3 - 10
            color: "#272822"
            border.color: "#76644A"
            border.width: 1
            radius: 2
            antialiasing: true


            Text {
                id: textDay
                height: rectangleDay.height
                width: rectangleDay.widh
                anchors.centerIn: parent
                color: "#ecc089"
                font.pointSize: root.width / 10
                font.bold: true
                text: root.date.getDate()
            }

        }

        Column{
            Button {
                height: root.height/2
                width: 10
                onClicked: {
                    root.date.setDate(root.date.getDate()+1);
                    getDate();
                    console.log("getDate: "+root.date.getDate());
                }
                Image {
                    visible: true
                    anchors.fill: parent
                    sourceSize.width: parent.width
                    sourceSize.height: parent.height
                    source: "icon/arrow_Up.svg"
                }
            }
            Button {
                height: root.height/2
                width: 10
                onClicked: {
                    root.date.setDate(root.date.getDate()-1);
                    getDate();
                    console.log("getDate: "+root.date.getDate());
                }
                Image {
                    visible: true
                    anchors.fill: parent
                    sourceSize.width: parent.width
                    sourceSize.height: parent.height
                    source: "icon/arrow_Down.svg"
                }
            }

        }

        Rectangle {
            id: rectangleMonth
            height: root.height
            width: root.width/3 - 10
            color: "#272822"
            border.color: "#76644A"
            border.width: 1
            radius: 2
            antialiasing: true



            Text {
                id: textMonth
                height: rectangleMonth.height
                width: rectangleMonth.widh
                anchors.centerIn: parent
                color: "#ecc089"
                font.pointSize: root.width / 10
                font.bold: true
                text: root.date.getMonth()+1
            }

        }



        Column{
            Button {
                height: root.height/2
                width: 10
                onClicked: {
                    root.date.setMonth(root.date.getMonth()+1);
                    getDate();
                    console.log("getMonth: "+root.date.getMonth());
                }
                Image {
                    visible: true
                    anchors.fill: parent
                    sourceSize.width: parent.width
                    sourceSize.height: parent.height
                    source: "icon/arrow_Up.svg"
                }
            }
            Button {
                height: root.height/2
                width: 10
                onClicked: {
                    root.date.setMonth(root.date.getMonth()-1);
                    getDate();
                    console.log("getMonth: "+root.date.getMonth());
                }
                Image {
                    visible: true
                    anchors.fill: parent
                    sourceSize.width: parent.width
                    sourceSize.height: parent.height
                    source: "icon/arrow_Down.svg"
                }
            }

        }



        Rectangle {
            id: rectangleYear
            height: root.height
            width: root.width/3 +15
            color: "#272822"
            border.color: "#76644A"
            border.width: 1
            radius: 2
            antialiasing: true



            Text {
                id: textYear
                height: rectangleYear.height
                width: rectangleYear.widh
                anchors.centerIn: parent
                color: "#ecc089"
                font.pointSize: root.width / 10
                font.bold: true
                text: root.date.getFullYear()
            }

        }

        Column{
            Button {
                height: root.height/2
                width: 10
                onClicked: {
                    root.date.setFullYear(root.date.getFullYear()+1);
                    getDate();
                    console.log("Year: "+root.date.getFullYear());
                }
                Image {
                    visible: true
                    anchors.fill: parent
                    sourceSize.width: parent.width
                    sourceSize.height: parent.height
                    source: "icon/arrow_Up.svg"
                }
            }
            Button {
                height: root.height/2
                width: 10
                onClicked: {
                    root.date.setFullYear(root.date.getFullYear()-1);
                    getDate();
                    console.log("Year: "+root.date.getFullYear());
                }
                Image {
                    visible: true
                    anchors.fill: parent
                    sourceSize.width: parent.width
                    sourceSize.height: parent.height
                    source: "icon/arrow_Down.svg"
                }
            }

        }


    }
}
