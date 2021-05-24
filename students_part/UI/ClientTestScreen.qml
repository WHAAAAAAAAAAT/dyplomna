import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import Models 1.0
import Controllers 1.0

Window {
    id: windowTests
    width: 1280
    height: 720
    color: "#FCFCFC"
    signal exitWindowTests

    property string lecName: ""
    property string courseName: ""

    property int currentQuestionNumber: 0
    property string currentQuestion: qsTr("")
    property string firstAnswer: qsTr("");
    property string secondAnswer: qsTr("");
    property string thirdAnswer: qsTr("");
    property string fourthAnswer: qsTr("");

    TestController {
        id: testControlles
    }

    function setTask()
    {
        if(currentQuestionNumber < TestModel.getTestSize())
        {
            currentQuestion = TestModel.getTestQuestion(currentQuestionNumber)
            firstAnswer = TestModel.getTestAnswerA(currentQuestionNumber)
            secondAnswer = TestModel.getTestAnswerB(currentQuestionNumber)
            thirdAnswer = TestModel.getTestAnswerC(currentQuestionNumber)
            fourthAnswer = TestModel.getTestAnswerD(currentQuestionNumber)
        }
        else {
            testControlles.saveTestList(lecName, courseName)

            var component = Qt.createComponent("TestResultScreen.qml")
            if( component.status !== Component.Ready )
            {
                if( component.status === Component.Error )
                    console.debug("Error:"+ component.errorString());
                return;
            }
            var resultWindow = component.createObject(windowTests)
            resultWindow.title = qsTr("CPPLearn/Courses/Test/Results")
            windowTests.hide()
            windowMenu.show()
            resultWindow.show()
        }
    }

    Rectangle {
        id: header
        anchors.top: parent.top
        width: parent.width
        height: 50
        color: '#F0F0F0'
        visible: true

        ClientRegistrationButton {
            id: goBackButton
            width: header.width * 0.3
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: width * 0.05
            fontSize: 20
            text: qsTr("Залишити тест і повернутись до лекції")
            font.bold: true
            Connections {
                target: goBackButton
                function onClicked() {
                    windowTests.hide()
                    windowLectures.show()
                }
            }
        }
    }

    Rectangle {
        id: mainBody
        anchors.top: header.bottom
        anchors.bottom: footer.top
        anchors.bottomMargin: parent.height * 0.45
        width: parent.width
        Text {
            id: questionNumber
            text: qsTr("ПИТАННЯ " + (currentQuestionNumber + 1))
            color: "#0E0E0E"
            font.bold: true
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 27
            font.family: ClientLoginConstants.font.family
        }
        Text {
            id: testsView
            text: currentQuestion
            color: "#272727"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: questionNumber.bottom
            anchors.topMargin: parent.height * 0.3
            font.pixelSize: 25
            font.family: "Corbel"
        }
        Component.onCompleted: {
            currentQuestionNumber = 0
            setTask()
        }
    }

    Rectangle {
        id: answersButtons
        anchors.bottom: footer.top
        width: parent.width
        height: parent.height * 0.45
        Grid {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 2
            rows: 2
            spacing: parent.height * 0.05
            ClientAnswerButton {
                id: firstAnswerButton
                text: qsTr("➊   " + firstAnswer)
                width: answersButtons.width * 0.4
                height: answersButtons.height * 0.45
                onClicked: {
                    TestModel.setAnswer(currentQuestion, firstAnswer)
                    currentQuestionNumber = currentQuestionNumber + 1;
                    setTask();
                }
            }
            ClientAnswerButton {
                id: secondAnswerButton
                text: qsTr("➋   " + secondAnswer)
                buttonColor: "#30D4AF"
                width: answersButtons.width * 0.4
                height: answersButtons.height * 0.45
                onClicked: {
                    TestModel.setAnswer(currentQuestion, secondAnswer)
                    currentQuestionNumber = currentQuestionNumber + 1;
                    setTask();
                }
            }
            ClientAnswerButton {
                id: thirdAnswerButton
                text: qsTr("➌   " + thirdAnswer)
                buttonColor: "#F66298"
                width: answersButtons.width * 0.4
                height: answersButtons.height * 0.45
                onClicked: {
                    TestModel.setAnswer(currentQuestion, thirdAnswer)
                    currentQuestionNumber = currentQuestionNumber + 1;
                    setTask();
                }
            }
            ClientAnswerButton {
                id: fourthAnswerButton
                text: qsTr("➍   " + fourthAnswer)
                buttonColor: "#5DA2EE"
                width: answersButtons.width * 0.4
                height: answersButtons.height * 0.45
                onClicked: {
                    TestModel.setAnswer(currentQuestion, fourthAnswer)
                    currentQuestionNumber = currentQuestionNumber + 1;
                    setTask();
                }
            }
        }
    }
    Rectangle {
        id: footer
        anchors.bottom: parent.bottom
        width: parent.width
        height: 100
    }
}
