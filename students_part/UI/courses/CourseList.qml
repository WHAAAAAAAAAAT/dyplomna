import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import "qrc:/UI"

import Models 1.0

Rectangle {
    id: courseListRect
    anchors.fill: parent
    color: "transparent"
    ListView {
        id: view
        anchors.fill: parent
        spacing: 10
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        model: CourseModel
        delegate: Rectangle {
            id: courseNameRectangle
            property var currentModel: model
            property var currentListModel: model.lecturesList
            width: parent.width * 0.9
            height: 50
            radius: 10
            color: "#304F008B"
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: courseNameText
                text: model.course //course = type знизу
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                anchors.top: parent.top
                anchors.topMargin: 10
                font.pixelSize: 25
                font.bold: true
                color: "#FFFFFF"
                font.family: ClientLoginConstants.font.family
                wrapMode: Text.WordWrap
            }
            ListView {
                id: lecturesListView
                anchors.top: courseNameText.bottom
                anchors.topMargin: 10
                anchors.left: courseNameRectangle.left
                spacing: 10
                model: currentModel.lecturesList
                height: 30 * model.length
                visible: currentModel.aVisible
                delegate: Rectangle {
                    id: lectureRectangle
                    width: courseNameRectangle.width
                    height: 30
                    color: "transparent"
                    Text {
                        id: lecture
                        text: qsTr(model.modelData)
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.1
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
                        font.bold: true
                        color: "#FFFFFF"
                        font.family: ClientLoginConstants.font.family
                        wrapMode: Text.WordWrap
                    }
                    Rectangle {
                        id: lectureeButtonEntered
                        anchors.fill: lectureRectangle
                        opacity: 0
                        color: "#2B2B2B"
                    }
                    MouseArea {
                        anchors.fill: lectureRectangle
                        hoverEnabled: true
                        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                        onEntered: {
                            lectureMouseAreaEntered.start()
                        }
                        onExited: {
                            lectureMouseAreaExited.start()
                        }
                        onClicked: {

                        }
                    }
                    PropertyAnimation {
                        id: lectureMouseAreaEntered
                        target: lectureeButtonEntered
                        properties: "opacity"
                        to: 0.1
                        duration: 100
                    }
                    PropertyAnimation {
                        id: lectureMouseAreaExited
                        target: lectureeButtonEntered
                        properties: "opacity"
                        to: 0
                        duration: 100
                    }
                }
            }
            Rectangle {
                id: courseButtonEntered
                anchors.top: parent.top
                anchors.left: parent.left
                height: 50
                width: parent.width
                opacity: 0
                radius: 10
                color: "#2B2B2B"
            }
            MouseArea {
                anchors.top: parent.top
                anchors.left: parent.left
                height: 50
                width: parent.width
                hoverEnabled: true
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                onEntered: {
                    courseMouseAreaEntered.start()
                }
                onExited: {
                    courseMouseAreaExited.start()
                }
                onClicked: {
                    if(model.aVisible === false)
                    {
                        model.aVisible = true
                        courseMouseClickedOpen.start()
                    }
                    else
                    {
                        model.aVisible = false
                        courseMouseClickedClose.start()
                    }
                }
            }
            PropertyAnimation {
                id: courseMouseAreaEntered
                target: courseButtonEntered
                properties: "opacity"
                to: 0.1
                duration: 100
            }
            PropertyAnimation {
                id: courseMouseAreaExited
                target: courseButtonEntered
                properties: "opacity"
                to: 0
                duration: 100
            }
            PropertyAnimation {
                id: courseMouseClickedOpen
                target: courseNameRectangle
                properties: "height"
                to: 50 + (40 * currentListModel.length)
                duration: 100
            }
           PropertyAnimation {
                id: courseMouseClickedClose
                target: courseNameRectangle
                properties: "height"
                to: 50
                duration: 100
            }
        }
        ScrollBar.vertical: ScrollBar {}
    }

    ClientLoginButton {
        id: findCourseButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.75
        opacity: 0.85
        text: qsTr("ЗНАЙТИ НОВИЙ КУРС")
        enabled: enabled
        Connections {
            target: findCourseButton
            function onClicked() {

            }
        }
    }
}
