import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Timeline 1.0

import Controllers 1.0

Rectangle {
    id: rectangle
    width: LoginConstants.width
    height: LoginConstants.height
    Rectangle {
        id: rectangleBackground
        width: parent.width
        height: parent.height
        opacity: 0.6
        AnimatedImage {
            id: animationBackground
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "loginBackground6.gif"
            width: parent.width
            height: parent.height
        }
        visible: true
    }
    visible: true
    property bool stateNormalBorder: true

    LoginController
    {
        id: controller
    }

    LoginButton {
        id: registrationButton
        width: 150
        height: 50
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 200
        anchors.rightMargin: 70
        text: qsTr("SIGN UP")
        fontSize: 20

        Connections {
            target: registrationButton
            function onClicked() {
                if(passwordField.text === verifyPasswordField.text)
                {
                    controller.registration(nameField.text, surnameField.text, groupField.text,
                                            usernameField.text, passwordField.text);
                }
                else
                {
                    //
                    rectangle.state = "verificationErrorOn"
                    rectangle.state = "verificationErrorOff"
                    //
                }
            }
        }
    }

    TextField {
        id: nameField
        x: 40
        width: 300
        text: ""
        color: "#000000"
        font.bold: true
        opacity: 0.75
        placeholderTextColor: "#3C3C3C"
        font.pixelSize: 16
        font.family: LoginConstants.font.family
        anchors.top: parent.top
        anchors.left: parent.left
        horizontalAlignment: Text.AlignLeft
        anchors.topMargin: 40
        anchors.leftMargin: 50
        placeholderText: qsTr("Enter your name")
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
        }
        selectByMouse: true
        selectionColor: "#9E7ECE"
    }

    TextField {
        id: surnameField
        x: 40
        width: 300
        text: ""
        color: "#000000"
        font.bold: true
        opacity: 0.75
        placeholderTextColor: "#3C3C3C"
        font.pixelSize: 16
        font.family: LoginConstants.font.family
        anchors.top: nameField.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: nameField.horizontalCenter
        placeholderText: qsTr("Enter your surname")
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
        }
        selectByMouse: true
        selectionColor: "#9E7ECE"
    }

    TextField {
        id: groupField
        x: 40
        width: 300
        text: ""
        color: "#000000"
        font.bold: true
        opacity: 0.75
        placeholderTextColor: "#3C3C3C"
        font.pixelSize: 16
        font.family: LoginConstants.font.family
        anchors.top: surnameField.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: nameField.horizontalCenter
        placeholderText: qsTr("Enter your group")
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
        }
        selectByMouse: true
        selectionColor: "#9E7ECE"
    }

    TextField {
        id: usernameField
        x: 40
        width: 300
        text: ""
        color: "#000000"
        font.bold: true
        opacity: 0.75
        placeholderTextColor: "#3C3C3C"
        font.pixelSize: 16
        font.family: LoginConstants.font.family
        anchors.top: groupField.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: nameField.horizontalCenter
        placeholderText: qsTr("Enter a username (login)")
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
        }
        selectByMouse: true
        selectionColor: "#9E7ECE"
    }

    TextField {
        id: passwordField
        x: 40
        width: 300
        text: ""
        color: "#000000"
        font.bold: true
        opacity: 0.75
        placeholderTextColor: "#3C3C3C"
        font.pixelSize: 16
        font.family: LoginConstants.font.family
        anchors.top: usernameField.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: nameField.horizontalCenter
        placeholderText: qsTr("Enter a password")
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
        }
        selectByMouse: true
        selectionColor: "#9E7ECE"
    }

    TextField {
        id: verifyPasswordField
        x: 40
        width: 300
        text: ""
        color: "#000000"
        font.bold: true
        opacity: 0.75
        placeholderTextColor: "#3C3C3C"
        font.pixelSize: 16
        font.family: LoginConstants.font.family
        anchors.top: passwordField.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: nameField.horizontalCenter
        placeholderText: qsTr("Verify your password")
        background: Rectangle {
            id: verifyPasswordBorder
            implicitWidth: passwordField.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
        }
        selectByMouse: true
        selectionColor: "#9E7ECE"
    }

    RegistrationButton {
        id: loginButton
        width: 300
        anchors.top: registrationButton.bottom
        anchors.horizontalCenter: registrationButton.horizontalCenter
        anchors.topMargin: 20
        text: qsTr("Already have an account? Log in!")
        font.bold: true

        Connections {
            target: loginButton
            function onClicked() {
                stackView.pop()
            }
        }
    }

    states: [
        State {
            name: "verificationErrorOn"
            PropertyChanges {
                target: verifyPasswordBorder
                border.color: "#FF4C4C"
            }
            PropertyChanges {
                target: verifyPasswordBorder
                border.width: 3
            }
        },
        State {
            name: "verificationErrorOff"
            PropertyChanges {
                target: verifyPasswordBorder
                border.color: "#6D6D6D"
            }
            PropertyChanges {
                target: verifyPasswordBorder
                border.width: 1
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                target: verifyPasswordBorder
                properties: "border.color"
                duration: 500
            }
            NumberAnimation {
                target: verifyPasswordBorder
                properties: "border.width"
                loops: 1
                duration: 500
            }
        }
    ]
}


