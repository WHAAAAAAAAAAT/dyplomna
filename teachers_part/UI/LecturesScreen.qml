import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: windowLectures
    width: 1280
    height: 720
    signal exitWindowLectures
    Rectangle {
        id: listOfCourses
        anchors.left: windowLectures.left
        width: windowLectures.width * 0.2
        height: windowLectures.height
        color: '#B9B3F5'
        visible: true
        Text {
            id: leftSidebarTitle
            text: qsTr("MY COURSES:")
            color: "#FFFFFF"
            font.bold: true
            anchors.top: parent.top
            anchors.left: parent.left
            font.pixelSize: 25
            anchors.topMargin: 10
            anchors.leftMargin: 20
            font.family: LoginConstants.font.family
        }
        ListView {
            id: coursesList
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: createCourseButton.top
            anchors.bottomMargin: 15
            anchors.top: leftSidebarTitle.bottom
            anchors.topMargin: 15
            /* model: CoursesListModel {}
            delegate: ...

            }
            */
        }
        LoginButton {
            id: createCourseButton
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 40
            width: parent.width * 0.75
            opacity: 1
            text: qsTr("CREATE A NEW COURSE")
            Connections {
                target: createCourseButton
                function onClicked() {

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
                width: header.width * 0.1
                fontSize: 20
                text: qsTr("Settings")
                font.bold: true
                Connections {
                    target: settingsButton
                    function onClicked() {

                    }
                }
            }
            RegistrationButton {
                id: menuButton
                width: header.width * 0.1
                fontSize: 20
                text: qsTr("Menu")
                font.bold: true
                Connections {
                    target: menuButton
                    function onClicked() {

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
        RegistrationButton {
            id: createTestButton
            anchors.bottom: footer.bottom
            anchors.bottomMargin: 40
            anchors.right: footer.right
            anchors.rightMargin: 15
            width: footer.width * 0.15
            fontSize: 20
            text: qsTr("Create a test")
            font.bold: true
            opacity: 1
            Connections {
                target: createTestButton
                function onClicked() {
                    createTestOn.start()
                }
            }
        }
    }
    Loader {
        id: lecturesView
        source: "TextEditor.qml";
        anchors.top: header.bottom
        anchors.bottom: footer.top
        anchors.left: listOfCourses.right
        width: header.width
        visible: true
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
            text: qsTr("TEST CREATOR")
            color: "#646464"
            font.bold: true
            anchors.top: testCreator.top
            anchors.left: testCreator.left
            font.pixelSize: 23
            anchors.topMargin: 13
            anchors.leftMargin: 20
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
        Column {
            id: questions

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
