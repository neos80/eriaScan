import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.LocalStorage 2.0
import Qt.labs.calendar 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Material 2.0
import "Database.js" as Db
import QtQuick.Controls.Universal 2.0

ApplicationWindow {
    id: applicationWindow1
    visible: true
    width: 640
    height: 480
    minimumWidth: 640
    minimumHeight: 200
    maximumWidth: 640
    maximumHeight: 480
    title: qsTr("Счетчик флаеров")

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
        tekDay.text = countToday()
    }


    ListModel {
        id: recordsListModel
        Component.onCompleted: {
            Db.init()
            updateRecords()
        }
    }


    Settings {
        id: settings
        //            property string state: "active"
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

    ListView {
        id: listView1
        y: 264
        height: 246
        enabled: true
        contentWidth: 2
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        model: recordsListModel

        delegate: RowLayout {
            Label {
                Layout.fillWidth: true
                text: model.recordId + ". " + model.recordaRdate
                font.pixelSize: 12
                font.bold: true
            }
            Button {
                text: "x"
//                font.pixelSize: 18
//                font.bold: true
                onClicked: {
                    Db.removeRecord(model.recordId)
                    updateRecords()
                }
            }

        }
    }

    TextInput {
        id: textInput1
        x: 226
        y: 143
        width: 224
        height: 40                
        cursorVisible: true
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 176
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
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

    Text {
        id: template
        x: 227
        y: 70
        width: 83
        height: 28
        text: qsTr("4690512020922")
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
        y: 75
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


    TextInput {
        id: startdate
        x: 62
        y: 44
        width: 80
        height: 20
        text: qsTr("10.09.2016")
                validator: RegExpValidator{regExp: /^(((0[1-9]|[12]\d|3[01])\.(0[13578]|1[02])\.((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\.(0[13456789]|1[012])\.((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\.02\.((19|[2-9]\d)\d{2}))|(29\.02\.((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/}
        font.bold: true
        font.pixelSize: 12
    }

    TextInput {
        id: enddate
        x: 62
        y: 73
        width: 80
        height: 20
        text: qsTr("10.10.2016")
        validator: RegExpValidator{regExp: /^(((0[1-9]|[12]\d|3[01])\.(0[13578]|1[02])\.((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\.(0[13456789]|1[012])\.((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\.02\.((19|[2-9]\d)\d{2}))|(29\.02\.((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/}
        font.bold: true
        font.pixelSize: 12
    }

    Component.onCompleted: {
//        startdate.text = Qt.formatDateTime(new Date(), "dd.MM.yyyy")
//        endtdate.text = Qt.formatDateTime(new Date(), "dd.MM.yyyy")
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
            dialogCalendar.show()
        }
    }



}
