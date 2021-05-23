import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import Controllers 1.0
import Models 1.0
import Test 1.0

import "qrc:/UI/testcreator"
import "qrc:/UI/courses"

ApplicationWindow {
    id: windowLectures
    width: 1280
    height: 720
    signal exitWindowLectures

    property string currentLecName: ""
    property string currentCourseName: ""

    LecturesController {
        id: lecturesController
        Component.onCompleted: {
            setDocument(lecturesView.textDocument)
        }
    }

    TestController {
        id: testController
        Component.onCompleted: {

        }
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
                font.family: LoginConstants.font.family
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
            RegistrationButton {
                id: settingsButton
                width: header.width * 0.12
                fontSize: 20
                text: qsTr("Профіль")
                font.bold: true
                Connections {
                    target: settingsButton
                    function onClicked() {

                    }
                }
            }
            RegistrationButton {
                id: menuButton
                width: header.width * 0.12
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
        height: 70
        color: '#FFFFFF'
        visible: true

        LoginButton {
            id: saveLectureButton
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: footer.width * 0.2
            text: qsTr("ЗБЕРЕГТИ ЛЕКЦІЮ")
            opacity: 0
            Connections {
                target: saveLectureButton
                function onClicked() {
                    CourseModel.saveCurrentLecture(lecturesView.textDocument, lecturesView.chosenLecture,
                                                   lecturesView.chosenCourse)

                    lecturesController.sendLecture(lecturesView.textDocument, lecturesView.chosenLecture,
                                                   lecturesView.chosenCourse)
                }
            }
        }
        RegistrationButton {
            id: createTestButton
            anchors.bottom: footer.bottom
            anchors.bottomMargin: 40
            anchors.right: footer.right
            anchors.rightMargin: 15
            width: footer.width * 0.15
            fontSize: 20
            text: qsTr("Створити тест")
            font.bold: true
            opacity: 0                             //поставити 0 і міняти на 1, коли відрито лекцію
            Connections {
                target: createTestButton
                function onClicked() {
                    testController.loadTest(lecturesView.chosenLecture, lecturesView.chosenCourse)
                    createTestOn.start()
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
        visible: true
        opacity: 1
        color: "#FFFFFF"
        Text {
            id: lecturesOffText
            color: "#0E0E0E"
            font.pixelSize: parent.width * 0.025
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: LoginConstants.font.family
            text: qsTr("Будь ласка, оберіть лекцію або створіть курс.")
        }
    }
    TextEditor {
        id: lecturesView
        anchors.top: header.bottom
        anchors.bottom: footer.top
        anchors.left: listOfCourses.right
        width: header.width
        visible: false
        onVisibleChanged: {
            saveLectureButton.opacity = 1
            createTestButton.opacity = 1
            currentLecName = chosenLecture
            currentCourseName = chosenCourse
            console.log(chosenLecture + " " + chosenCourse)
        }
    }
    Rectangle {
        id: testCreator
        anchors.right: parent.right
        width: 0
        height: parent.height
        color: '#F6F6F6'
        opacity: 0
        Text {
            id:rightSidebarTitle
            text: qsTr("СТВОРИТИ ТЕСТ")
            color: "#646464"
            font.bold: true
            anchors.top: testCreator.top
            anchors.left: testCreator.left
            font.pixelSize: 23
            anchors.topMargin: 13
            anchors.leftMargin: testCreator.width * 0.05
            font.family: LoginConstants.font.family
        }
        RegistrationButton {
            id: closeTestCreatorButton
            anchors.top: testCreator.top
            anchors.topMargin: 17
            anchors.right: testCreator.right
            anchors.rightMargin: 20
            width: 10
            fontSize: 23
            notClickedColor: "#646464"
            clickedColor: "#FF1717"
            text: qsTr("╳")
            font.bold: true
            opacity: 1
            Connections {
                target: closeTestCreatorButton
                function onClicked() {
                    createTestOff.start()
                }
            }
        }
        Rectangle {
            id: questionsScroll
            anchors.top: rightSidebarTitle.bottom
            anchors.left: parent.left
            anchors.leftMargin: testCreator.width * 0.03
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.topMargin: 30
            color: "#F6F6F6"
            opacity: 1

            TestList {
                anchors.fill: parent
                color: parent.color
                lecName: currentLecName
                courseName: currentCourseName
                onSaveTest: {
                    testController.saveTestList(lec, course)
                }
            }
        }
    }

    ParallelAnimation {
        id: createTestOn
        PropertyAnimation {
            target: createTestButton
            properties: "opacity"
            to: 0
            duration: 700
        }
        PropertyAnimation {
            target: header
            properties: "width"
            to: windowLectures.width * 0.6
            duration: 700
        }
        PropertyAnimation {
            target: headerButtonColumn
            properties: "anchors.rightMargin"
            to: header.width * 0.57
            duration: 700
        }
        PropertyAnimation {
            target: testCreator
            properties: "opacity"
            to: 1
            duration: 800
        }
        PropertyAnimation {
            target: testCreator
            properties: "width"
            to: windowLectures.width * 0.4
            duration: 700
        }
        PropertyAnimation {
            target: listOfCourses
            properties: "width"
            to: 0
            duration: 700
        }
        PropertyAnimation {
            target: listOfCourses
            properties: "opacity"
            to: 0
            duration: 700
        }
    }
    ParallelAnimation {
        id: createTestOff
        PropertyAnimation {
            target: createTestButton
            properties: "opacity"
            to: 1
            duration: 700
        }
        PropertyAnimation {
            target: header
            properties: "width"
            to: windowLectures.width * 0.8
            duration: 700
        }
        PropertyAnimation {
            target: headerButtonColumn
            properties: "anchors.rightMargin"
            to: 15
            duration: 700
        }
        PropertyAnimation {
            target: testCreator
            properties: "opacity"
            to: 0
            duration: 600
        }
        PropertyAnimation {
            target: testCreator
            properties: "width"
            to: 0
            duration: 700
        }
        PropertyAnimation {
            target: listOfCourses
            properties: "width"
            to: windowLectures.width * 0.2
            duration: 700
        }
        PropertyAnimation {
            target: listOfCourses
            properties: "opacity"
            to: 1
            duration: 700
        }
    }
}

