import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import Controllers 1.0


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

    LoginController {
        id: controller
        onLoginError: {
            errorOn.start();
        }
    }

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
            radius: 10
            Rectangle {
                id: usernameGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                radius: parent.radius
                RectangularGlow {
                    anchors.fill: usernameGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: parent.radius
                }
                SequentialAnimation {
                    id: emptyUsernameErrorOn
                    PropertyAnimation {
                        target: usernameGlowBorder
                        properties: "opacity"
                        from: 0
                        to: 0.7
                        duration: 700
                    }
                }
                SequentialAnimation {
                    id: emptyUsernameErrorOff
                    PropertyAnimation {
                        target: usernameGlowBorder
                        properties: "opacity"
                        from: 0.7
                        to: 0
                        duration: 700
                    }
                }
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "#FFFFFF"
                    opacity: 0.7
                    radius: parent.radius
                }
            }
        }
        validator: RegExpValidator {
            regExp: /[a-zA-Z0-9_-.]{5,30}/
        }
        selectByMouse: true
        selectionColor: "#9E7ECE"
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
            radius: 10
            Rectangle {
                id: passwordGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                radius: parent.radius
                RectangularGlow {
                    anchors.fill: passwordGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: parent.radius
                }
                SequentialAnimation {
                    id: emptyPasswordErrorOn
                    PropertyAnimation {
                        target: passwordGlowBorder
                        properties: "opacity"
                        from: 0
                        to: 0.7
                        duration: 700
                    }
                }
                SequentialAnimation {
                    id: emptyPasswordErrorOff
                    PropertyAnimation {
                        target: passwordGlowBorder
                        properties: "opacity"
                        from: 0.7
                        to: 0
                        duration: 700
                    }
                }
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "#FFFFFF"
                    opacity: 0.7
                    radius: parent.radius
                }
            }
        }
        validator: RegExpValidator {
            regExp: /[a-zA-Z0-9_-.]{5,30}/
        }
        selectByMouse: true
        selectionColor: "#9E7ECE"
        echoMode: TextInput.Password
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

            Connections {
                target: loginButton
                function onClicked() {
                    //checking if a username isn't empty
                    if(usernameField.text !== "" && usernameField.acceptableInput)
                    {
                        //checking if a password isn't empty
                        if(passwordField.text !== "" && passwordField.acceptableInput)
                        {
                            if(usernameGlowBorder.opacity !== 0 || passwordGlowBorder.opacity !== 0)
                            {
                                emptyUsernameErrorOff.start()
                                emptyPasswordErrorOff.start()
                                errorOff.start()
                            }
                            controller.login(usernameField.text, passwordField.text)
                        }
                        else
                        {
                            errorOn.start()
                            emptyUsernameErrorOn.start()
                            emptyPasswordErrorOn.start()
                            return
                        }
                    }
                    else
                    {
                        errorOn.start()
                        emptyUsernameErrorOn.start()
                        emptyPasswordErrorOn.start()
                        return
                    }
                }
            }
        }

        RegistrationButton {
            id: registerButton
            width: 300
            text: qsTr("Don't have an account? Let's create one!")
            font.bold: true

            Connections {
                target: registerButton
                function onClicked() {
                    errorOff.start();
                    emptyUsernameErrorOff.start();
                    emptyPasswordErrorOff.start();
                    stackView.push(registrationScreenStackComponent)
                    rectangle.state = "clearFields"
                    rectangle.state = "normal"
                }
            }
        }

        Label {
            id: errorNameLabel
            anchors.horizontalCenter: buttonColumn.horizontalCenter
            /*anchors.top: registerButton.bottom
            anchors.horizontalCenter: loginButton.horizontalCenter
            anchors.topMargin: 20*/
            text: "Incorrect username or password."
            color: "#E93E3E"
            opacity: 0
        }

        PropertyAnimation {
            id: errorOn
            target: errorNameLabel
            properties: "opacity"
            to: 1
            duration: 700
        }
        PropertyAnimation {
            id: errorOff
            target: errorNameLabel
            properties: "opacity"
            to: 0
            duration: 700
        }
    }

    states: [
        State {
            name: "clearFields"
            PropertyChanges {
                target: usernameField
                text: ""
            }
            PropertyChanges {
                target: passwordField
                text: ""
            }
        },
        State {
            name: "normal"
            PropertyChanges {
                target: usernameField
                text: ""
            }
            PropertyChanges {
                target: passwordField
                text: ""
            }
        }
    ]
}
