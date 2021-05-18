import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import "qrc:/UI/chat"

Window {
    id: windowMenu
    width: 1280
    height: 720
    signal exitMenuWindow
    Rectangle {
        id: menuBackground
        color: "#FEFCFE"
        anchors.fill: parent
        AnimatedImage {
            id: menuBackgroundImage
            source: "images/menuBackgroundImage.gif"
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: parent.width * 0.8
            height: parent.height * 0.73
        }
        Text {
            id: menuTitle
            text: qsTr("МЕНЮ")
            color: "#707070"
            anchors.top: parent.top
            font.pixelSize: parent.width * 0.059
            anchors.topMargin: parent.height * 0.062
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.046
            font.family: LoginConstants.font.family
        }
        Column {
            id: menuButtons
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.075
            spacing: 20
            Rectangle {
                id: menuCoursesButton
                width: menuBackground.width * 0.2
                height: menuBackground.height * 0.28
                color: "#B2A1F1"
                visible: true
                opacity: 1
                radius: 10
                Image {
                    id: menuCoursesButtonImage
                    source: "images/coursesButtonIcon.png"
                    height: menuCoursesButton.height * 0.65
                    width: menuCoursesButton.width * 0.55
                    anchors.top: menuCoursesButton.top
                    anchors.topMargin: height * 0.1
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    id: menuCoursesButtonText
                    text: qsTr("Курси")
                    font.bold: true
                    color: "#FFFFFF"
                    anchors.top: menuCoursesButtonImage.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 27
                    anchors.topMargin: height * 0.2
                    font.family: LoginConstants.font.family
                }
                Rectangle {
                    id: coursesMenuButtonEntered
                    anchors.fill: parent
                    opacity: 0
                    radius: 10
                    color: "#F0F0F0"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onEntered: {
                        coursesMouseAreaEntered.start()
                    }
                    onExited: {
                        coursesMouseAreaExited.start()
                    }
                    onClicked: {
                        var component = Qt.createComponent("LecturesScreen.qml")
                        var lecturesWindow = component.createObject(windowMenu)
                        lecturesWindow.title = qsTr("CPPLearn/Courses")
                        lecturesWindow.show()
                        menuWindow.hide()
                    }
                }
                PropertyAnimation {
                    id: coursesMouseAreaEntered
                    target: coursesMenuButtonEntered
                    properties: "opacity"
                    to: 0.3
                    duration: 100
                }
                PropertyAnimation {
                    id: coursesMouseAreaExited
                    target: coursesMenuButtonEntered
                    properties: "opacity"
                    to: 0
                    duration: 100
                }
            }
            Rectangle {
                id: menuChatButton
                width: menuBackground.width * 0.2
                height: menuBackground.height * 0.28
                color: "#6EE7CC"
                visible: true
                opacity: 1
                radius: 10
                Image {
                    id: menuChatButtonImage
                    source: "images/chatButtonIcon.png"
                    height: menuChatButton.height * 0.65
                    width: menuChatButton.width * 0.55
                    anchors.top: menuChatButton.top
                    anchors.topMargin: height * 0.14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    id: menuChatButtonText
                    text: qsTr("Чат")
                    font.bold: true
                    color: "#FFFFFF"
                    anchors.top: menuChatButtonImage.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 27
                    anchors.topMargin: height * 0.2
                    font.family: LoginConstants.font.family
                }
                Rectangle {
                    id: menuChatButtonEntered
                    anchors.fill: parent
                    opacity: 0
                    radius: 10
                    color: "#F0F0F0"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onEntered: {
                        chatMouseAreaEntered.start()
                    }
                    onExited: {
                        chatMouseAreaExited.start()
                    }
                    onClicked: {
                        chatWindow.show();
                    }
                }
                PropertyAnimation {
                    id: chatMouseAreaEntered
                    target: menuChatButtonEntered
                    properties: "opacity"
                    to: 0.4
                    duration: 100
                }
                PropertyAnimation {
                    id: chatMouseAreaExited
                    target: menuChatButtonEntered
                    properties: "opacity"
                    to: 0
                    duration: 100
                }

            }
            Rectangle {
                id: menuSettingsButton
                width: menuBackground.width * 0.2
                height: menuBackground.height * 0.28
                color: "#F89DBE"
                visible: true
                opacity: 1
                radius: 10
                Image {
                    id: menuSettingsButtonImage
                    source: "images/settingsButtonIcon.png"
                    height: menuSettingsButton.height * 0.65
                    width: menuSettingsButton.width * 0.55
                    anchors.top: menuSettingsButton.top
                    anchors.topMargin: height * 0.14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    id: menuSettingsButtonText
                    text: qsTr("Профіль")
                    font.bold: true
                    color: "#FFFFFF"
                    anchors.top: menuSettingsButtonImage.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 27
                    anchors.topMargin: height * 0.2
                    font.family: LoginConstants.font.family
                }
                Rectangle {
                    id: menuSettingsButtonEntered
                    anchors.fill: parent
                    opacity: 0
                    radius: 10
                    color: "#F0F0F0"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onEntered: {
                        settingsMouseAreaEntered.start()
                    }
                    onExited: {
                        settingsMouseAreaExited.start()
                    }
                }
                PropertyAnimation {
                    id: settingsMouseAreaEntered
                    target: menuSettingsButtonEntered
                    properties: "opacity"
                    to: 0.3
                    duration: 100
                }
                PropertyAnimation {
                    id: settingsMouseAreaExited
                    target: menuSettingsButtonEntered
                    properties: "opacity"
                    to: 0
                    duration: 100
                }
            }
        }
    }
//    LecturesScreen {
//        id: lecturesWindow
//        title: qsTr("CPPLearn/Courses")

//        onExitWindowLectures: {
//            lecturesWindow.hide()
//            mainWindow.show()
//        }
//    }

    ChatMainScreen {
        id: chatWindow
        title: qsTr("CPPLearn/Chat")

    }
}

