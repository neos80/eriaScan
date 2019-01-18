import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import "Database.js" as Db

ApplicationWindow {
    id: applicationWindow1
    visible: true
    width: 640
    height: 200
    minimumWidth: 640
    minimumHeight: 200
    maximumWidth: 640
    maximumHeight: 200
    title: qsTr("Счетчик флаеров")

    Component.onCompleted: {
        datePickerSt.date = new Date();
        datePickerSt.date.setMonth(datePickerSt.date.getMonth()-1);
        datePickerSt.getDate();
        datePickerEnd.date = new Date();
        datePickerEnd.getDate();
    }


    function countBetween(startdate,enddate) {
        var countBetween
        var records = Db.getRecordsBetween(startdate,enddate)  //тут заменил на фильтр
        return countBetween = records.length
    }

    function countToday() {
        var countToday
        var records = Db.getRecordsToday()  //тут заменил на фильтр
        return countToday = records.length
    }

    function updateRecords() {
        recordsListModel.clear()
        var records = Db.getRecords()  //тут заменил на фильтр
        for (var i = 0; i < records.length; i++) {
            recordsListModel.append({
                                        "recordId": records[i].id,
                                        "recordaRdate": records[i].aRdate
                                    })
        }
        tekDay.text    = countToday()
    }


    ListModel {
        id: recordsListModel
        Component.onCompleted: {
            Db.init()
            updateRecords()
        }
    }



    WarningImg{
        id: iconImg
        x: 440
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }
    Timer {
        id:timer
        interval: 2500; running: true; repeat: false
        onTriggered: iconImg.state = "normal"
    }


    Text {
        id: template
        x: 227
        y: 70
        width: 83
        height: 28
        text: qsTr("98736820124345332442")
        Layout.fillWidth: true
        Layout.fillHeight: false
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        anchors.horizontalCenterOffset: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

    }

    GroupBox {
        id: groupBox1
        x: 215
        width: 212
        height: 78
        anchors.horizontalCenterOffset: -6
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        title: qsTr("")

        ColumnLayout {
            id: columnLayout1
            anchors.fill: parent
            width: 100
            height: 100

            Label {
                id: den
                width: 140
                height: 21
                text: qsTr("Сегодня")
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: tekDay
                width: 83
                height: 27
                text: qsTr("0")
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.pixelSize: 22
            }
        }



    }

    Text {
        id: tekPeriod
        x: 14
        y: 103
        width: 176
        height: 27
        text: qsTr("0")
        verticalAlignment: Text.AlignVCenter
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.fillWidth: true
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 22
    }



    Button {
        id: addValue
        x: 106
        y: 136
        width: 84
        height: 40
        text: qsTr("addValue")
        enabled: false
        onClicked: {
            tekPeriod.text = qsTr(Db.getPredMonth() )
            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-10-10 10:33:10"))
            updateRecords()
            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-10-10 11:33:10"))
            updateRecords()
            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-10-10 12:33:10"))
            updateRecords()
            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-10-10 13:33:10"))
            updateRecords()

            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-10-09 10:33:10"))
            updateRecords()
            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-10-08 10:33:10"))
            updateRecords()
            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-10-07 10:33:10"))
            updateRecords()

            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-09-09 10:33:10"))
            updateRecords()
            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-09-08 10:33:10"))
            updateRecords()
            Db.insertRecord(Qt.formatDateTime(new Date(), "2016-09-07 10:33:10"))
            updateRecords()
        }
    }

    Label {
        id: label1
        x: 14
        y: 70
        width: 29
        height: 18
        text: qsTr("По")
        font.bold: true
        font.pointSize: 11
    }

    Label {
        id: label2
        x: 14
        y: 44
        width: 29
        height: 18
        text: qsTr("C")
        font.pointSize: 11
        font.bold: true
    }


    Button {
        id: butupdate
        x: 14
        y: 136
        width: 82
        height: 40
        text: qsTr("Обновить")
        onClicked: {
            tekDay.text = countToday()
            updateRecords()
            var stDate = datePickerSt.date
            var enDate = datePickerEnd.date
            tekPeriod.text = countBetween(stDate,enDate)

            //helloDialog.open()
        }
    }

    DatePicker {
        id: datePickerEnd
        x: 49
        y: 70
        width: 110
        height: 20
    }

    Rectangle {
        id: rectangle1
        x: 214
        y: 129
        width: 200
        height: 47
        color: "#ffffff"
        border.color: "#d20000"

        TextInput {
            id: textInput1
            anchors.fill: parent
            cursorVisible: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            passwordCharacter: qsTr("●")
            inputMask: qsTr("")
            font.bold: true
            font.pixelSize: 21
            focus: true
            Keys.onReturnPressed: {

                if (textInput1.text == template.text){
                    iconImg.state = "accept"
                    Db.insertRecord(Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss"))
                    updateRecords()
                    timer.start()
                } else {
                    iconImg.state = "stop"
                    timer.start()
                }

                textInput1.text = (qsTr(""))
                console.log("Key Enter was pressed and NewDay: " + Qt.formatDateTime(new Date(), "dd-MM-yyyy hh:mm:ss") )

            }

        }
    }

    DatePicker {
        id: datePickerSt
        x: 49
        y: 43
    }

//    ListView {
//        id: listView1
//        x: 208
//        y: 182
//        width: 212
//        height: 205
//        model: recordsListModel

//        delegate: Item {
//            x: 5
//            width: 80
//            height: 40
//            Row {
//                id: row1
//                Rectangle {
//                    width: 40
//                    height: 40
//                }

//                Text {
//                    text: recordaRdate
//                    font.bold: true
//                    anchors.verticalCenter: parent.verticalCenter
//                }
//                spacing: 10
//            }
//        }
//    }


}
