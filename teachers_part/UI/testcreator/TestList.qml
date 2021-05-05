import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.15

import "qrc:/UI"

import Test 1.0

Rectangle {
    id: testRectangle
    anchors.fill: parent
    Rectangle {
        id: viewRectangle
        width: parent.width
        height: parent.height * 0.8
        color: parent.color
        ListView {
            id: view
            anchors.fill: parent
            spacing: 10
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            clip: true
            model: TestModel {
                id: testModelInstance
                list: testList
            }
            delegate: Column {
                id: col
                width: parent.width
                spacing: 10
                property var stringList: model.answers
                Row {
                    CheckBox {
                        checked: model.check
                        onClicked: model.check = checked
                        indicator.width: 25
                        indicator.height: 25
                        onCheckedChanged: {
                            if(checked && questionTitle.text !== qsTr("Питання 1:"))
                            {
                                removeButtonOn.start();
                            }
                            else
                            {
                                removeButtonOff.start();
                            }
                        }
                    }
                    Text {
                        id: questionTitle
                        anchors.top: parent.top
                        anchors.topMargin: 6
                        text: qsTr("Питання " + (index + 1) + ":")
                        color: "#6F61AE"
                        font.bold: true
                        font.pixelSize: 22
                        font.family: LoginConstants.font.family

                    }
                }
                TextField {
                    text: model.question
                    onEditingFinished: model.question = text
                    width: parent.width * 0.95
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                    color: "#000000"
                    placeholderTextColor: "#3C3C3C"
                    placeholderText: qsTr("Введіть запитання")
                    font.bold: true
                    opacity: 0.75
                    font.pixelSize: 16
                    font.family: LoginConstants.font.family
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
                                anchors.fill: parent
                                glowRadius: 10
                                spread: 0.2
                                color: "#FF7C7C"
                                cornerRadius: parent.radius
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
                ListView {
                    id: answersListView
                    width: parent.width * 0.9
                    height: 345
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    model: col.stringList
                    interactive: false
                    spacing: 10
                    delegate: Column {
                        spacing: 10
                        Text {
                            text: qsTr("Відповідь " + (index + 1) + ":")
                            color: "#313131"
                            font.bold: true
                            font.pixelSize: 17
                            font.family: LoginConstants.font.family
                        }
                        TextField {
                            id: answerField
                            width: answersListView.width
                            text: model.modelData
                            onEditingFinished: model.modelData = text
                            color: "#000000"
                            placeholderTextColor: "#3C3C3C"
                            placeholderText: qsTr("Введіть варіант відповіді")
                            font.bold: true
                            opacity: 0.75
                            font.pixelSize: 16
                            font.family: LoginConstants.font.family
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
                Text {
                    id: correctAnswerTitle
                    text: qsTr("Правильна відповідь:")
                    color: "#313131"
                    font.bold: true
                    font.pixelSize: 17
                    font.family: LoginConstants.font.family
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                }
                TextField {
                    id: correctAnswerField
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    width: parent.width * 0.9
                    text: model.correctAnswer
                    onEditingFinished: model.correctAnswer = text
                    color: "#000000"
                    placeholderTextColor: "#3C3C3C"
                    placeholderText: qsTr("Введіть правильну відповідь (повністю)")
                    font.bold: true
                    opacity: 0.75
                    font.pixelSize: 16
                    font.family: LoginConstants.font.family
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
                Text {
                    text: qsTr("Посилання на правильну відповідь:")
                    color: "#313131"
                    font.bold: true
                    font.pixelSize: 17
                    font.family: LoginConstants.font.family
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                }
                TextField {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    width: parent.width * 0.9
                    text: model.linkToText
                    onEditingFinished: model.linkToText = text
                    color: "#000000"
                    placeholderTextColor: "#3C3C3C"
                    placeholderText: qsTr("Вставте текст з лекції, котрий містить правильну відповідь")
                    font.bold: true
                    opacity: 0.75
                    font.pixelSize: 16
                    font.family: LoginConstants.font.family
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
                                id: emptyCorrectAnswerLinkFieldErrorOn
                                PropertyAnimation {
                                    target: correctAnswerLinkFieldGlowBorder
                                    properties: "opacity"
                                    from: 0
                                    to: 0.7
                                    duration: 700
                                }
                            }
                            SequentialAnimation {
                                id: emptyCorrectAnswerLinkFieldErrorOff
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
            ScrollBar.vertical: ScrollBar {}
        }
    }
    Column {
        id: testButtons
        width: parent.width
        height: 200
        anchors.top: viewRectangle.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 10
        spacing: 10
        LoginButton {
            id: saveTestButton
            width: parent.width * 0.36
            text: qsTr("ЗБЕРЕГТИ ТЕСТ")
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.3
//                onClicked: testList.appendItem();
        }
        Row {
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: width * 0.1
            spacing: width * 0.05
            LoginButton {
                width: parent.width * 0.36
                text: qsTr("ДОДАТИ ПИТАННЯ")
                onClicked: testList.appendItem();
            }
            LoginButton {
                id: removeButton
                width: parent.width * 0.36
                text: qsTr("ВИДАЛИТИ ПИТАННЯ")
                onClicked: {
                    testList.removeCompletedItems();
                    removeButtonOff.start();
                }
                enabled: false
            }
        }
    }
    PropertyAnimation {
        id: removeButtonOn
        target: removeButton
        property: "enabled"
        to: true
    }
    PropertyAnimation {
        id: removeButtonOff
        target: removeButton
        property: "enabled"
        to: false
    }
}
