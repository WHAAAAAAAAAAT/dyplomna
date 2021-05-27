import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import "qrc:/UI"

import Models 1.0
import Controllers 1.0

Rectangle {
    id: courseListRect
    anchors.fill: parent
    color: "transparent"
    signal sendLectureName(string lecName, string courseName)
    property TestController ctrl: null

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
            property real listHeight: 30
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
                font.family: LoginConstants.font.family
                wrapMode: Text.WordWrap
            }
            ListView {
                id: lecturesListView
                anchors.top: courseNameText.bottom
                anchors.topMargin: 10
                anchors.left: courseNameRectangle.left
                spacing: 10
                model: currentModel.lecturesList
                height: courseNameRectangle.listHeight
                visible: currentModel.aVisible
                Component.onCompleted: {
                    lecturesListView.height = courseNameRectangle.listHeight
                }
                delegate: Rectangle {
                    id: lectureRectangle
                    width: courseNameRectangle.width
                    height: h
                    color: "transparent"
                    property real h: lecture.paintedHeight
                    property real w: width * 0.9

                    Component.onCompleted: {
                        if (lecture.paintedWidth > width * 0.9) {
                            w = width * 0.9
                        } else {
                            w = lecture.paintedWidth
                        }
                        courseNameRectangle.listHeight = courseNameRectangle.listHeight + h
                        lecturesListView.height = courseNameRectangle.listHeight
                    }

                    Text {
                        id: lecture
                        text: qsTr(model.modelData)
                        anchors.left: parent.left
                        height: parent.h
                        width: parent.w
                        anchors.leftMargin: parent.width * 0.1
                        anchors.verticalCenter: parent.verticalCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        font.bold: true
                        color: "#FFFFFF"
                        font.family: LoginConstants.font.family
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
                            ctrl.clearTest()
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
                Rectangle {
                    id: addLectureRectangle
                    width: courseNameRectangle.width
                    height: addLecture.paintedHeight
                    color: "transparent"
                    anchors.bottom: lecturesListView.bottom
                    anchors.bottomMargin: 10
                    Component.onCompleted: {
                        courseNameRectangle.listHeight = courseNameRectangle.listHeight + height + 5
                    }
                    Text {
                        id: addLecture
                        text: qsTr("> Додати лекцію")
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.1
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
                        font.bold: true
                        color: "#FFFFFF"
                        font.family: LoginConstants.font.family
                    }
                    Rectangle {
                        id: addLectureButtonEntered
                        anchors.fill: addLectureRectangle
                        opacity: 0
                        color: "#2B2B2B"
                    }
                    MouseArea {
                        anchors.fill: addLectureRectangle
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton
                        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                        onEntered: {
                            addLectureMouseAreaEntered.start()
                        }
                        onExited: {
                            addLectureMouseAreaExited.start()
                        }
                        onClicked: {
                            enterLectureNameDialog.currentCourseName = courseNameText.text
                            enterLectureNameDialog.open()
                            currentModel.aVisible = false
                            courseMouseClickedClose.start()
                        }
                    }
                    PropertyAnimation {
                        id: addLectureMouseAreaEntered
                        target: addLectureButtonEntered
                        properties: "opacity"
                        to: 0.1
                        duration: 100
                    }
                    PropertyAnimation {
                        id: addLectureMouseAreaExited
                        target: addLectureButtonEntered
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
                to: 50 + courseNameRectangle.listHeight
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

    LoginButton {
        id: createCourseButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.75
        opacity: 0.8
        text: qsTr("СТВОРИТИ КУРС")
        Connections {
            target: createCourseButton
            function onClicked() {
                enterCourseNameDialog.open()
            }
        }
    }

    Dialog {
        id: enterLectureNameDialog
        property string currentCourseName: ""
        width: 400
        height: 300
        contentItem: Rectangle {
            id: enterLectureNameRect
            width: 400
            height: 300
            color: "#FFFFFF"
            Text {
                id: enterLectureNameDialogTitle
                text: qsTr("Назва лекції: ")
                anchors.top: enterLectureNameRect.top
                anchors.topMargin:enterLectureNameRect.height * 0.1
                anchors.left: enterLectureNameRect.left
                anchors.leftMargin: 10
                font.pixelSize: 20
                font.bold: true
                color: "#000000"
                font.family: LoginConstants.font.family
            }
            TextField {
                id: enterLectureNameDialogText
                anchors.horizontalCenter: enterLectureNameRect.horizontalCenter
                anchors.top: enterLectureNameDialogTitle.bottom
                anchors.topMargin: 5
                width: enterLectureNameRect.width * 0.95
                text: qsTr("")
                color: "#000000"
                placeholderTextColor: "#3C3C3C"
                placeholderText: qsTr("Введіть назву для нової лекції")
                font.bold: true
                opacity: 0.75
                font.pixelSize: 16
                font.family: LoginConstants.font.family
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: 47
                    border.color: "#6D6D6D"
                    border.width: 1
                    radius: 10
                }
                selectByMouse: true
                selectionColor: "#9E7ECE"
            }
            LoginButton {
                id: button2
                anchors.bottom: enterLectureNameRect.bottom
                anchors.horizontalCenter: enterLectureNameRect.horizontalCenter
                anchors.bottomMargin: 40
                width: 200
                opacity: 0.85
                text: qsTr("СТВОРИТИ ЛЕКЦІЮ")
                Connections {
                    target: button2
                    function onClicked() {
                        CourseModel.addLecture(enterLectureNameDialogText.text, enterLectureNameDialog.currentCourseName)
                        enterLectureNameDialogText.text = ""
                        enterLectureNameDialog.close()
                    }
                }
            }
        }
    }

    Dialog {
        id: enterCourseNameDialog
        width: 400
        height: 300
        background: Rectangle {
            anchors.fill: parent
            color: "#FFFFFF"
            border.width: 1
            border.color: "#4B4B4B"
        }
        contentItem: Rectangle {
            id: enterCourseNameRect
            width: 400
            height: 300
            color: "transparent"
            Text {
                id: enterCourseNameDialogTitle
                text: qsTr("Назва курсу: ")
                anchors.top: enterCourseNameRect.top
                anchors.topMargin: enterCourseNameRect.height * 0.1
                anchors.left: enterCourseNameDialogText.left
                font.pixelSize: 20
                font.bold: true
                color: "#000000"
                font.family: LoginConstants.font.family
            }
            TextField {
                id: enterCourseNameDialogText
                anchors.horizontalCenter: enterCourseNameRect.horizontalCenter
                anchors.top: enterCourseNameDialogTitle.bottom
                anchors.topMargin: 5
                width: enterCourseNameRect.width * 0.95
                text: qsTr("")
                color: "#000000"
                placeholderTextColor: "#3C3C3C"
                placeholderText: qsTr("Введіть назву для нового курсу")
                font.bold: true
                opacity: 0.75
                font.pixelSize: 16
                font.family: LoginConstants.font.family
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: 47
                    border.color: "#6D6D6D"
                    border.width: 1
                    radius: 10
                }
                selectByMouse: true
                selectionColor: "#9E7ECE"
            }
            LoginButton {
                id: button
                anchors.bottom: enterCourseNameRect.bottom
                anchors.horizontalCenter: enterCourseNameRect.horizontalCenter
                anchors.bottomMargin: 40
                width: 200
                opacity: 0.85
                text: qsTr("СТВОРИТИ КУРС")
                Connections {
                    target: button
                    function onClicked() {
                        CourseModel.addCourse(enterCourseNameDialogText.text)
                        enterCourseNameDialogText.text = ""
                        enterCourseNameDialog.close()
                    }
                }
            }
        }
    }
}
