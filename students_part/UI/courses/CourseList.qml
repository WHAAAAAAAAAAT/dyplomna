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
    signal sendLectureName(string lecName, string courseName)

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
                height: courseNameRectangle.height - 70
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
                        id: lectureButtonEntered
                        anchors.fill: lectureRectangle
                        opacity: 0
                        color: "#2B2B2B"
                    }
                    MouseArea {
                        anchors.fill: lectureRectangle
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                        onEntered: {
                            lectureMouseAreaEntered.start()
                        }
                        onExited: {
                            lectureMouseAreaExited.start()
                        }
                        onClicked: {
                            courseListRect.sendLectureName(lecture.text, currentModel.course)
                            CourseModel.loadLectures(currentModel.course, lecture.text)
                            testController.loadTest(lecture.text, currentModel.course)
                        }
                    }
                    PropertyAnimation {
                        id: lectureMouseAreaEntered
                        target: lectureButtonEntered
                        properties: "opacity"
                        to: 0.1
                        duration: 100
                    }
                    PropertyAnimation {
                        id: lectureMouseAreaExited
                        target: lectureButtonEntered
                        properties: "opacity"
                        to: 0
                        duration: 100
                    }
                    Menu {
                        id: contextMenuLecture
                        MenuItem {
                            text: qsTr("Видалити лекцію")
                            //onTriggered: model.removeCourse(lecture.text)
                        }
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
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                onEntered: {
                    courseMouseAreaEntered.start()
                }
                onExited: {
                    courseMouseAreaExited.start()
                }
                onClicked: {
                    if (mouse.button == Qt.LeftButton)
                    {
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
                    if (mouse.button == Qt.RightButton)
                    {
                        console.log("right click")
                        contextMenuCourse.open()
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
                to: 50 + 40 * currentListModel.length
                duration: 100
            }
            PropertyAnimation {
                id: courseMouseClickedClose
                target: courseNameRectangle
                properties: "height"
                to: 50
                duration: 100
            }
            Menu {
                id: contextMenuCourse
                MenuItem {
                    text: qsTr("Видалити курс")
                    onTriggered: CourseModel.removeCourse(courseNameText.text)
                }
            }
        }
        ScrollBar.vertical: ScrollBar {}
    }

    ClientLoginButton {
        id: createCourseButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.75
        opacity: 0.8
        text: qsTr("ЗНАЙТИ КУРС")
        Connections {
            target: createCourseButton
            function onClicked() {

            }
        }
    }
}
