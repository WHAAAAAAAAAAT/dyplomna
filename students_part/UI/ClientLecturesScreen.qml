import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import Controllers 1.0

import "qrc:/UI/courses"

ApplicationWindow {
    id: windowLectures
    width: 1280
    height: 720
    signal exitWindowLectures

    property int numberOfQuestion: 2
    property int numberOfAnswers: 4

    Rectangle {
        id: listOfCourses
        anchors.left: windowLectures.left
        width: windowLectures.width * 0.2
        height: windowLectures.height
        color: '#B2A1F1'
        visible: true
        Text {
            id: leftSidebarTitle
            text: qsTr("МОЇ КУРСИ:")
            color: "#FFFFFF"
            font.bold: true
            anchors.top: parent.top
            anchors.left: parent.left
            font.pixelSize: 25
            anchors.topMargin: 10
            anchors.leftMargin: 20
            font.family: ClientLoginConstants.font.family
        }

        Rectangle {
            id: coursesListRect
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: findCourseButton.top
            anchors.bottomMargin: 15
            anchors.top: leftSidebarTitle.bottom
            anchors.topMargin: 20
            color: parent.color

            CourseList {
                id: coursesList
                anchors.fill: parent
                color: parent.color
                visible: true
            }
        }

        ClientLoginButton {
            id: findCourseButton
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 40
            width: parent.width * 0.75
            opacity: 1
            text: qsTr("ЗНАЙТИ НОВИЙ КУРС")
            Connections {
                target: findCourseButton
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
                        lecturesWindow.hide()
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
                    lecturesWindow.hide()
                    testWindow.show()
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

    LectureController {
        id: controller
        Component.onCompleted: {
            setDocument(lecturesView.textDocument)
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


    //test creator
    /*Rectangle {
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
            anchors.leftMargin: testCreator.width * 0.05
            font.family: ClientLoginConstants.font.family
        }
        ClientRegistrationButton {
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
            anchors.left: rightSidebarTitle.left
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.topMargin: 37
            anchors.bottomMargin: 25
            color: '#F6F6F6'
            opacity: 1
            ScrollView {
                anchors.fill: parent
                clip: true
                Column {
                    spacing: 13
                    Repeater {
                        model: numberOfQuestion
                        Column {
                            spacing: 13
                            Text {
                                id: questionNameTitle
                                text: qsTr("Question " + (index + 1) + ":")
                                color: "#6F61AE"
                                font.bold: true
                                font.pixelSize: 19
                                font.family: ClientLoginConstants.font.family
                            }
                            TextField {
                                id: questionNameField
                                width: testCreator.width * 0.9
                                text: ""
                                color: "#000000"
                                placeholderTextColor: "#3C3C3C"
                                placeholderText: qsTr("Enter a question here")
                                font.bold: true
                                opacity: 0.75
                                font.pixelSize: 16
                                font.family: ClientLoginConstants.font.family
                                horizontalAlignment: Text.AlignLeft
                                background: Rectangle {
                                    implicitWidth: parent.width
                                    implicitHeight: 47
                                    border.color: "#6D6D6D"
                                    border.width: 1
                                    radius: 10
                                    Rectangle {
                                        id: questionNameFieldGlowBorder
                                        width: parent.width
                                        height: parent.height
                                        opacity: 0
                                        radius: parent.radius
                                        RectangularGlow {
                                            anchors.fill: questionNameFieldGlowBorder
                                            glowRadius: 10
                                            spread: 0.2
                                            color: "#FF7C7C"
                                            cornerRadius: questionNameFieldGlowBorder.radius
                                        }
                                        SequentialAnimation {
                                            id: emptyQuestionNameFieldErrorOn
                                            PropertyAnimation {
                                                target: questionNameFieldGlowBorder
                                                properties: "opacity"
                                                from: 0
                                                to: 0.7
                                                duration: 700
                                            }
                                        }
                                        SequentialAnimation {
                                            id: emptyQuestionNameFieldErrorOff
                                            PropertyAnimation {
                                                target: questionNameFieldGlowBorder
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
                                selectByMouse: true
                                selectionColor: "#9E7ECE"
                            }
                            Repeater {
                                model: numberOfAnswers
                                Column {
                                    anchors.left: parent.left
                                    anchors.leftMargin: parent.width * 0.05
                                    spacing: 13
                                    Text {
                                        id: answerTitle
                                        text: qsTr("Answer " + (index + 1) + ":")
                                        color: "#313131"
                                        font.bold: true
                                        font.pixelSize: 17
                                        font.family: ClientLoginConstants.font.family
                                    }
                                    TextField {
                                        id: answerField
                                        width: testCreator.width * 0.85
                                        text: ""
                                        color: "#000000"
                                        placeholderTextColor: "#3C3C3C"
                                        placeholderText: qsTr("Enter an answer here")
                                        font.bold: true
                                        opacity: 0.75
                                        font.pixelSize: 16
                                        font.family: ClientLoginConstants.font.family
                                        horizontalAlignment: Text.AlignLeft
                                        background: Rectangle {
                                            implicitWidth: parent.width
                                            implicitHeight: 47
                                            border.color: "#6D6D6D"
                                            border.width: 1
                                            radius: 10
                                            Rectangle {
                                                id: answerFieldGlowBorder
                                                width: parent.width
                                                height: parent.height
                                                opacity: 0
                                                radius: parent.radius
                                                RectangularGlow {
                                                    anchors.fill: parent
                                                    glowRadius: 10
                                                    spread: 0.2
                                                    color: "#FF7C7C"
                                                    cornerRadius: parent.radius
                                                }
                                                SequentialAnimation {
                                                    id: emptyFirstAnswerFieldErrorOn
                                                    PropertyAnimation {
                                                        target: answerFieldGlowBorder
                                                        properties: "opacity"
                                                        from: 0
                                                        to: 0.7
                                                        duration: 700
                                                    }
                                                }
                                                SequentialAnimation {
                                                    id: emptyFirstAnswerFieldErrorOff
                                                    PropertyAnimation {
                                                        target: answerFieldGlowBorder
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
                                        selectByMouse: true
                                        selectionColor: "#9E7ECE"
                                    }
                                }
                            }
                            Text{
                                id: correctAnswerTitle
                                text: qsTr("Correct answer:")
                                color: "#313131"
                                font.bold: true
                                font.pixelSize: 17
                                font.family: ClientLoginConstants.font.family
                                anchors.left: parent.left
                                anchors.leftMargin: parent.width * 0.05
                            }
                            TextField {
                                id: correctAnswerField
                                anchors.left: parent.left
                                anchors.leftMargin: parent.width * 0.05
                                width: testCreator.width * 0.85
                                text: ""
                                color: "#000000"
                                placeholderTextColor: "#3C3C3C"
                                placeholderText: qsTr("Enter a correct answer here")
                                font.bold: true
                                opacity: 0.75
                                font.pixelSize: 16
                                font.family: ClientLoginConstants.font.family
                                horizontalAlignment: Text.AlignLeft
                                background: Rectangle {
                                    implicitWidth: parent.width
                                    implicitHeight: 47
                                    border.color: "#6D6D6D"
                                    border.width: 1
                                    radius: 10
                                    Rectangle {
                                        id: correctAnswerFieldGlowBorder
                                        width: parent.width
                                        height: parent.height
                                        opacity: 0
                                        radius: parent.radius
                                        RectangularGlow {
                                            anchors.fill: parent
                                            glowRadius: 10
                                            spread: 0.2
                                            color: "#FF7C7C"
                                            cornerRadius: parent.radius
                                        }
                                        SequentialAnimation {
                                            id: emptyCorrectAnswerFieldErrorOn
                                            PropertyAnimation {
                                                target: correctAnswerFieldGlowBorder
                                                properties: "opacity"
                                                from: 0
                                                to: 0.7
                                                duration: 700
                                            }
                                        }
                                        SequentialAnimation {
                                            id: emptyCorrectAnswerFieldErrorOff
                                            PropertyAnimation {
                                                target: correctAnswerFieldGlowBorder
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
                                selectByMouse: true
                                selectionColor: "#9E7ECE"
                            }

                            Text{
                                id: correctAnswerLinkTitle
                                text: qsTr("Link to the correct answer:")
                                color: "#313131"
                                font.bold: true
                                font.pixelSize: 17
                                font.family: ClientLoginConstants.font.family
                                anchors.left: parent.left
                                anchors.leftMargin: parent.width * 0.05
                            }
                            TextField {
                                id: correctAnswerLinkField
                                anchors.left: parent.left
                                anchors.leftMargin: parent.width * 0.05
                                width: testCreator.width * 0.85
                                text: ""
                                color: "#000000"
                                placeholderTextColor: "#3C3C3C"
                                placeholderText: qsTr("Enter here a text from the lecture where the correct answer is")
                                font.bold: true
                                opacity: 0.75
                                font.pixelSize: 16
                                font.family: ClientLoginConstants.font.family
                                horizontalAlignment: Text.AlignLeft
                                background: Rectangle {
                                    implicitWidth: parent.width
                                    implicitHeight: 47
                                    border.color: "#6D6D6D"
                                    border.width: 1
                                    radius: 10
                                    Rectangle {
                                        id: correctAnswerLinkFieldGlowBorder
                                        width: parent.width
                                        height: parent.height
                                        opacity: 0
                                        radius: parent.radius
                                        RectangularGlow {
                                            anchors.fill: parent
                                            glowRadius: 10
                                            spread: 0.2
                                            color: "#FF7C7C"
                                            cornerRadius: parent.radius
                                        }
                                        SequentialAnimation {
                                            id: emptyCcorrectAnswerLinkFieldErrorOn
                                            PropertyAnimation {
                                                target: correctAnswerLinkFieldGlowBorder
                                                properties: "opacity"
                                                from: 0
                                                to: 0.7
                                                duration: 700
                                            }
                                        }
                                        SequentialAnimation {
                                            id: emptyCcorrectAnswerLinkFieldErrorOff
                                            PropertyAnimation {
                                                target: correctAnswerLinkFieldGlowBorder
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
                                selectByMouse: true
                                selectionColor: "#9E7ECE"
                            }
                        }
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
    }*/

    ClientTestScreen {
        id: testWindow
        title: qsTr("CPPLearn/Courses/Test")

        onExitWindowTests: {
            testWindow.hide()
            lecturesWindow.show()
        }
    }

}
