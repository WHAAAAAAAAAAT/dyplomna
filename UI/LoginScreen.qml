import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Timeline 1.0

Rectangle {
    id: rectangle
    width: LoginConstants.width
    height: LoginConstants.height
    Rectangle {
        id: rectangleBackground
        width: parent.width
        height: parent.height
        opacity: 0.8
        AnimatedImage {
            id: animationBackground;
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "loginBackground.gif"
            width: parent.width
            height: parent.height
        }
        visible: true
    }
    visible: true

    Text {
        id: pageTitle
        text: qsTr("LOG IN")
        color: "#181818"
        anchors.top: parent.top
        font.pixelSize: 42
        //font.bold: true
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: LoginConstants.font.family
    }

    TextField {
        id: usernameField
        x: 140
        width: 300
        text: ""
        color: "#000000"
        font.bold: true
        opacity: 0.75
        placeholderTextColor: "#3C3C3C"
        font.pixelSize: 16
        font.family: LoginConstants.font.family
        anchors.top: parent.top
        horizontalAlignment: Text.AlignLeft
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 140
        placeholderText: qsTr("Enter your username")
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
        }
    }

    TextField {
        id: passwordField
        x: 140
        width: 300
        text: ""
        color: "#000000"
        font.bold: true
        opacity: 0.75
        placeholderTextColor: "#3C3C3C"
        font.pixelSize: 16
        font.family: LoginConstants.font.family
        anchors.top: usernameField.bottom
        anchors.horizontalCenter: usernameField.horizontalCenter
        anchors.topMargin: 10
        placeholderText: qsTr("Enter your password")
        background: Rectangle {
            implicitWidth: usernameField.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
        }
    }

    Column {
        id: buttonColumn
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 60
        spacing: 25

        LoginButton {
            id: loginButton
            anchors.horizontalCenter: buttonColumn.horizontalCenter
            width: 120
            opacity: 1
            text: qsTr("LOG IN")
        }

        RegistrationButton {
            id: registerButton
            width: 300
            text: qsTr("Don't have an account? Let's create one!")
            font.bold: true

            Connections {
                target: registerButton
                function onClicked() {
                    stackView.push(registrationScreenStackComponent)
                }
            }
        }
    }
}


