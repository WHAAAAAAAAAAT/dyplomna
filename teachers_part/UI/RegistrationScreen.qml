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
    LoginController {
        id: controller
        onRegistrationError: {
            currentErrorText.text = verificationErrorText.text
            errorOn.start()
        }
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
        loginfontSize: 20
        Connections {
            target: registrationButton
            function onClicked() {
                //checking if a name isn't empty
                if(nameField.text !== "" && nameField.acceptableInput)
                {
                    if(nameGlowBorder.opacity !== 0)
                    {
                        emptyNameErrorOff.start()
                        errorOff.start()
                    }
                }
                else
                {
                    currentErrorText.text = nameErrorText.text
                    errorOn.start()
                    emptyNameErrorOn.start()
                    return
                }

                //checking if a surname isn't empty
                if(surnameField.text !== "" && surnameField.acceptableInput)
                {
                    if(surnameGlowBorder.opacity !== 0)
                    {
                        emptySurnameErrorOff.start()
                        errorOff.start()
                    }

                }
                else
                {
                    currentErrorText.text = surnameErrorText.text
                    errorOn.start()
                    emptySurnameErrorOn.start()
                    return
                }

                //checking if a username isn't empty
                if(usernameField.text !== "" && usernameField.acceptableInput)
                {
                    if(usernameGlowBorder.opacity !== 0)
                    {
                        emptyUsernameErrorOff.start()
                        errorOff.start()
                    }

                }
                else
                {
                    currentErrorText.text = usernameErrorText.text
                    errorOn.start()
                    emptyUsernameErrorOn.start()
                    return
                }

                //checking if a password isn't empty
                if(passwordField.text !== "" && passwordField.acceptableInput)
                {
                    if(passwordGlowBorder.opacity !== 0)
                    {
                        emptyPasswordErrorOff.start()
                        errorOff.start()
                    }

                }
                else
                {
                    currentErrorText.text = passwordErrorText.text
                    errorOn.start()
                    emptyPasswordErrorOn.start()
                    return
                }

                //checking if password and verifyPassword are identical
                if(passwordField.text === verifyPasswordField.text && verifyPasswordField.acceptableInput)
                {
                    if(verifyPasswordGlowBorder.opacity !== 0)
                    {
                        verifyPasswordErrorOff.start()
                        errorOff.start()
                    }
                    controller.registration(nameField.text, surnameField.text, usernameField.text, passwordField.text);
                }
                else
                {
                    currentErrorText.text = verifyPasswordErrorText.text
                    errorOn.start()
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
        anchors.topMargin: 70
        anchors.leftMargin: 50
        placeholderText: qsTr("Enter your name")
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 47
            border.color: "#6D6D6D"
            border.width: 1
            radius: 10
            Rectangle {
                id: nameGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                radius: parent.radius
                RectangularGlow {
                    anchors.fill: nameGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: parent.radius
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
                    radius: parent.radius
                }
            }
        }
        validator: RegExpValidator {
            regExp: /[А-ЯІA-Z][а-яіa-zА-ЯІA-Z-]{1,49}/
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
            radius: 10
            Rectangle {
                id: surnameGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                radius: parent.radius
                RectangularGlow {
                    anchors.fill: surnameGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: parent.radius
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
                    radius: parent.radius
                }
            }
        }
        validator: RegExpValidator {
            regExp: /[А-ЯІA-Z][а-яіa-zА-ЯІA-Z-]{1,49}/
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
        anchors.top: surnameField.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: nameField.horizontalCenter
        placeholderText: qsTr("Enter a username (login)")
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
            radius: 10
            Rectangle {
                id: verifyPasswordGlowBorder
                width: parent.width
                height: parent.height
                opacity: 0
                radius: parent.radius
                RectangularGlow {
                    anchors.fill: verifyPasswordGlowBorder
                    glowRadius: 10
                    spread: 0.2
                    color: "#FF7C7C"
                    cornerRadius: parent.radius
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
    Text {
        id: nameErrorText
        text: qsTr("Content of name field isn't allowed.")
        opacity: 0
    }
    Text {
        id: surnameErrorText
        text: qsTr("Content of surname field isn't allowed.")
        opacity: 0
    }
    Text {
        id: usernameErrorText
        text: qsTr("Content of username field isn't allowed.")
        opacity: 0
    }
    Text {
        id: passwordErrorText
        text: qsTr("Content of password field isn't allowed.")
        opacity: 0
    }
    Text {
        id: verifyPasswordErrorText
        text: qsTr("Passwords don't match.")
        opacity: 0
    }
    Text {
        id: verificationErrorText
        text: qsTr("This username is already taken.")
        opacity: 0
    }
    Text {
        id: currentErrorText
        text: qsTr("")
        opacity: 0
    }
    Label {
        id: errorNameLabel
        anchors.top: loginButton.bottom
        anchors.horizontalCenter: registrationButton.horizontalCenter
        anchors.topMargin: 20
        text: ""
        color: "#E93E3E"
        opacity: 0
    }
    ParallelAnimation {
        id: errorOn
        PropertyAnimation {
            target: errorNameLabel
            properties: "text"
            to: currentErrorText.text
            duration: 1
        }
        PropertyAnimation {
            target: errorNameLabel
            properties: "opacity"
            from: 0
            to: 1
            duration: 700
        }
    }
    PropertyAnimation {
        id: errorOff
        target: errorNameLabel
        properties: "opacity"
        to: 0
        duration: 700
    }
}


