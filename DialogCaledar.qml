import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

Item {
    width: 250
    height: 300
    Dialog {
        id: dialogCalendar
        function show(){
            dialogCalendar.open()
        }

        // Задаём размеры диалогового окна

        // Создаем контент диалогового окна
        contentItem: Rectangle {
            id: dialogRect
            color: "#f7f7f7"


            // Первым идёт кастомный календарь
            Calendar {
                id: calendar
                // Размещаем его в верхней части диалога и растягиваем по ширине
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: row.top
            }

        }
    }
}
