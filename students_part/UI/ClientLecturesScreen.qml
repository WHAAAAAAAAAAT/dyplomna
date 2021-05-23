import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import Controllers 1.0
import Models 1.0

import "qrc:/UI/courses"

ApplicationWindow {
    id: windowLectures
    width: 1280
    height: 720
    signal exitWindowLectures

    property string currentLecName: ""
    property string currentCourseName: ""

    LectureController {
        id: controller
        Component.onCompleted: {
            setDocument(lecturesView.textDocument)
        }
    }

    TestController {
        id: testController
    }

    Rectangle {
        id: listOfCourses
        anchors.left: windowLectures.left
        width: windowLectures.width * 0.2
        height: windowLectures.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FFA4E5" }
            GradientStop { position: 1.0; color: "#AF89FF" }
        }
        visible: true
        Rectangle {
            id: leftSidebarTitle
            anchors.top: parent.top
            width: parent.width
            height: 90
            color: "transparent"
            Text {
                text: qsTr("МОЇ КУРСИ:")
                color: "#FFFFFF"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.pixelSize: parent.width * 0.11
                font.family: ClientLoginConstants.font.family
            }

        }
        Rectangle {
            id: coursesListRect
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.top: leftSidebarTitle.bottom
            anchors.topMargin: 20
            color: "transparent"
            CourseList {
                id: coursesList
                anchors.fill: parent
                color: parent.color
                visible: true
                onSendLectureName: {
                    lecturesView.chosenLecture = lecName
                    lecturesView.chosenCourse = courseName
                    lecturesOffView.visible = false
                    lecturesView.visible = true
                }
            }
        }
    }
    Rectangle {
        id: header
        anchors.top: windowLectures.top
        anchors.left: listOfCourses.right
        width: windowLectures.width * 0.8
        height: 50
        color: '#F0F0F0'
        visible: true
        Row {
            id: headerButtonColumn
            anchors.verticalCenter: header.verticalCenter
            anchors.right: header.right
            anchors.rightMargin: 15
            spacing: 10
            layoutDirection: Qt.RightToLeft
            ClientRegistrationButton {
                id: settingsButton
                width: header.width * 0.1
                fontSize: 20
                text: qsTr("Профіль")
                font.bold: true
                Connections {
                    target: settingsButton
                    function onClicked() {

                    }
                }
            }
            ClientRegistrationButton {
                id: menuButton
                width: header.width * 0.1
                fontSize: 20
                text: qsTr("Меню")
                font.bold: true
                Connections {
                    target: menuButton
                    function onClicked() {
                        windowLectures.hide()
                        menuWindow.show()
                    }
                }
            }
        }
    }
    Rectangle {
        id: footer
        anchors.left: listOfCourses.right
        anchors.bottom: parent.bottom
        width: header.width
        height: 60
        color: '#FFFFFF'
        visible: true
        ClientRegistrationButton {
            id: startTestButton
            anchors.bottom: footer.bottom
            anchors.bottomMargin: 40
            anchors.right: footer.right
            anchors.rightMargin: 15
            width: footer.width * 0.15
            fontSize: 20
            text: qsTr("Пройти тест")
            font.bold: true
            opacity: 1                              //поставити 0 і міняти на 1, коли відрито лекцію
            Connections {
                target: startTestButton
                function onClicked() {
                    var component = Qt.createComponent("ClientTestScreen.qml")
                    var testWindow = component.createObject(windowLectures)
                    testWindow.title = qsTr("CPPLearn/Courses/Test")
                    testWindow.lecName = lecturesView.chosenLecture
                    testWindow.courseName = lecturesView.chosenCourse
                    testWindow.show()
                    windowLectures.hide()
                }
            }
        }
    }
    Rectangle {
        id: lecturesOffView
        anchors.top: header.bottom
        anchors.bottom: footer.top
        anchors.left: listOfCourses.right
        width: header.width
        opacity: 0
        color: "#FFFFFF"
        Text {
            id: lecturesOffText
            color: "#0E0E0E"
            font.pixelSize: parent.width * 0.025
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: ClientLoginConstants.font.family
            text: qsTr("Будь ласка, оберіть лекцію.")
        }
    }

    TextEditor {
        id: lecturesView
        anchors.top: header.bottom
        anchors.bottom: footer.top
        anchors.left: listOfCourses.right
        width: header.width
        visible: true
    }

//    ClientTestScreen {
//        id: testWindow
//        title: qsTr("CPPLearn/Courses/Test")

//        onExitWindowTests: {
//            testWindow.hide()
//            lecturesWindow.show()
//        }
//    }
}
