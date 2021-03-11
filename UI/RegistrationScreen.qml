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

                //checking if a name isn't empty
                if(nameField.text !== "")
                {
                    if(nameGlowBorder.opacity !== 0)
                    {
                        emptyNameErrorOff.start()
                    }

                }
                else
                {
                    emptyNameErrorOn.start()
                    return
                }

                //checking if a surname isn't empty
                if(surnameField.text !== "")
                {
                    if(surnameGlowBorder.opacity !== 0)
                    {
                        emptySurnameErrorOff.start()
                    }

                }
                else
                {
                    emptySurnameErrorOn.start()
                    return
                }

                //checking if a group isn't empty
                if(groupField.text !== "")
                {
                    if(groupGlowBorder.opacity !== 0)
                    {
                        emptyGroupErrorOff.start()
                    }

                }
                else
                {
                    emptyGroupErrorOn.start()
                    return
                }

                //checking if a username isn't empty
                if(usernameField.text !== "")
                {
                    if(usernameGlowBorder.opacity !== 0)
                    {
                        emptyUsernameErrorOff.start()
                    }

                }
                else
                {
                    emptyUsernameErrorOn.start()
                    return
                }

                //checking if a password isn't empty
                if(passwordField.text !== "")
                {
                    if(passwordGlowBorder.opacity !== 0)
                    {
                        emptyPasswordErrorOff.start()
                    }

                }
                else
                {
                    emptyPasswordErrorOn.start()
                    return
                }

                //checking if password and verifyPassword are identical
                if(passwordField.text === verifyPasswordField.text)
                {
                    if(verifyPasswordGlowBorder.opacity !== 0)
                    {
                        verifyPasswordErrorOff.start()
                    }
                    controller.registration(nameField.text, surnameField.text, groupField.text,
                                            usernameField.text, passwordField.text);
                }
                else
                {
                    verifyPasswordErrorOn.start()
                    return
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
            Rectangle {
                id: nameGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                RectangularGlow {
                    anchors.fill: nameGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: 8
                }
                SequentialAnimation {
                    id: emptyNameErrorOn
                    PropertyAnimation {
                        target: nameGlowBorder
                        properties: "opacity"
                        from: 0
                        to: 0.7
                        duration: 700
                    }
                }
                SequentialAnimation {
                    id: emptyNameErrorOff
                    PropertyAnimation {
                        target: nameGlowBorder
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
                }
            }
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
            Rectangle {
                id: surnameGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                RectangularGlow {
                    anchors.fill: surnameGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: 8
                }
                SequentialAnimation {
                    id: emptySurnameErrorOn
                    PropertyAnimation {
                        target: surnameGlowBorder
                        properties: "opacity"
                        from: 0
                        to: 0.7
                        duration: 700
                    }
                }
                SequentialAnimation {
                    id: emptySurnameErrorOff
                    PropertyAnimation {
                        target: surnameGlowBorder
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
                }
            }
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
            Rectangle {
                id: groupGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                RectangularGlow {
                    anchors.fill: groupGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: 8
                }
                SequentialAnimation {
                    id: emptyGroupErrorOn
                    PropertyAnimation {
                        target: groupGlowBorder
                        properties: "opacity"
                        from: 0
                        to: 0.7
                        duration: 700
                    }
                }
                SequentialAnimation {
                    id: emptyGroupErrorOff
                    PropertyAnimation {
                        target: groupGlowBorder
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
                }
            }
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
            Rectangle {
                id: usernameGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                RectangularGlow {
                    anchors.fill: usernameGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: 8
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
                }
            }
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
            Rectangle {
                id: passwordGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                RectangularGlow {
                    anchors.fill: passwordGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: 8
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
                }
            }
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
        background: Rectangle
        {
            implicitWidth: parent.width
            implicitHeight: 47
            color: "#FFFFFF"
            border.color: "#6D6D6D"
            border.width: 1
            Rectangle {
                id: verifyPasswordGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                RectangularGlow {
                    anchors.fill: verifyPasswordGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: 8
                }
                SequentialAnimation {
                    id: verifyPasswordErrorOn
                    PropertyAnimation {
                        target: verifyPasswordGlowBorder
                        properties: "opacity"
                        from: 0
                        to: 0.7
                        duration: 700
                    }
                }
                SequentialAnimation {
                    id: verifyPasswordErrorOff
                    PropertyAnimation {
                        target: verifyPasswordGlowBorder
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
                }
            }
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
}


